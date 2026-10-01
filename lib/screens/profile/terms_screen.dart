import 'package:flutter/material.dart';

import '../../data/legal_text.dart';
import '../../theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Terms of Service', style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Terms of Service', style: AppTextStyles.title),
              SizedBox(height: 8),
              Text(
                'Effective Date: 15 September 2026',
                style: AppTextStyles.label,
              ),
              SizedBox(height: 20),
              Text(LegalText.termsOfService, style: AppTextStyles.body),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
