import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../theme/app_theme.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Square photo with radius 4
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              child: SizedBox(
                width: 72,
                height: 72,
                child: Image.asset(
                  doctor.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.warmOat,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.medical_services_outlined,
                        size: 28,
                        color: AppColors.deepForest,
                      ),
                    );
                  },
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warmOat,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: Text(
                          doctor.specialty,
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_outline,
                            size: 16,
                            color: AppColors.deepForest,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            doctor.rating.toString(),
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(doctor.name, style: AppTextStyles.subtitle),
                  const SizedBox(height: 2),
                  Text(
                    '${doctor.experienceYears} years experience',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${doctor.fee} consultation',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                        ),
                      ),
                      const Text(
                        'Book slot',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepForest,
                          decoration: TextDecoration.underline,
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
