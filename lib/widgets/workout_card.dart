import 'package:flutter/material.dart';

import '../models/workout.dart';
import '../theme/app_theme.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const WorkoutCard({super.key, required this.workout, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: workout.isLiveNow
              ? AppColors.charcoalOlive
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(
            color: workout.isLiveNow
                ? AppColors.charcoalOlive
                : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with rounded corners (radius 8) or placeholder
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLarge),
                topRight: Radius.circular(AppTheme.radiusLarge),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  workout.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.warmOat,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.fitness_center_outlined,
                        size: 32,
                        color: AppColors.deepForest,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (workout.isLiveNow)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.terracotta,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          child: const Text(
                            'Live now',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.softBone,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.warmOat,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          child: Text(
                            workout.difficulty,
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: 16,
                            color: workout.isLiveNow
                                ? AppColors.textOnDarkSecondary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${workout.duration} mins',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              color: workout.isLiveNow
                                  ? AppColors.textOnDarkSecondary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workout.title,
                    style: workout.isLiveNow
                        ? AppTextStyles.subtitleDark
                        : AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Instructor: ${workout.instructor}',
                    style: workout.isLiveNow
                        ? AppTextStyles.labelDark
                        : AppTextStyles.label,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department_outlined,
                        size: 16,
                        color: AppColors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workout.calories} kcal',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: workout.isLiveNow
                              ? AppColors.softBone
                              : AppColors.deepForest,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.people_outline,
                        size: 16,
                        color: workout.isLiveNow
                            ? AppColors.textOnDarkSecondary
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${workout.participantCount} joined',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          color: workout.isLiveNow
                              ? AppColors.textOnDarkSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
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
