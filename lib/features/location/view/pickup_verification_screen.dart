import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ItemStatus { pending, verified, flagged, rejected }

class PickupVerificationScreen extends StatefulWidget {
  const PickupVerificationScreen({super.key});

  @override
  State<PickupVerificationScreen> createState() => _PickupVerificationScreenState();
}

class _PickupVerificationScreenState extends State<PickupVerificationScreen> {
  // Enhanced Mock Data with Multiple Images
  final List<Map<String, dynamic>> _orderItems = [
    {
      'name': 'Men\'s Shirt',
      'service': 'Wash & Iron',
      'qty': 2,
      'images': [
        'assets/images/shirt_stain.jpg',
        'assets/images/shirt_back.jpg', // Hypothetical extra image
      ],
    },
    {
      'name': 'Trousers',
      'service': 'Dry Clean',
      'qty': 1,
      'images': ['assets/images/trousers.jpg'],
    },
    {
      'name': 'Silk Saree',
      'service': 'Dry Clean',
      'qty': 1,
      'images': [
        'assets/images/saree.jpg',
        'assets/images/saree_pallu.jpg',
        'assets/images/saree_border.jpg',
      ],
    },
  ];

  late List<Map<String, dynamic>> _individualItemsToCheck;

  @override
  void initState() {
    super.initState();
    _generateChecklist();
  }

  void _generateChecklist() {
    _individualItemsToCheck = [];
    for (var item in _orderItems) {
      int quantity = item['qty'];
      List<String> images = item['images'] as List<String>;
      
      for (int i = 1; i <= quantity; i++) {
        // If there are images, create a card for EACH image
        if (images.isNotEmpty) {
          for (int imgIdx = 0; imgIdx < images.length; imgIdx++) {
            _individualItemsToCheck.add({
              'name': item['name'],
              'service': item['service'],
              'display_image': images[imgIdx], // Single image for this card
              'item_index': i,
              'item_total': quantity,
              'image_index': imgIdx + 1,
              'image_total': images.length,
              'status': ItemStatus.pending,
              'issue': '',
            });
          }
        } else {
          // Fallback: If no images, create 1 card per item quantity
          _individualItemsToCheck.add({
            'name': item['name'],
            'service': item['service'],
            'display_image': '', 
            'item_index': i,
            'item_total': quantity,
            'image_index': 0,
            'image_total': 0,
            'status': ItemStatus.pending,
            'issue': '',
          });
        }
      }
    }
  }

