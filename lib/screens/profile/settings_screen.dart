import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'privacy_screen.dart';
import 'terms_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Settings', style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Preferences section
            const Text('App preferences', style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                side: const BorderSide(color: AppColors.border, width: 1),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Workout reminders',
                      style: AppTextStyles.body,
                    ),
                    subtitle: const Text(
                      'Daily morning alert at 06:30 AM',
                      style: AppTextStyles.label,
                    ),
                    trailing: Switch(
                      value: true,
                      activeThumbColor: AppColors.teal,
                      onChanged: (val) {},
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Simulated sync',
                      style: AppTextStyles.body,
                    ),
                    subtitle: const Text(
                      'Auto-connect mock wearable device',
                      style: AppTextStyles.label,
                    ),
                    trailing: Switch(
                      value: true,
                      activeThumbColor: AppColors.teal,
                      onChanged: (val) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Legal section
            const Text('Legal & Compliance', style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                side: const BorderSide(color: AppColors.border, width: 1),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.description_outlined,
                      color: AppColors.deepForest,
                    ),
                    title: const Text(
                      'Terms of Service',
                      style: AppTextStyles.body,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                      color: AppColors.deepForest,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip_outlined,
                      color: AppColors.deepForest,
                    ),
                    title: const Text(
                      'Privacy Policy',
                      style: AppTextStyles.body,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                      color: AppColors.deepForest,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About section
            const Text('About Cure.fit', style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cure.fit Fitness & Wellness',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepForest,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Version 1.0.0 (University Demonstration Build)',
                    style: AppTextStyles.label,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Academic demonstration showcasing integrated fitness tracking, simulated pose detection, nutrition planning, and teleconsultation scheduling.',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
