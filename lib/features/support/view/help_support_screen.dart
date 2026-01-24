import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Help & Support', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSupportTile(
              icon: Icons.question_answer_outlined,
              title: 'FAQ',
              subtitle: 'Commonly asked questions',
              onTap: () => context.push(RouteConstants.faqScreen),
            ),
            const SizedBox(height: 16),
            _buildSupportTile(
              icon: Icons.chat_bubble_outline,
              title: 'Live Chat',
              subtitle: 'Chat with our support team',
              onTap: () => context.push(RouteConstants.liveChatScreen),
            ),
            const SizedBox(height: 16),
            _buildSupportTile(
              icon: Icons.phone_outlined,
              title: 'Call Support',
              subtitle: 'Speak directly to an agent',
              onTap: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: '+911234567890',
                );
                if (await canLaunchUrl(launchUri)) {
                  await launchUrl(launchUri);
                }
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Issues',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray200),
              ),
              child: const Row(
                children: [
                   Icon(Icons.info_outline, color: AppColors.gray500),
                   SizedBox(width: 12),
                   Text('No recent tickets found.', style: TextStyle(color: AppColors.gray500))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.gray200),
      ),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.gray500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray400),
    );
  }
}
