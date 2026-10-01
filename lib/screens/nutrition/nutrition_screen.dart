import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/meal_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/meal_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/skeleton_box.dart';
import 'grocery_list_screen.dart';
import 'meal_detail_screen.dart';
import 'order_summary_screen.dart';

class NutritionScreen extends StatefulWidget {
  final int initialTabIndex;

  const NutritionScreen({super.key, this.initialTabIndex = 0});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddMealDialog() {
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
                const Text('Select meal to add', style: AppTextStyles.subtitle),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: mockMeals.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final meal = mockMeals[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(meal.name, style: AppTextStyles.body),
                        subtitle: Text(
                          '${meal.category} · ${meal.calories} kcal',
                          style: AppTextStyles.label,
                        ),
                        trailing: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(80, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: () {
                            appState.addMealToPlan(meal);
                            Navigator.pop(context);
                          },
                          child: const Text('Add'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SkeletonBox(width: double.infinity, height: 180),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 80),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 140),
      ],
    );
  }

  Widget _buildMealPlannerTab() {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final meals = appState.plannedMeals;

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // Top Large Food Photo (radius 8) with no overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/images/meal_breakfast.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.warmOat,
                    child: const Icon(Icons.restaurant_outlined, size: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Daily Total Calories Metric Display
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
                  const Text(
                    'Daily planned intake',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${appState.totalPlannedCalories}',
                        style: AppTextStyles.metric.copyWith(
                          color: AppColors.orange,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('kcal target', style: AppTextStyles.label),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${appState.totalPlannedProtein}g',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                          const Text('Protein', style: AppTextStyles.label),
                        ],
                      ),
                      Container(width: 1, height: 24, color: AppColors.border),
                      Column(
                        children: [
                          Text(
                            '${appState.totalPlannedCarbs}g',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                          const Text('Carbs', style: AppTextStyles.label),
                        ],
                      ),
                      Container(width: 1, height: 24, color: AppColors.border),
                      Column(
                        children: [
                          Text(
                            '${appState.totalPlannedFat}g',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                          const Text('Fat', style: AppTextStyles.label),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Today's Planned Meals breakdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Meals planned', style: AppTextStyles.subtitle),
                GestureDetector(
                  onTap: _showAddMealDialog,
                  child: const Text(
                    '+ Add meal',
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

            if (meals.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'No meals in today plan. Tap + Add meal.',
                  style: AppTextStyles.label,
                ),
              )
            else
              ...meals.map((meal) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
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
                          meal.category,
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            Text(
                              '${meal.calories} kcal · ${meal.protein}g protein',
                              style: AppTextStyles.label,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: AppColors.terracotta,
                        ),
                        onPressed: () {
                          appState.removeMealFromPlan(meal.id);
                        },
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 20),

            // Full-width primary button "Generate grocery list" in teal
            PrimaryButton(
              label: 'Generate grocery list',
              icon: Icons.list_alt_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroceryListScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildDeliveryTab() {
    final filteredMeals = _selectedCategory == 'All'
        ? mockMeals
        : mockMeals.where((m) => m.category == _selectedCategory).toList();

    return Column(
      children: [
        // Category horizontal chips
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
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
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
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

        // 2-column grid of meal cards
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemCount: filteredMeals.length,
            itemBuilder: (context, index) {
              final meal = filteredMeals[index];
              return MealCard(
                meal: meal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MealDetailScreen(meal: meal),
                    ),
                  );
                },
                onAddToCart: () {
                  appState.addToCart(meal);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${meal.name} added to cart.',
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          color: AppColors.softBone,
                        ),
                      ),
                      backgroundColor: AppColors.deepForest,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Nutrition & Meals', style: AppTextStyles.title),
        actions: [
          AnimatedBuilder(
            animation: appState,
            builder: (context, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.deepForest,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderSummaryScreen(),
                        ),
                      );
                    },
                  ),
                  if (appState.cartItems.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${appState.cartItems.length}',
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBone,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.deepForest,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.deepForest,
          indicatorWeight: 2,
          tabs: const [
            Tab(text: 'Meal Planner'),
            Tab(text: 'Healthy Delivery'),
          ],
        ),
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : TabBarView(
              controller: _tabController,
              children: [_buildMealPlannerTab(), _buildDeliveryTab()],
            ),
    );
  }
}
