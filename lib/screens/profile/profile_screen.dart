import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme/app_theme.dart';
import '../challenges/challenges_screen.dart';
import '../doctors/doctor_list_screen.dart';
import '../family/family_list_screen.dart';
import '../membership/membership_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('My Profile', style: AppTextStyles.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.deepForest,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, child) {
            final unlockedAchievementsCount = appState.achievements
                .where((a) => a.isUnlocked)
                .length;

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // Profile Header Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.teal,
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Rehan',
                                  style: AppTextStyles.subtitle,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.sage,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusSmall,
                                    ),
                                  ),
                                  child: const Text(
                                    'Active Plan',
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.softBone,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Age: 24 · Goal: Strength & Longevity',
                              style: AppTextStyles.label,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              appState.activeMembership.name,
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Stat summary highlights
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$unlockedAchievementsCount',
                              style: AppTextStyles.metric.copyWith(
                                fontSize: 26,
                              ),
                            ),
                            const Text(
                              'Badges earned',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${appState.familyMembers.length}',
                              style: AppTextStyles.metric.copyWith(
                                fontSize: 26,
                              ),
                            ),
                            const Text(
                              'Family members',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Navigation Management List
                const Text(
                  'Wellness management',
                  style: AppTextStyles.subtitle,
                ),
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
                          Icons.group_outlined,
                          color: AppColors.deepForest,
                        ),
                        title: const Text(
                          'Family Plan & Profiles',
                          style: AppTextStyles.body,
                        ),
                        subtitle: Text(
                          '${appState.familyMembers.length} active family passes',
                          style: AppTextStyles.label,
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
                              builder: (context) => const FamilyListScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.card_membership_outlined,
                          color: AppColors.deepForest,
                        ),
                        title: const Text(
                          'Membership & Subscriptions',
                          style: AppTextStyles.body,
                        ),
                        subtitle: Text(
                          '${appState.activeMembership.name} (Active)',
                          style: AppTextStyles.label,
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
                              builder: (context) => const MembershipScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.medical_services_outlined,
                          color: AppColors.deepForest,
                        ),
                        title: const Text(
                          'Doctor Consultations',
                          style: AppTextStyles.body,
                        ),
                        subtitle: const Text(
                          'Telehealth appointment booking',
                          style: AppTextStyles.label,
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
                              builder: (context) => const DoctorListScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.military_tech_outlined,
                          color: AppColors.deepForest,
                        ),
                        title: const Text(
                          'Achievements & Leaderboard',
                          style: AppTextStyles.body,
                        ),
                        subtitle: const Text(
                          'Track streak, points & badges',
                          style: AppTextStyles.label,
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
                              builder: (context) =>
                                  const ChallengesScreen(initialTabIndex: 2),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.settings_outlined,
                          color: AppColors.deepForest,
                        ),
                        title: const Text(
                          'App Settings & Legal',
                          style: AppTextStyles.body,
                        ),
                        subtitle: const Text(
                          'Terms of Service, Privacy Policy',
                          style: AppTextStyles.label,
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
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
