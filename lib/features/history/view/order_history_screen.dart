import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/order_card.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order History', showBackButton: true),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final isCompleted = index % 2 == 0;
          return RiderOrderCard(
            orderId: 'ORD-#${20220 - index}',
            pickupAddress: 'H.No 123, Street ${index + 1}, Okhla Phase 2',
            deliveryAddress: 'Laundry Hub, Sector 18, Noida',
            distance: '${3.5 + index} km',
            earnings: '₹${80 + (index * 15)}',
            serviceType: isCompleted ? 'Wash & Iron' : 'Dry Clean',
            isNew: false, // Hides Accept/Ignore buttons
            onAccept: () {},
            onDecline: () {},
            onTap: () {
              // TODO: Navigate to Order Details
            },
          );
        },
      ),
    );
  }
}
