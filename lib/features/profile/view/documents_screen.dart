import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Documents', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildDocTile('Driving License', 'Verified', true),
          const SizedBox(height: 16),
          _buildDocTile('Registration Certificate (RC)', 'Verified', true),
          const SizedBox(height: 16),
          _buildDocTile('Vehicle Insurance', 'Expires in 30 days', true),
          const SizedBox(height: 16),
          _buildDocTile('Pollution Certificate', 'Pending Verification', false),
        ],
      ),
    );
  }

  Widget _buildDocTile(String title, String status, bool isVerified) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        children: [
          Icon(
            isVerified ? Icons.check_circle : Icons.access_time_filled,
            color: isVerified ? AppColors.success : Colors.orange,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                 Text(status, style: TextStyle(color: isVerified ? AppColors.success : Colors.orange, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray400),
        ],
      ),
    );
  }
}
