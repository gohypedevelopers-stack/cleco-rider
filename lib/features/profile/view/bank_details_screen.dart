import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bank Details', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.account_balance, size: 48, color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text('HDFC Bank', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text('Main Branch, New Delhi', style: TextStyle(color: AppColors.gray500)),
                  const Divider(height: 32),
                  _buildRow('Account Holder', 'Ravindra Jha'),
                  _buildRow('Account Number', '**** **** 1234'),
                  _buildRow('IFSC Code', 'HDFC0001234'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.qr_code, size: 32, color: AppColors.primary),
                  const SizedBox(width: 16),
                   const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('UPI ID', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('ravindra@okhdfc', style: TextStyle(color: AppColors.gray500)),
                      ],
                    ),
                  ),
                  TextButton(onPressed: (){}, child: const Text('Edit'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.gray500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
