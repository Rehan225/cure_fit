import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/membership_data.dart';
import '../../models/family_member.dart';
import '../../theme/app_theme.dart';
import 'family_member_form_screen.dart';

class FamilyListScreen extends StatelessWidget {
  const FamilyListScreen({super.key});

  void _showMemberDetails(BuildContext context, FamilyMember member) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.softBone,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.warmOat,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.teal,
                      child: Text(
                        member.name.split(' ').map((e) => e[0]).take(2).join(),
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member.name, style: AppTextStyles.subtitle),
                          const SizedBox(height: 2),
                          Text(
                            '${member.age} yrs · ${member.gender}',
                            style: AppTextStyles.label,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fitness goal',
                            style: AppTextStyles.label,
                          ),
                          Text(
                            member.fitnessGoal,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Status', style: AppTextStyles.label),
                          Text(
                            member.membershipStatus,
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 13,
                              color: AppColors.sage,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context); // close sheet
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FamilyMemberFormScreen(
                                existingMember: member,
                              ),
                            ),
                          );
                        },
                        child: const Text('Edit profile'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.terracotta,
                          side: const BorderSide(
                            color: AppColors.terracotta,
                            width: 1,
                          ),
                        ),
                        onPressed: () {
                          appState.removeFamilyMember(member.id);
                          Navigator.pop(context);
                        },
                        child: const Text('Remove'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Family Plan', style: AppTextStyles.subtitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.deepForest),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FamilyMemberFormScreen(),
                ),
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
            final activeType = appState.activeMembership.type;
            final discountedPricePerMember = getFamilyMemberPrice(activeType);

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // Discount banner with exact calculation from Section 5
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Family Discount 50%',
                            style: AppTextStyles.subtitle,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warmOat,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                            ),
                            child: const Text(
                              'Save 50%',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Each added member costs 50% of your ${appState.activeMembership.name}. Price per added member: ₹$discountedPricePerMember.',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Primary account holder
                const Text(
                  'Primary account holder',
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.teal,
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Rehan (You)',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Primary Member · Full Access',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sage,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: const Text(
                          'Primary',
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
                ),
                const SizedBox(height: 24),

                // Added family members header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Family members (${appState.familyMembers.length})',
                      style: AppTextStyles.subtitle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FamilyMemberFormScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        '+ Add member',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                if (appState.familyMembers.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'No family members added yet.',
                      style: AppTextStyles.label,
                    ),
                  )
                else
                  ...appState.familyMembers.map((member) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.warmOat,
                            child: Text(
                              member.name
                                  .split(' ')
                                  .map((e) => e[0])
                                  .take(2)
                                  .join(),
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepForest,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${member.age} yrs · ${member.fitnessGoal}',
                                  style: AppTextStyles.label,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                _showMemberDetails(context, member),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                const SizedBox(height: 32),
              ],
            );
          },
        ),
      ),
    );
  }
}
