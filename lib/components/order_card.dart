import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/custom_outlined_button.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class RiderOrderCard extends StatelessWidget {
  final String orderId;
  final String pickupAddress;
  final String deliveryAddress;
  final String distance;
  final String earnings;
  final String serviceType; // e.g., "Dry Clean"
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final bool isNew;
  final VoidCallback? onTap;

  const RiderOrderCard({
    super.key,
    required this.orderId,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.distance,
    required this.earnings,
    required this.serviceType,
    required this.onAccept,
    required this.onDecline,
    this.isNew = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    orderId,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.dryClean, // Using dryClean color for demo
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    serviceType,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
  
            // Route
            Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 12, color: AppColors.primary),
                    Container(width: 2, height: 30, color: AppColors.gray300),
                    const Icon(Icons.location_on, size: 16, color: AppColors.error),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickupAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        deliveryAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.gray200),
            const SizedBox(height: 12),
  
            // Footer info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_bike, size: 16, color: AppColors.gray500),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: const TextStyle(color: AppColors.gray600, fontSize: 13),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.payments_outlined, size: 16, color: AppColors.gray500),
                    const SizedBox(width: 4),
                    Text(
                      earnings,
                      style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            
            if (isNew) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      label: 'Ignore',
                      height: 40,
                      padding: EdgeInsets.zero,
                      borderColor: AppColors.gray400,
                      textColor: AppColors.gray600,
                      onPressed: onDecline,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      label: 'Accept',
                      height: 40,
                      padding: EdgeInsets.zero,
                      onPressed: onAccept,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
