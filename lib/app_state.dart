import 'package:flutter/foundation.dart';

import 'models/achievement.dart';
import 'models/challenge.dart';
import 'models/family_member.dart';
import 'models/meal.dart';
import 'models/membership_plan.dart';
import 'data/achievement_data.dart';
import 'data/challenge_data.dart';
import 'data/family_data.dart';
import 'data/meal_data.dart';
import 'data/membership_data.dart';

class AppState extends ChangeNotifier {
  // Stats
  int completedWorkoutsCount = 7;
  int totalCaloriesBurned = 3420;
  int currentStreak = 7;
  int workoutMinutes = 240;
  int currentHeartRate = 72;

  // Challenges and Achievements
  List<Challenge> challenges = List.from(mockChallenges);
  List<Achievement> achievements = List.from(mockAchievements);

  // Family
  List<FamilyMember> familyMembers = List.from(initialFamilyMembers);

  // Meal Planner & Grocery
  List<Meal> plannedMeals = [
    mockMeals[0], // Breakfast
    mockMeals[2], // Lunch
    mockMeals[4], // Dinner
    mockMeals[6], // Snack
  ];
  Map<String, bool> groceryCheckedItems = {};

  // Healthy Meal Delivery Cart
  List<Meal> cartItems = [];

  // Membership
  MembershipPlan activeMembership = annualPlan;
  bool hasMealPlanAddon = false;
  int familyAddonCount = 2;

  // New unlocked achievement for dialog notification
  Achievement? newlyUnlockedAchievement;

  // Complete workout logic
  void completeWorkout({required int calories, required int minutes}) {
    completedWorkoutsCount += 1;
    totalCaloriesBurned += calories;
    workoutMinutes += minutes;

    // Check achievement unlock conditions
    _checkAchievements();
    notifyListeners();
  }

  void _checkAchievements() {
    for (int i = 0; i < achievements.length; i++) {
      final ach = achievements[i];
      if (!ach.isUnlocked) {
        if (ach.id == 'ach_2' && completedWorkoutsCount >= 10) {
          achievements[i] = ach.copyWith(
            isUnlocked: true,
            currentProgress: completedWorkoutsCount,
          );
          newlyUnlockedAchievement = achievements[i];
        } else if (ach.id == 'ach_4' && totalCaloriesBurned >= 5000) {
          achievements[i] = ach.copyWith(
            isUnlocked: true,
            currentProgress: totalCaloriesBurned,
          );
          newlyUnlockedAchievement = achievements[i];
        }
      }
    }
  }

  void clearNewlyUnlockedAchievement() {
    newlyUnlockedAchievement = null;
    notifyListeners();
  }

  // Challenge actions
  void toggleChallengeJoin(String id) {
    final index = challenges.indexWhere((c) => c.id == id);
    if (index != -1) {
      final current = challenges[index];
      challenges[index] = current.copyWith(isJoined: !current.isJoined);
      notifyListeners();
    }
  }

  // Family actions
  void addFamilyMember(FamilyMember member) {
    familyMembers.add(member);
    notifyListeners();
  }

  void updateFamilyMember(FamilyMember member) {
    final index = familyMembers.indexWhere((m) => m.id == member.id);
    if (index != -1) {
      familyMembers[index] = member;
      notifyListeners();
    }
  }

  void removeFamilyMember(String id) {
    familyMembers.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  // Meal planner actions
  void addMealToPlan(Meal meal) {
    plannedMeals.add(meal);
    notifyListeners();
  }

  void removeMealFromPlan(String mealId) {
    plannedMeals.removeWhere((m) => m.id == mealId);
    notifyListeners();
  }

  int get totalPlannedCalories {
    int sum = 0;
    for (final meal in plannedMeals) {
      sum += meal.calories;
    }
    return sum;
  }

  int get totalPlannedProtein {
    int sum = 0;
    for (final meal in plannedMeals) {
      sum += meal.protein;
    }
    return sum;
  }

  int get totalPlannedCarbs {
    int sum = 0;
    for (final meal in plannedMeals) {
      sum += meal.carbs;
    }
    return sum;
  }

  int get totalPlannedFat {
    int sum = 0;
    for (final meal in plannedMeals) {
      sum += meal.fat;
    }
    return sum;
  }

  List<String> get generatedGroceryList {
    final Set<String> items = {};
    for (final meal in plannedMeals) {
      items.addAll(meal.ingredients);
    }
    return items.toList();
  }

  void toggleGroceryItem(String item) {
    groceryCheckedItems[item] = !(groceryCheckedItems[item] ?? false);
    notifyListeners();
  }

  void toggleAllGroceryItems(bool checked) {
    final items = generatedGroceryList;
    for (final item in items) {
      groceryCheckedItems[item] = checked;
    }
    notifyListeners();
  }

  // Cart actions
  void addToCart(Meal meal) {
    cartItems.add(meal);
    notifyListeners();
  }

  void removeFromCart(Meal meal) {
    cartItems.remove(meal);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  int get cartTotal {
    int sum = 0;
    for (final item in cartItems) {
      sum += item.price;
    }
    return sum;
  }

  // Membership actions
  void selectMembership(MembershipPlan plan) {
    activeMembership = plan;
    notifyListeners();
  }

  void toggleMealPlanAddon() {
    hasMealPlanAddon = !hasMealPlanAddon;
    notifyListeners();
  }

  void setFamilyAddonCount(int count) {
    familyAddonCount = count;
    notifyListeners();
  }
}

// Global shared state instance
final appState = AppState();
