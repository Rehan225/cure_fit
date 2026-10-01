import 'package:flutter/material.dart';

import '../../data/yoga_data.dart';
import '../../models/yoga_session.dart';
import '../../theme/app_theme.dart';
import '../../widgets/skeleton_box.dart';
import 'yoga_session_screen.dart';

class YogaListScreen extends StatefulWidget {
  const YogaListScreen({super.key});

  @override
  State<YogaListScreen> createState() => _YogaListScreenState();
}

class _YogaListScreenState extends State<YogaListScreen> {
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Morning Yoga',
    'Flexibility',
    'Back Care',
    'Strength',
    'Stress Relief',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  List<YogaSession> get _filteredSessions {
    if (_selectedCategory == 'All') {
      return mockYogaSessions;
    }
    return mockYogaSessions
        .where((s) => s.category == _selectedCategory)
        .toList();
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SkeletonBox(width: double.infinity, height: 36),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 110),
        SizedBox(height: 12),
        SkeletonBox(width: double.infinity, height: 110),
        SizedBox(height: 12),
        SkeletonBox(width: double.infinity, height: 110),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Yoga Studio', style: AppTextStyles.title),
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : Column(
              children: [
                // Category Filter Chips
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.deepForest
                                : AppColors.warmOat,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.softBone
                                  : AppColors.deepForest,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),

                // Sessions List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _filteredSessions.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final session = _filteredSessions[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  YogaSessionScreen(session: session),
                            ),
                          );
                        },
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
                          child: Row(
                            children: [
                              Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: AppColors.warmOat,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusSmall,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.accessibility_new_outlined,
                                  size: 28,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            session.category,
                                            style: const TextStyle(
                                              fontFamily: 'WorkSans',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.deepForest,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${session.durationMinutes} min',
                                          style: AppTextStyles.label,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      session.title,
                                      style: AppTextStyles.subtitle,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${session.instructor}, ${session.poses.length} poses',
                                      style: AppTextStyles.label,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 14,
                                color: AppColors.deepForest,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
