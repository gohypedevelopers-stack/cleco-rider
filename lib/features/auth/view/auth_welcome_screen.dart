import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/components/custom_outlined_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/images/images.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Logo and Hero Image
              Image.asset(
                Images.logo,
                height: 80,
              ),
              const SizedBox(height: 40),
              Image.asset(
                Images.authWelcome, // You might need a rider-specific image here later
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              
              const Text(
                'Become a Delivery Partner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Join our fleet and start earning.\nFlexible hours, instant payouts.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.gray500,
                  height: 1.5,
                ),
              ),
              const Spacer(),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  label: 'Login',
                  onPressed: () {
                    context.push(RouteConstants.loginScreen);
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomOutlinedButton(
                  label: 'Register as Partner',
                  onPressed: () {
                    context.push(RouteConstants.registerScreen);
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
