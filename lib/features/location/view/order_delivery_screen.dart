import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            child: Container(
              color: AppColors.gray200,
              width: double.infinity,
              child: const Center(
                    child: Text('Map View Placeholder', style: TextStyle(color: AppColors.gray500)),
              ),
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
                         // Show payment collection or photo proof screen
                         context.go(RouteConstants.homeScreen);
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
}
