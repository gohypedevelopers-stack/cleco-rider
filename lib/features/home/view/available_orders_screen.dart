import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/order_card.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AvailableOrdersScreen extends StatelessWidget {
  const AvailableOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'New Orders',
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        itemBuilder: (context, index) {
          return RiderOrderCard(
            orderId: 'ORD-#${20230 + index}',
            pickupAddress: 'H.No 123, Street 4, Okhla Phase 2, New Delhi',
            deliveryAddress: 'Laundry Hub, Sector 18, Noida',
            distance: '${2.5 + index} km',
            earnings: '₹${60 + (index * 10)}',
            serviceType: index % 2 == 0 ? 'Dry Clean' : 'Wash & Iron',
            // Allow viewing details even before accepting
            onTap: () {
              context.push(RouteConstants.orderDetailsScreen);
            },
            onAccept: () {
              // Handle accept
            },
            onDecline: () {
              // Handle decline
            },
          );
        },
      ),
    );
  }
}