  bool get _allHandled => _individualItemsToCheck.every((item) => item['status'] != ItemStatus.pending);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Verify Pickup',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _individualItemsToCheck.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader();
                }

                final itemIndex = index - 1;
                final item = _individualItemsToCheck[itemIndex];
                return _buildVerificationCard(item);
              },
            ),
          ),
          
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.primary),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Verify images carefully. Flag any damage or reject incorrect items.',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationCard(Map<String, dynamic> item) {
    Color borderColor = AppColors.gray200;
    Color statusColor = Colors.transparent;
    IconData? statusIcon;
    
    switch (item['status'] as ItemStatus) {
      case ItemStatus.verified:
        borderColor = AppColors.success;
        statusColor = AppColors.success.withOpacity(0.1);
        statusIcon = Icons.check_circle;
        break;
      case ItemStatus.flagged:
        borderColor = Colors.amber;
        statusColor = Colors.amber.withOpacity(0.1);
        statusIcon = Icons.warning;
        break;
      case ItemStatus.rejected:
        borderColor = AppColors.error;
        statusColor = AppColors.error.withOpacity(0.1);
        statusIcon = Icons.cancel;
        break;
      case ItemStatus.pending:
      default:
        borderColor = AppColors.gray200;
        break;
    }

    String displayImage = item['display_image'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: item['status'] != ItemStatus.pending ? 2 : 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Single Image Thumbnail
                GestureDetector(
                  onTap: () => displayImage.isNotEmpty ? _showSingleImageDialog(context, displayImage) : null,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.gray200),
                      image: displayImage.isNotEmpty
                          ? DecorationImage(
                              image: AssetImage(displayImage),
                              fit: BoxFit.cover,
                              onError: (_, __) {},
                            )
                          : null,
                    ),
                    child: displayImage.isEmpty ? const Icon(Icons.image_not_supported, color: AppColors.gray400) : null,
                  ),
                ),
                const SizedBox(width: 12),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(item['service'], style: const TextStyle(color: AppColors.gray600, fontSize: 12)),
                      const SizedBox(height: 4),
                       Wrap(
                         spacing: 4,
                         children: [
                           Container(
                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                             decoration: BoxDecoration(color: AppColors.gray100, borderRadius: BorderRadius.circular(4)),
                             child: Text(
                               'Item ${item['item_index']}/${item['item_total']}',
                               style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.gray700),
                             ),
                           ),
                           if (item['image_total'] > 0)
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                               decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                               child: Text(
                                 'Image ${item['image_index']} of ${item['image_total']}',
                                 style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary),
                               ),
                             ),
                         ],
                       ),
                       if (item['issue'] != null && item['issue'].toString().isNotEmpty)
                         Padding(
                           padding: const EdgeInsets.only(top: 4.0),
                           child: Text(
                             'Note: ${item['issue']}',
                             style: const TextStyle(color: AppColors.error, fontSize: 11, fontStyle: FontStyle.italic),
                           ),
                         ),
                    ],
                  ),
                ),
                
                // Status Icon
                if (statusIcon != null)
                  Icon(statusIcon, color: borderColor),
              ],
            ),
          ),
          
          // Action Buttons (Only if Pending)
          if (item['status'] == ItemStatus.pending)
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.gray100)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _showIssueDialog(item),
                      icon: const Icon(Icons.flag_outlined, color: Colors.amber, size: 20),
                      label: const Text('Report Issue', style: TextStyle(color: Colors.amber)),
                    ),
                  ),
                  Container(width: 1, height: 48, color: AppColors.gray100),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() => item['status'] = ItemStatus.verified);
                      },
                      icon: const Icon(Icons.check, color: AppColors.success, size: 20),
                      label: const Text('Verify', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          else 
            // Reset Button for handled items
            Container(
               width: double.infinity,
               height: 40,
               decoration: BoxDecoration(
                 color: statusColor,
                 borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
               ),
               alignment: Alignment.center,
               child: TextButton(
                 onPressed: () {
                   setState(() {
                     item['status'] = ItemStatus.pending;
                     item['issue'] = '';
                   });
                 },
                 style: TextButton.styleFrom(
                   minimumSize: const Size.fromHeight(40),
                   padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 ),
                 child: Text('Undo', style: TextStyle(color: borderColor, fontSize: 12)),
               ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: CustomElevatedButton(
        label: 'Complete Verification (${_individualItemsToCheck.where((e) => e['status'] != ItemStatus.pending).length}/${_individualItemsToCheck.length})',
        onPressed: _allHandled 
          ? _showCompletionDialog
          : null,
        color: _allHandled ? AppColors.primary : AppColors.gray300,
      ),
    );
  }

  void _showIssueDialog(Map<String, dynamic> item) {
    final issueController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Issue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What is wrong with this item?', style: TextStyle(color: AppColors.gray600)),
            const SizedBox(height: 16),
            TextField(
              controller: issueController,
              decoration: const InputDecoration(
                hintText: 'e.g. Stains, Torn, Wrong Color...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (issueController.text.isEmpty) return;
                      Navigator.pop(context);
                      setState(() {
                        item['status'] = ItemStatus.flagged;
                        item['issue'] = issueController.text;
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.white),
                    child: const Text('Flag Damage'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (issueController.text.isEmpty) return;
                      Navigator.pop(context);
                      setState(() {
                        item['status'] = ItemStatus.rejected;
                        item['issue'] = issueController.text;
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.error, foregroundColor: Colors.white),
                    child: const Text('Reject Item'),
                  ),
                ),
              ],
            ),
             const SizedBox(height: 12),
             TextButton(
               onPressed: () => Navigator.pop(context),
               child: const Center(child: Text('Cancel', style: TextStyle(color: AppColors.gray500))),
             ),
          ],
        ),
      ),
    );
  }

  void _showSingleImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close), 
                  onPressed: () => Navigator.pop(context)
                ),
              ),
              Expanded(
                child: InteractiveViewer(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCompletionDialog() {
    int rejectedCount = _individualItemsToCheck.where((e) => e['status'] == ItemStatus.rejected).length;
    int flaggedCount = _individualItemsToCheck.where((e) => e['status'] == ItemStatus.flagged).length;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Ready for Pickup?'),
        content: Text(
          'Summary:\n'
          '• ${rejectedCount} Rejected\n'
          '• ${flaggedCount} Flagged\n'
          '• ${_individualItemsToCheck.length - rejectedCount - flaggedCount} Verified\n\n'
          'Proceed to drop location?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Review')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushReplacement(RouteConstants.orderDeliveryScreen);
            },
            child: const Text('Confirm Pickup'),
          ),
        ],
      ),
    );
  }
}
