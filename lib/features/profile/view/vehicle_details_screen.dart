import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Vehicle Details', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Vehicle Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.two_wheeler, size: 80, color: AppColors.gray500),
            ),
            const SizedBox(height: 24),
            
            _buildDetailRow('Vehicle Type', 'Motorbike'),
            _buildDetailRow('Model', 'Honda Shine'),
            _buildDetailRow('Color', 'Black'),
            _buildDetailRow('License Plate', 'DL 3S AB 1234'),
            const Divider(height: 32),
             _buildDetailRow('Registration Date', '12 Jan 2022'),
            _buildDetailRow('Insurance Valid Until', '11 Jan 2025'),

          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.gray600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
