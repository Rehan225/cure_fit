import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/membership_data.dart';
import '../../models/membership_plan.dart';
import '../../theme/app_theme.dart';
import '../profile/privacy_screen.dart';
import '../profile/terms_screen.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  late MembershipType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = appState.activeMembership.type;
  }

  void _activatePlan() {
    final chosenPlan = _selectedType == MembershipType.annual
        ? annualPlan
        : monthlyPlan;
    appState.selectMembership(chosenPlan);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.softBone,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.verified_outlined,
                        color: AppColors.deepForest,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Membership activated',
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your ${chosenPlan.name} is now active. Enjoy unlimited live workouts and session tracking.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Plan rate', style: AppTextStyles.label),
                    Text(
                      '₹${chosenPlan.price} / ${chosenPlan.billingPeriod}',
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepForest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status', style: AppTextStyles.label),
                    const Text(
                      'Active (Simulated)',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.sage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Continue'),
                  ),
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
    final familyDiscountPrice = getFamilyMemberPrice(_selectedType);

    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Membership & Plans', style: AppTextStyles.title),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, child) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // 1. Current Plan Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.charcoalOlive,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current active plan',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              color: AppColors.textOnDarkSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            appState.activeMembership.name,
                            style: AppTextStyles.subtitleDark,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '₹${appState.activeMembership.price} / ${appState.activeMembership.billingPeriod}',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 13,
                              color: AppColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sage,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 2. Membership Section: Two full-width selectable rows stacked vertically
                const Text('Choose membership', style: AppTextStyles.subtitle),
                const SizedBox(height: 12),

                // Monthly Pass row
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedType = MembershipType.monthly;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(
                        color: _selectedType == MembershipType.monthly
                            ? AppColors.deepForest
                            : AppColors.border,
                        width: _selectedType == MembershipType.monthly
                            ? 2.0
                            : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Radio<MembershipType>(
                          value: MembershipType.monthly,
                          groupValue: _selectedType,
                          activeColor: AppColors.deepForest,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedType = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Monthly Pass',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Unlimited live classes',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '₹999 / month',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Annual Membership row
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedType = MembershipType.annual;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(
                        color: _selectedType == MembershipType.annual
                            ? AppColors.deepForest
                            : AppColors.border,
                        width: _selectedType == MembershipType.annual
                            ? 2.0
                            : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Radio<MembershipType>(
                          value: MembershipType.annual,
                          groupValue: _selectedType,
                          activeColor: AppColors.deepForest,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedType = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Annual Membership',
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.deepForest,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Save 40% Tag
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warmOat,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusSmall,
                                      ),
                                    ),
                                    child: const Text(
                                      'Save 40%',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.deepForest,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Full 12-month unlimited access',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '₹6999 / year',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Add-ons Section: Two separate list rows (not cards in a row)
                const Text('Available add-ons', style: AppTextStyles.subtitle),
                const SizedBox(height: 12),

                // Meal Plan row
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.warmOat,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: const Icon(
                          Icons.restaurant_outlined,
                          size: 20,
                          color: AppColors.deepForest,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Meal Plan',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '3 healthy meals daily',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '₹399 / day',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                    ],
                  ),
                ),

                // Family Plan row
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.warmOat,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: const Icon(
                          Icons.group_outlined,
                          size: 20,
                          color: AppColors.deepForest,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Family Plan',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Add a member at 50% discount',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹$familyDiscountPrice / member',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 4. Comparison Table (Monthly versus Annual)
                const Text('Plan comparison', style: AppTextStyles.subtitle),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Feature',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Monthly',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Annual',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      _buildComparisonRow(
                        'Live interactive classes',
                        'Included',
                        'Included',
                      ),
                      const Divider(height: 1),
                      _buildComparisonRow(
                        'Pose estimation tracking',
                        'Included',
                        'Included',
                      ),
                      const Divider(height: 1),
                      _buildComparisonRow(
                        'Wearable sync simulation',
                        'Included',
                        'Included',
                      ),
                      const Divider(height: 1),
                      _buildComparisonRow(
                        'Priority booking slots',
                        'Standard',
                        'Priority',
                      ),
                      const Divider(height: 1),
                      _buildComparisonRow(
                        'Annual savings rate',
                        'None',
                        'Save 40%',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Primary Button: Select Plan
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _activatePlan,
                    child: const Text('Select plan'),
                  ),
                ),
                const SizedBox(height: 12),

                // 5. Small text line under button linking to Terms and Privacy
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(
                      ' and ',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String feature, String monthly, String annual) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: AppTextStyles.body.copyWith(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              monthly,
              textAlign: TextAlign.center,
              style: AppTextStyles.label,
            ),
          ),
          Expanded(
            child: Text(
              annual,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: annual.contains('Save')
                    ? AppColors.teal
                    : AppColors.deepForest,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
