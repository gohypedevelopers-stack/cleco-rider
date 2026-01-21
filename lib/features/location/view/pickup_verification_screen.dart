import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PickupVerificationScreen extends StatefulWidget {
  const PickupVerificationScreen({super.key});

  @override
  State<PickupVerificationScreen> createState() => _PickupVerificationScreenState();
}

class _PickupVerificationScreenState extends State<PickupVerificationScreen> {
  // Mock data representing items to verify
  final List<Map<String, dynamic>> _itemsToVerify = [
    {
      'name': 'Men\'s Shirt',
      'service': 'Wash & Iron',
      'qty': 2,
      'image': 'assets/images/shirt_stain.jpg', // Placeholder
      'verified': false,
    },
    {
      'name': 'Trousers',
      'service': 'Dry Clean',
      'qty': 1,
      'image': 'assets/images/trousers.jpg', // Placeholder
      'verified': false,
    },
    {
      'name': 'Silk Saree',
      'service': 'Dry Clean',
      'qty': 1,
      'image': 'assets/images/saree.jpg', // Placeholder
      'verified': false,
    },
  ];

  bool get _allVerified => _itemsToVerify.every((item) => item['verified'] == true);

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
              itemCount: _itemsToVerify.length + 1, // +1 for header info
              itemBuilder: (context, index) {
                if (index == 0) {
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
                              'Please verify each item against the customer\'s order before completing pickup.',
                              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final itemIndex = index - 1;
                final item = _itemsToVerify[itemIndex];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: item['verified'] ? AppColors.success : AppColors.gray200,
                      width: item['verified'] ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CheckboxListTile(
                    value: item['verified'],
                    activeColor: AppColors.success,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    onChanged: (val) {
                      setState(() {
                         item['verified'] = val!;
                      });
                    },
                    secondary: GestureDetector(
                      onTap: () => _showImageDialog(context, item['image']),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(item['image']),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                               // Fallback handled by child
                            },
                          ),
                        ),
                        child: item['image'].toString().isEmpty 
                            ? const Icon(Icons.image, color: AppColors.gray400)
                            : null, 
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${item['service']} • Qty: ${item['qty']}'),
                        /* 
                         * Add visual cue for issues if needed 
                         * e.g. Text('⚠ Has Stains', style: TextStyle(color: Colors.red))
                         */
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom Action
          Container(
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
              label: 'Complete Verification',
              onPressed: _allVerified 
                ? () {
                    // Navigate to next step or finish
                    _showSuccessDialog();
                  } 
                : () {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Please verify all items first')),
                   );
                },
              color: _allVerified ? AppColors.primary : AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Pickup Verified!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Navigate to drop location now.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.gray600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Start Delivery',
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  context.pushReplacement(RouteConstants.orderDeliveryScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10), // Reduced padding for larger view
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Interactive Image Viewer
            Container(
              constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 64, color: AppColors.gray400),
                            SizedBox(height: 16),
                            Text(
                              'Image not available',
                              style: TextStyle(color: AppColors.gray600),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            
            // Close Button
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
