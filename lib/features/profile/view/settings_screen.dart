import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('General', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gray500)),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Receive push notifications for orders'),
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
            secondary: const Icon(Icons.notifications_active_outlined),
          ),
           SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkModeEnabled,
            onChanged: (val) => setState(() => _darkModeEnabled = val),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          const Divider(height: 32),
          
          const Text('Account', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gray500)),
           const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
           ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Terms & Conditions'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          
          const Divider(height: 32),
           ListTile(
            leading: const Icon(Icons.delete_forever, color: AppColors.error),
            title: const Text('Delete Account', style: TextStyle(color: AppColors.error)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
