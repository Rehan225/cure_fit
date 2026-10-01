import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme/app_theme.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Grocery List', style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, child) {
            final items = appState.generatedGroceryList;

            if (items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.list_alt_outlined,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No ingredients found',
                        style: AppTextStyles.subtitle,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add meals to your plan to generate groceries.',
                        style: AppTextStyles.label,
                      ),
                    ],
                  ),
                ),
              );
            }

            final checkedCount = items
                .where((item) => appState.groceryCheckedItems[item] == true)
                .length;

            return Column(
              children: [
                // Top count and status bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  color: AppColors.surface,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$checkedCount of ${items.length} items acquired',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.deepForest,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final allChecked = checkedCount == items.length;
                          appState.toggleAllGroceryItems(!allChecked);
                        },
                        child: Text(
                          checkedCount == items.length
                              ? 'Uncheck all'
                              : 'Check all',
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Grocery list rows
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isChecked =
                          appState.groceryCheckedItems[item] ?? false;

                      return InkWell(
                        onTap: () => appState.toggleGroceryItem(item),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              // Square 4-radius checkbox control per design.md
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: isChecked
                                      ? AppColors.teal
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusSmall,
                                  ),
                                  border: Border.all(
                                    color: isChecked
                                        ? AppColors.teal
                                        : AppColors.border,
                                    width: 1.5,
                                  ),
                                ),
                                child: isChecked
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: AppColors.deepForest,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  item,
                                  style: AppTextStyles.body.copyWith(
                                    decoration: isChecked
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isChecked
                                        ? AppColors.textSecondary
                                        : AppColors.deepForest,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
