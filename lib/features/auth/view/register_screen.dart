import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/custom_textfield.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  
  String? _selectedVehicleType;
  final List<String> _vehicleTypes = ['Bike', 'Scooter', 'Bicycle', 'Electric Scooter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Register as Partner',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile Photo Upload
            Center(
              child: Stack(
                children: [
                   CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.gray200,
                    backgroundImage: null, // TODO: Add logic for displaying picked image
                    child: const Icon(Icons.person, size: 50, color: AppColors.gray400),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: AppColors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Email Address',
              hint: 'Enter your email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            const SizedBox(height: 16),
            
            // Gender Dropdown
             Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: null, // TODO: Add state
                  hint: const Text('Select Gender', style: TextStyle(color: AppColors.gray500)),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.gray500),
                  items: ['Male', 'Female', 'Other'].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // TODO: Set state
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              label: 'Emergency Contact',
              hint: 'Emergency contact number',
              controller: TextEditingController(), // TODO: Add controller
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.contact_phone_outlined),
            ),

            const SizedBox(height: 32),
            // Vehicle Info
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Vehicle Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Vehicle Type Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedVehicleType,
                  hint: const Text('Select Vehicle Type', style: TextStyle(color: AppColors.gray500)),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.gray500),
                  items: _vehicleTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedVehicleType = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Vehicle Number',
              hint: 'e.g. DL 12 AB 1234',
              controller: _vehicleNumberController,
              prefixIcon: const Icon(Icons.directions_bike),
            ),
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Complete Profile',
                onPressed: () {
                  // Navigate to Home
                  context.go(RouteConstants.homeScreen);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
