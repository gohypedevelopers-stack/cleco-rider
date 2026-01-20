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
    // Enhanced Mock Data
    final orderData = {
      'id': '#ORD-2024-8921',
      'status': 'Pending Pickup',
      'customer': {
        'name': 'Rahul Sharma',
        'phone': '+91 98765 43210',
        'rating': '4.8',
        'address': 'Flat 402, Krishna Heights, Sector 18, Noida, Uttar Pradesh',
      },
      'schedule': {
        'pickup': 'Today, 10:00 AM - 11:00 AM',
        'delivery': 'Tomorrow, 06:00 PM - 07:00 PM',
      },
      'uploads': [
        {
          'image': 'assets/images/shirt_stain.jpg', // Placeholder logic handled below
          'issue': 'Stain on collar',
          'packaging': 'Hanger',
          'type': 'Shirt'
        },
        {
          'image': 'assets/images/trousers.jpg',
          'issue': 'None',
          'packaging': 'Fold',
          'type': 'Trousers'
        },
         {
          'image': 'assets/images/saree.jpg',
          'issue': 'Delicate Fabric',
          'packaging': 'Special Box',
          'type': 'Silk Saree'
        },
      ],
      'items': [
        {'name': 'Men\'s Shirt', 'service': 'Wash & Iron', 'qty': 2, 'price': 60},
        {'name': 'Trousers', 'service': 'Dry Clean', 'qty': 1, 'price': 150},
        {'name': 'Silk Saree', 'service': 'Dry Clean', 'qty': 1, 'price': 350},
      ],
      'billing': {
         'subtotal': 620,
         'discount': 50,
         'delivery': 50,
         'total': 620,
      }
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Order Details',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header & Status
                  _buildOrderHeader(orderData),
                  const SizedBox(height: 20),

                  // 2. Customer Uploads (New Section)
                  const Text(
                    'Customer Uploads & Instructions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCustomerUploads(context, orderData['uploads'] as List),
                  const SizedBox(height: 24),

                  // 3. Customer & Route Details
                  _buildCustomerSection(orderData['customer'] as Map<String, dynamic>),
                  const SizedBox(height: 20),
                  
                  // 4. Order Items
                  const Text(
                    'Order Items',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildItemsList(orderData['items'] as List),
                   const SizedBox(height: 24),

                  // 5. Billing Summary
                  _buildBillingSummary(orderData['billing'] as Map<String, dynamic>),
                  const SizedBox(height: 100), // Spacing for bottom bar
                ],
              ),
            ),
          ),
          
          // Fixed Bottom Action Bar
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
            child: Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    label: 'Decline',
                    onPressed: () => context.pop(),
                    textColor: AppColors.error,
                    borderColor: AppColors.error,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    label: 'Accept Order',
                    onPressed: () {
                      context.push(RouteConstants.orderPickupScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeader(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order ${data['id']}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Status: ${data['status']}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'COD: ₹620',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerUploads(BuildContext context, List uploads) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: uploads.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = uploads[index];
          return Container(
            width: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Center(
                      child: Icon(Icons.image, color: AppColors.gray400, size: 40),
                    ),
                  ),
                ),
                // Tags
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['type'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (item['issue'] != 'None')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '⚠ ${item['issue']}',
                            style: const TextStyle(fontSize: 10, color: AppColors.error),
                          ),
                        ),
                       const SizedBox(height: 2),
                       Text(
                        '📦 ${item['packaging']}',
                        style: const TextStyle(fontSize: 10, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomerSection(Map<String, dynamic> customer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.gray200,
                child: Icon(Icons.person, color: AppColors.gray600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        Text(' ${customer['rating']} Rating', style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _makePhoneCall(customer['phone']),
                icon: const Icon(Icons.phone, color: AppColors.primary),
                style: IconButton.styleFrom(backgroundColor: AppColors.secondary.withOpacity(0.3)),
              )
            ],
          ),
          const Divider(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  customer['address'],
                  style: const TextStyle(color: AppColors.gray700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Time Slots
          Row(
            children: [
               Expanded( child: _buildTimeSlot('Pickup', 'Today\n10-11 AM', Icons.access_time)),
               Container(width: 1, height: 30, color: AppColors.gray300),
               Expanded( child: _buildTimeSlot('Delivery', 'Tom\n6-7 PM', Icons.local_shipping_outlined)),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimeSlot(String label, String time, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.gray500),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.gray500)),
              Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(List items) {
    return Column(
      children: items.map<Widget>((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray200),
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.dry_cleaning, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                     Text(item['service'], style: const TextStyle(fontSize: 12, color: AppColors.gray600)),
                  ],
                ),
              ),
              Text('x${item['qty']}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Text('₹${item['price'] * item['qty']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildBillingSummary(Map<String, dynamic> billing) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
           _buildBillRow('Subtotal', '₹${billing['subtotal']}'),
           _buildBillRow('Delivery Fee', '₹${billing['delivery']}'),
           _buildBillRow('Discount', '-₹${billing['discount']}', color: AppColors.success),
           const Divider(height: 24),
           _buildBillRow('Total Amount', '₹${billing['total']}', isBold: true),
        ],
      ),
    );
  }
  
  Widget _buildBillRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isBold ? Colors.black : AppColors.gray600, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(color: color ?? (isBold ? Colors.black : Colors.black), fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
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
