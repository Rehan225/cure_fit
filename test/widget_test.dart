import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cure_fit/main.dart';
import 'package:cure_fit/app_state.dart';
import 'package:cure_fit/screens/profile/settings_screen.dart';
import 'package:cure_fit/screens/profile/terms_screen.dart';
import 'package:cure_fit/screens/profile/privacy_screen.dart';
import 'package:cure_fit/screens/nutrition/grocery_list_screen.dart';
import 'package:cure_fit/screens/membership/membership_screen.dart';
import 'package:cure_fit/screens/family/family_list_screen.dart';
import 'package:cure_fit/screens/challenges/challenges_screen.dart';
import 'package:cure_fit/screens/doctors/doctor_list_screen.dart';
import 'package:cure_fit/screens/yoga/yoga_list_screen.dart';
import 'package:cure_fit/screens/meditation/meditation_list_screen.dart';
import 'package:cure_fit/screens/workouts/workout_detail_screen.dart';
import 'package:cure_fit/screens/workouts/live_workout_screen.dart';
import 'package:cure_fit/data/workout_data.dart';
import 'package:cure_fit/models/membership_plan.dart';
import 'package:cure_fit/theme/app_theme.dart';

void main() {
  testWidgets('App launch and splash transition test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CureFitApp());

    // Verify splash screen wordmark is present
    expect(find.text('Cure.fit'), findsOneWidget);
    expect(find.text('Fitness and Wellness'), findsOneWidget);

    // Advance beyond splash screen delay (1400ms)
    await tester.pumpAndSettle(const Duration(milliseconds: 1600));

    // Verify bottom navigation bar is present
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Home'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Workouts'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Nutrition'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Progress'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profile'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Tab navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const CureFitApp());
    await tester.pumpAndSettle(const Duration(milliseconds: 1600));

    // Tap Workouts tab
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Workouts'),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Join live class'), findsOneWidget);

    // Tap Nutrition tab
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Nutrition'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Meal Planner'), findsOneWidget);
    expect(find.text('Healthy Delivery'), findsOneWidget);

    // Tap Progress tab
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Progress'),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Progress & History'), findsOneWidget);

    // Tap Profile tab
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Profile'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
  });

  testWidgets('Settings and Legal screens test without assertion errors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const SettingsScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);

    // Tap Terms of Service
    await tester.tap(find.text('Terms of Service'));
    await tester.pumpAndSettle();
    expect(find.byType(TermsScreen), findsOneWidget);

    // Go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Tap Privacy Policy
    await tester.tap(find.text('Privacy Policy'));
    await tester.pumpAndSettle();
    expect(find.byType(PrivacyScreen), findsOneWidget);
  });

  testWidgets('Sub-screens smoke test', (WidgetTester tester) async {
    // Test GroceryListScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const GroceryListScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Grocery List'), findsOneWidget);

    // Test MembershipScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const MembershipScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Membership & Plans'), findsOneWidget);

    // Test FamilyListScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const FamilyListScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Family Plan'), findsOneWidget);

    // Test ChallengesScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const ChallengesScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Challenges & Badges'), findsOneWidget);

    // Test DoctorListScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const DoctorListScreen()),
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Doctor Consultations'), findsOneWidget);

    // Test YogaListScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const YogaListScreen()),
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Yoga Studio'), findsOneWidget);

    // Test MeditationListScreen
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const MeditationListScreen()),
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pumpAndSettle();
    expect(find.text('Meditation'), findsOneWidget);

    // Test WorkoutDetailScreen
    final sampleWorkout = mockWorkouts.first;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: WorkoutDetailScreen(workout: sampleWorkout),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(sampleWorkout.title), findsWidgets);

    // Test LiveWorkoutScreen
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: LiveWorkoutScreen(workout: sampleWorkout),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(LiveWorkoutScreen), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
  });

  test('AppState state transitions and logic', () {
    // Test initial state
    expect(appState.completedWorkoutsCount, greaterThan(0));
    expect(appState.totalCaloriesBurned, greaterThan(0));
    expect(appState.activeMembership.type, MembershipType.annual);

    // Test workout completion
    final initialCalories = appState.totalCaloriesBurned;
    final initialCount = appState.completedWorkoutsCount;
    appState.completeWorkout(calories: 300, minutes: 30);
    expect(appState.totalCaloriesBurned, initialCalories + 300);
    expect(appState.completedWorkoutsCount, initialCount + 1);

    // Test grocery checklist
    final items = appState.generatedGroceryList;
    if (items.isNotEmpty) {
      final firstItem = items.first;
      appState.toggleGroceryItem(firstItem);
      expect(appState.groceryCheckedItems[firstItem], true);
      appState.toggleAllGroceryItems(false);
      expect(appState.groceryCheckedItems[firstItem], false);
    }

    // Test cart actions
    final sampleMeal = appState.plannedMeals.first;
    appState.clearCart();
    expect(appState.cartItems.isEmpty, true);
    appState.addToCart(sampleMeal);
    expect(appState.cartItems.length, 1);
    expect(appState.cartTotal, sampleMeal.price);
    appState.removeFromCart(sampleMeal);
    expect(appState.cartItems.isEmpty, true);
  });
}
