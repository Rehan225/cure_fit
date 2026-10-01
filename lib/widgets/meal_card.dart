import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../theme/app_theme.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLarge),
                topRight: Radius.circular(AppTheme.radiusLarge),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.asset(
                  meal.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.warmOat,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.restaurant_outlined,
                        size: 28,
                        color: AppColors.deepForest,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          child: Text(
                            meal.category,
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          meal.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${meal.price}',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            Text(
                              '${meal.calories} kcal',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 11,
                                color: AppColors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${meal.protein}g protein',
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                    if (onAddToCart != null)
                      InkWell(
                        onTap: onAddToCart,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.teal,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          child: const Text(
                            'Add to order',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
