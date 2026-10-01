import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme/app_theme.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  void _confirmOrder(BuildContext context) {
    final itemCount = appState.cartItems.length;
    final total = appState.cartTotal;
    appState.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.softBone,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.deepForest,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Order confirmed', style: AppTextStyles.title),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your $itemCount nutritious meals have been scheduled for kitchen preparation and delivery.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total paid (simulated):',
                      style: AppTextStyles.body,
                    ),
                    Text(
                      '₹$total',
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepForest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Estimated arrival: 45 minutes.',
                  style: AppTextStyles.label,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // dialog
                      Navigator.pop(context); // order summary
                    },
                    child: const Text('Back to meals'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Order Summary', style: AppTextStyles.subtitle),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, child) {
            if (appState.cartItems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your order is empty',
                        style: AppTextStyles.subtitle,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Browse healthy meals to add items.',
                        style: AppTextStyles.label,
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: appState.cartItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = appState.cartItems[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.warmOat,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall,
                                ),
                              ),
                              child: const Icon(
                                Icons.restaurant_outlined,
                                size: 22,
                                color: AppColors.deepForest,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${item.calories} kcal · ${item.protein}g protein',
                                    style: AppTextStyles.label,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '₹${item.price}',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.deepForest,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: AppColors.terracotta,
                              ),
                              onPressed: () {
                                appState.removeFromCart(item);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(
                      top: BorderSide(color: AppColors.border, width: 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal', style: AppTextStyles.body),
                          Text(
                            '₹${appState.cartTotal}',
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Delivery fee', style: AppTextStyles.body),
                          Text('Free', style: AppTextStyles.body),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total amount',
                            style: AppTextStyles.subtitle,
                          ),
                          Text(
                            '₹${appState.cartTotal}',
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => _confirmOrder(context),
                          child: const Text('Confirm order'),
                        ),
                      ),
                    ],
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
