import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/order_card.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Active Orders',
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 2, // Demo data
        itemBuilder: (context, index) {
          return RiderOrderCard(
            orderId: 'ORD-#${20240 + index}',
            pickupAddress: 'H.No 55, Green Park, New Delhi',
            deliveryAddress: 'Laundry Hub, Sector 18, Noida',
            distance: '1.2 km',
            earnings: '₹85',
            serviceType: 'Wash & Iron',
            isNew: false, // It's an active order
            onTap: () {
              context.push(RouteConstants.orderDetailsScreen);
            },
            onAccept: () {},
            onDecline: () {}, // Not needed for active
          );
        },
      ),
    );
  }
}
