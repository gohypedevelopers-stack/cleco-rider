import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Earnings',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Total Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '₹ 2,450.50',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      label: 'Withdraw Money',
                      color: AppColors.white,
                      textColor: AppColors.primary,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 32),

            // Stats
            Row(
              children: [
                _buildStatItem('Today', '₹ 850'),
                _buildStatItem('This Week', '₹ 5,200'),
                _buildStatItem('This Month', '₹ 18,500'),
              ],
            ),
            const SizedBox(height: 32),

            // Recent Transactions
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text(
                   'Recent Transactions',
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 TextButton(onPressed: (){}, child: const Text('See All')),
               ],
             ),
             
             ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: 5,
               itemBuilder: (context, index) {
                 return ListTile(
                   contentPadding: EdgeInsets.zero,
                   leading: Container(
                     padding: const EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: AppColors.gray100,
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: const Icon(Icons.arrow_downward, color: AppColors.success),
                   ),
                   title: const Text('Order #20240 Payment', style: TextStyle(fontWeight: FontWeight.w600)),
                   subtitle: const Text('Today, 10:30 AM', style: TextStyle(color: AppColors.gray500, fontSize: 12)),
                   trailing: const Text(
                     '+ ₹85.00',
                     style: TextStyle(
                       color: AppColors.success,
                       fontWeight: FontWeight.bold,
                       fontSize: 16,
                     ),
                   ),
                 );
               },
             ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: AppColors.gray500, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
