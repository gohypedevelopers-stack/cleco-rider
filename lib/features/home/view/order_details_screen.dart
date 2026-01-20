import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/custom_outlined_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #20240',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.statusInProgress.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'In Progress',
                    style: TextStyle(
                      color: AppColors.statusInProgress,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Customer Info
            _buildSectionHeader('Customer Details'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.gray200,
                    child: Icon(Icons.person, color: AppColors.gray600),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Rahul Sharma',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+91 98765 43210',
                          style: TextStyle(color: AppColors.gray500),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _makePhoneCall('9876543210'),
                    icon: const Icon(Icons.phone, color: AppColors.primary),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Route Info
            _buildSectionHeader('Route'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Column(
                children: [
                   _buildLocationRow(
                    isPickup: true,
                    title: 'Pickup Location',
                    address: 'H.No 55, Green Park, New Delhi',
                    time: '10:00 AM',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 30,
                        width: 2,
                        color: AppColors.gray300,
                      ),
                    ),
                  ),
                  _buildLocationRow(
                    isPickup: false,
                    title: 'Delivery Location',
                    address: 'Laundry Hub, Sector 18, Noida',
                    time: '11:00 AM',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Items Info
            _buildSectionHeader('Items (3)'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Column(
                children: [
                  _buildItemRow('Men\'s Shirt', '2', 'Wash & Iron'),
                  const Divider(height: 24),
                  _buildItemRow('Trousers', '1', 'Dry Clean'),
                ],
              ),
            ),
            const SizedBox(height: 24),

             // Payment Info
            _buildSectionHeader('Payment'),
            const SizedBox(height: 12),
             Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Estimated Earnings', style: TextStyle(color: AppColors.gray600)),
                   Text(
                    '₹ 85.00',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 40),

            // Actions
            CustomElevatedButton(
              label: 'Start Pickup',
              icon: const Icon(Icons.navigation, color: Colors.white),
              onPressed: () {
                 context.push(RouteConstants.orderPickupScreen);
              },
            ),
            const SizedBox(height: 16),
            CustomOutlinedButton(
              label: 'Cancel Order',
              onPressed: () {},
              textColor: AppColors.error,
              borderColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildLocationRow({
    required bool isPickup,
    required String title,
    required String address,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 24,
          color: isPickup ? AppColors.primary : AppColors.error,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.gray500,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String name, String qty, String service) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.checkroom, color: AppColors.gray600, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                service,
                style: const TextStyle(color: AppColors.gray500, fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          'x$qty',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
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
