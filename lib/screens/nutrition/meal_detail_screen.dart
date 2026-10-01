import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/meal.dart';
import '../../theme/app_theme.dart';
import 'order_summary_screen.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(title: Text(meal.name, style: AppTextStyles.subtitle)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Large Food photo at top (radius 8) with no overlay
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Image.asset(
                          meal.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: AppColors.warmOat,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.restaurant_outlined,
                                  size: 40,
                                  color: AppColors.deepForest,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Meal name in Title
                    Text(meal.name, style: AppTextStyles.title),
                    const SizedBox(height: 6),
                    Text(meal.description, style: AppTextStyles.body),
                    const SizedBox(height: 16),

                    // Nutrition info: Two boxes side by side (Calories, Protein) on surface with 1px border
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusLarge,
                              ),
                              border: Border.all(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Calories',
                                  style: AppTextStyles.label,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${meal.calories}',
                                      style: AppTextStyles.metric.copyWith(
                                        fontSize: 28,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'kcal',
                                      style: AppTextStyles.label,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusLarge,
                              ),
                              border: Border.all(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Protein',
                                  style: AppTextStyles.label,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '${meal.protein}',
                                      style: AppTextStyles.metric.copyWith(
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'grams',
                                      style: AppTextStyles.label,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Additional values (carbs, fat) appear as rows beneath
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Carbohydrates: ${meal.carbs}g',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: AppColors.border,
                          ),
                          Text(
                            'Healthy Fats: ${meal.fat}g',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Ingredients as plain divided rows (no checkmark bullets)
                    const Text('Ingredients', style: AppTextStyles.subtitle),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: meal.ingredients.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    meal.ingredients[index],
                                    style: AppTextStyles.body,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom order action bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.softBone,
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Delivery price', style: AppTextStyles.label),
                      Text(
                        '₹${meal.price}',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        appState.addToCart(meal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${meal.name} added to order.',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                color: AppColors.softBone,
                              ),
                            ),
                            action: SnackBarAction(
                              label: 'View order',
                              textColor: AppColors.teal,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderSummaryScreen(),
                                  ),
                                );
                              },
                            ),
                            backgroundColor: AppColors.deepForest,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                      child: const Text('Add to order'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
