import 'dart:async';
import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/components/custom_elevated_button.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  
  Timer? _timer;
  int _start = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 30;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
          _canResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyOtp() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid OTP')),
      );
      return;
    }

    // Mock verification
    // Navigate to Registration for new user flow
    context.push(RouteConstants.registerScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Verification',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We have sent a code to ${widget.phoneNumber}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.gray500,
              ),
            ),
            const SizedBox(height: 32),

            // OTP Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  height: 55,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.gray300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                      if (index == 5 && value.isNotEmpty) {
                        _focusNodes[index].unfocus();
                        _verifyOtp(); // Auto submit
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive code? ",
                  style: TextStyle(color: AppColors.gray500),
                ),
                GestureDetector(
                  onTap: _canResend
                      ? () {
                          startTimer();
                          // Resend logic
                        }
                      : null,
                  child: Text(
                    _canResend ? 'Resend' : 'Resend in ${_start}s',
                    style: TextStyle(
                      color: _canResend ? AppColors.primary : AppColors.gray400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                label: 'Verify',
                onPressed: _verifyOtp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
