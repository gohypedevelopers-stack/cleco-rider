import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'FAQ', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _FaqItem(
            question: 'How do I accept an order?',
            answer: 'When a new order appears in the "Available Orders" tab, tap on it to view details and click "Accept Order".',
          ),
          _FaqItem(
            question: 'How do I change my vehicle details?',
            answer: 'Go to Profile > Vehicle Details to view your current vehicle. To update, please contact support.',
          ),
          _FaqItem(
            question: 'When will I get my payout?',
            answer: 'Payouts are processed weekly every Wednesday for the earnings of the previous week.',
          ),
          _FaqItem(
            question: 'What if the customer is not at the location?',
            answer: 'Please try calling the customer via the app. If there is no response after 10 minutes, you can mark the delivery as failed.',
          ),
           _FaqItem(
            question: 'How to contact support?',
            answer: 'You can use the Live Chat feature or Call Support option in the Help & Support section.',
          ),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.gray200),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: const TextStyle(color: AppColors.gray600),
            ),
          ),
        ],
      ),
    );
  }
}
