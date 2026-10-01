import 'package:flutter/material.dart';

import '../models/achievement.dart';
import '../theme/app_theme.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;
  final VoidCallback onTap;

  const AchievementCard({
    super.key,
    required this.achievement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: achievement.isUnlocked ? AppColors.sage : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(
            color: achievement.isUnlocked ? AppColors.sage : AppColors.border,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  achievement.isUnlocked
                      ? Icons.military_tech_outlined
                      : Icons.lock_outline,
                  size: 24,
                  color: achievement.isUnlocked
                      ? AppColors.deepForest
                      : AppColors.textSecondary,
                ),
                if (achievement.isUnlocked)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBone,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: const Text(
                      'Unlocked',
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
            const SizedBox(height: 8),
            Text(
              achievement.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: achievement.isUnlocked
                    ? AppColors.deepForest
                    : AppColors.deepForest,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              achievement.isUnlocked
                  ? achievement.description
                  : achievement.unlockCondition,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 11,
                color: achievement.isUnlocked
                    ? AppColors.deepForest.withOpacity(0.85)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
