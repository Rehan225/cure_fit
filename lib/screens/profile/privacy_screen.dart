import 'package:flutter/material.dart';

import '../../data/legal_text.dart';
import '../../theme/app_theme.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Privacy Policy', style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Privacy Policy', style: AppTextStyles.title),
              SizedBox(height: 8),
              Text(
                'Effective Date: 15 September 2026',
                style: AppTextStyles.label,
              ),
              SizedBox(height: 20),
              Text(LegalText.privacyPolicy, style: AppTextStyles.body),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
