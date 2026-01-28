import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_outlined_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'My Profile',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                       const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.gray300,
                        child: Icon(Icons.person, size: 50, color: AppColors.gray600),
                       ),
                       Container(
                         padding: const EdgeInsets.all(4),
                         decoration: const BoxDecoration(
                           color: AppColors.primary,
                           shape: BoxShape.circle,
                           border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                         ),
                         child: const Icon(Icons.edit, color: Colors.white, size: 16),
                       )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ravindra Jha',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '+91 98765 43210',
                    style: TextStyle(color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Menu Items
            _buildProfileOption(
              icon: Icons.person_outline,
              label: 'Personal Information',
              onTap: () => context.push(RouteConstants.personalInfoScreen),
            ),
             _buildProfileOption(
              icon: Icons.directions_bike,
              label: 'Vehicle Details',
              onTap: () => context.push(RouteConstants.vehicleDetailsScreen),
            ),
             _buildProfileOption(
              icon: Icons.assignment_outlined,
              label: 'Documents & Verification',
              onTap: () => context.push(RouteConstants.documentsScreen),
            ),
             _buildProfileOption(
              icon: Icons.account_balance_outlined,
              label: 'Bank Account & Payouts',
              onTap: () => context.push(RouteConstants.bankDetailsScreen),
            ),
             _buildProfileOption(
              icon: Icons.history,
              label: 'Order History',
              onTap: () => context.push(RouteConstants.orderHistoryScreen),
            ),
            _buildProfileOption(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () => context.push(RouteConstants.settingsScreen),
            ),
             _buildProfileOption(
              icon: Icons.help_outline,
              label: 'Help & Support',
              onTap: () => context.push(RouteConstants.helpSupportScreen),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                label: 'Logout',
                textColor: AppColors.error,
                borderColor: AppColors.error,
                icon: const Icon(Icons.logout, color: AppColors.error),
                onPressed: () {
                   context.go(RouteConstants.authWelcomeScreen);
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Version 1.0.0',
              style: TextStyle(color: AppColors.gray400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray400),
      contentPadding: EdgeInsets.zero,
    );
  }
}
