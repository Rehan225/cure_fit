import 'package:flutter/material.dart';

import '../../models/workout.dart';
import '../../theme/app_theme.dart';
import 'live_workout_screen.dart';
import 'workout_tracking_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(title: Text(workout.title, style: AppTextStyles.subtitle)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Workout Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.asset(
                          workout.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: AppColors.warmOat,
                                child: const Icon(
                                  Icons.fitness_center_outlined,
                                  size: 36,
                                  color: AppColors.deepForest,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title & Instructor
                    Text(workout.title, style: AppTextStyles.title),
                    const SizedBox(height: 4),
                    Text(
                      'Led by ${workout.instructor}',
                      style: AppTextStyles.label.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // Metrics row
                    Container(
                      padding: const EdgeInsets.all(16),
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
                          Column(
                            children: [
                              Text(
                                '${workout.duration} min',
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Duration',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: AppColors.border,
                          ),
                          Column(
                            children: [
                              Text(
                                '${workout.calories} kcal',
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orange,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Calories',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: AppColors.border,
                          ),
                          Column(
                            children: [
                              Text(
                                workout.difficulty,
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text('Level', style: AppTextStyles.label),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Routine breakdown with plain numbers (no checkmarks)
                    const Text(
                      'Exercise sequence',
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workout.exercises.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.warmOat,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusSmall,
                                  ),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepForest,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  workout.exercises[index],
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Text(
                                '3 sets, 12 to 15 reps',
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom action buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.softBone,
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkoutTrackingScreen(workout: workout),
                          ),
                        );
                      },
                      child: const Text('Start tracking exercise'),
                    ),
                  ),
                  if (workout.isLiveNow) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LiveWorkoutScreen(workout: workout),
                            ),
                          );
                        },
                        child: const Text('Join live class'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
