import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_outlined_button.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Personal Information', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.gray300,
              child: Icon(Icons.person, size: 50, color: AppColors.gray600),
            ),
            const SizedBox(height: 32),
            _buildInfoField('Full Name', 'Ravindra Kumar'),
            _buildInfoField('Mobile Number', '+91 98765 43210'),
            _buildInfoField('Email Address', 'ravindra.kumar@example.com'),
            _buildInfoField('Gender', 'Male'),
            _buildInfoField('Date of Birth', '15 Aug 1990'),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: CustomOutlinedButton(
                label: 'Edit Profile',
                 // TODO: Implement edit functionality
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.gray500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
