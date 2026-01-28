import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/map_widget.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDeliveryScreen extends StatelessWidget {
  const OrderDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Delivery',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            flex: 4,
            child: MapWidget(
              initialCenter: const LatLng(28.5700, 77.3200), // Example: Sec 18 Noida
              markers: [
                Marker(
                  point: const LatLng(28.5700, 77.3200),
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.store, color: AppColors.primary, size: 40),
                ),
              ],
            ),
          ),
          
          // Action Panel
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Navigating to Drop Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Laundry Hub, Sector 18, Noida', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('4.2 km • 20 mins', style: TextStyle(color: AppColors.gray500)),
                  
                  const Divider(height: 32),
                   // Vendor/Customer mini detail
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(Icons.store, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Laundry Hub', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Drop Order #20240', style: TextStyle(fontSize: 12, color: AppColors.gray500)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _makePhoneCall('9876543210'),
                        icon: const Icon(Icons.phone),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                   SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      label: 'Arrived at Drop Location',
                      onPressed: () {
                         _showDeliveryConfirmation(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void _showDeliveryConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delivery'),
        content: const Text('Have you handed over the package to the customer or left it at the designated safe place?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Navigate to Success / Home
              _showSuccessDialog(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
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
              'Order Delivered!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Great job! You earned ₹85 for this order.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.gray600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Back to Home',
                onPressed: () {
                  context.go(RouteConstants.homeScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
