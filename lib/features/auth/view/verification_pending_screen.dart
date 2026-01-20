import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              Icons.hourglass_top_rounded,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 32),
            const Text(
              'Application Submitted',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We are currently verifying your documents. This process usually takes 24-48 hours. You will be notified once your account is approved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.gray500,
                height: 1.5,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Go to Home (Demo)', // For demo purposes allowing bypass
                onPressed: () {
                   context.go(RouteConstants.homeScreen);
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.go(RouteConstants.authWelcomeScreen);
              },
              child: const Text('Back to Login', style: TextStyle(color: AppColors.gray500)),
            ),
          ],
        ),
      ),
    );
  }
}
