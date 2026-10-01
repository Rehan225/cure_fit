import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/challenge_data.dart';
import '../../models/achievement.dart';
import '../../theme/app_theme.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/challenge_card.dart';

class ChallengesScreen extends StatefulWidget {
  final int initialTabIndex;

  const ChallengesScreen({super.key, this.initialTabIndex = 0});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAchievementDialog(Achievement achievement) {
    showDialog(
      context: context,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: achievement.isUnlocked
                            ? AppColors.sage
                            : AppColors.warmOat,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: Icon(
                        achievement.isUnlocked
                            ? Icons.military_tech_outlined
                            : Icons.lock_outline,
                        color: AppColors.deepForest,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                      color: AppColors.deepForest,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(achievement.title, style: AppTextStyles.title),
                const SizedBox(height: 6),
                Text(achievement.description, style: AppTextStyles.body),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Text(
                    'Requirement: ${achievement.unlockCondition}',
                    style: AppTextStyles.label,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChallengesTab() {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            ...appState.challenges.map((challenge) {
              return ChallengeCard(
                challenge: challenge,
                onToggleJoin: () {
                  appState.toggleChallengeJoin(challenge.id);
                },
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildLeaderboardTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: mockLeaderboard.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final user = mockLeaderboard[index];
        final isYou = user.isCurrentUser;

        return Container(
          decoration: BoxDecoration(
            color: isYou ? AppColors.warmOat : AppColors.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isYou ? AppColors.teal : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Text(
                  '${user.rank}',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepForest,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  user.name,
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 14,
                    fontWeight: isYou ? FontWeight.w600 : FontWeight.w500,
                    color: AppColors.deepForest,
                  ),
                ),
              ),
              Text(
                '${user.points} pts',
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepForest,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementsTab() {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.05,
          ),
          itemCount: appState.achievements.length,
          itemBuilder: (context, index) {
            final ach = appState.achievements[index];
            return AchievementCard(
              achievement: ach,
              onTap: () => _showAchievementDialog(ach),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Challenges & Badges', style: AppTextStyles.title),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.deepForest,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.deepForest,
          indicatorWeight: 2,
          tabs: const [
            Tab(text: 'Challenges'),
            Tab(text: 'Leaderboard'),
            Tab(text: 'Badges'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChallengesTab(),
          _buildLeaderboardTab(),
          _buildAchievementsTab(),
        ],
      ),
    );
  }
}
