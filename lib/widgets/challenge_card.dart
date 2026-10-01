import 'package:flutter/material.dart';

import '../models/challenge.dart';
import '../theme/app_theme.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onToggleJoin;

  const ChallengeCard({
    super.key,
    required this.challenge,
    required this.onToggleJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: challenge.isCompleted
                      ? AppColors.sage
                      : AppColors.warmOat,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  challenge.isCompleted
                      ? 'Completed'
                      : '${challenge.durationDays} days challenge',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: challenge.isCompleted
                        ? AppColors.softBone
                        : AppColors.deepForest,
                  ),
                ),
              ),
              Text(
                '${challenge.participantCount} active',
                style: AppTextStyles.label,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(challenge.title, style: AppTextStyles.subtitle),
          const SizedBox(height: 4),
          Text(
            challenge.description,
            style: AppTextStyles.body.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 12),
          // Progress bar: Height 6, radius 2, track warmOat, fill solid teal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goal: ${challenge.goal}',
                style: AppTextStyles.label.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${challenge.percentage}%',
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepForest,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: challenge.progress,
                backgroundColor: AppColors.warmOat,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onToggleJoin,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: challenge.isJoined
                        ? AppColors.warmOat
                        : AppColors.teal,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  child: Text(
                    challenge.isJoined ? 'Joined' : 'Join challenge',
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepForest,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
