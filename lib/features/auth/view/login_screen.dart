import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/custom_textfield.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Login to continue delivering smiles.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 32),

            // Form
            const Text(
              'Phone Number',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: AppColors.gray300)),
                    ),
                    child: const Row(
                      children: [
                        Text('🇮🇳 +91', style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_drop_down, size: 20),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Enter phone number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Continue',
                onPressed: () {
                  final phone = _emailController.text.trim();
                  if (phone.length < 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a valid phone number')),
                    );
                    return;
                  }
                  context.push(RouteConstants.verifyOtpScreen, extra: phone);
                },
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: AppColors.gray500),
                ),
                GestureDetector(
                  onTap: () {
                    context.pushReplacement(RouteConstants.registerScreen);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
