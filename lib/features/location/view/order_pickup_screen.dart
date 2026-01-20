import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPickupScreen extends StatelessWidget {
  const OrderPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pickup',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Map Placeholder (Top Half)
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: AppColors.gray200,
                  width: double.infinity,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 64, color: AppColors.gray400),
                        SizedBox(height: 8),
                        Text('Map View Placeholder', style: TextStyle(color: AppColors.gray500)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.white,
                    child: const Icon(Icons.my_location, color: AppColors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          
          // Action & Info Panel (Bottom Half)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Navigating to Pickup',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('2.5 km • 15 mins', style: TextStyle(color: AppColors.gray500)),
                        ],
                      ),
                      IconButton(
                        onPressed: () => _openMaps('H.No 123, Street 4, New Delhi'), // Pseudo location
                        icon: const Icon(Icons.directions, color: AppColors.primary),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  
                  // Customer mini detail
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rahul Sharma', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Order #20240', style: TextStyle(fontSize: 12, color: AppColors.gray500)),
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
                  
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      label: 'Arrived at Location',
                      onPressed: () {
                         // Logic to confirm arrival -> Show verify OTP or items check
                         // For now, confirm items
                         _showConfirmItemsDialog(context);
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

  void _showConfirmItemsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Pickup'),
        content: const Text('Have you collected all items listed in the order?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
            onPressed: () {
               Navigator.pop(context);
               context.go(RouteConstants.homeScreen); // Simulating completion loop for now
            }, 
            child: const Text('Yes, Confirm'),
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

  Future<void> _openMaps(String address) async {
    // google maps intent
  }
}
