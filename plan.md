# Cure.fit Fitness & Wellness - Flutter Project Plan

## 1. Project Overview

**Project Name:** Cure.fit Fitness & Wellness
**Industry:** Fitness & Wellness
**Level:** Beginner to Intermediate
**Platform:** Flutter (mobile)
**Purpose:** University project that showcases the ability to build a complete, polished, multi-feature Flutter application.

### Problem Statement (from university)

Cure.fit wants an integrated Flutter app combining gym workouts, yoga sessions, meditation, healthy meal delivery, and doctor consultations with a seamless user experience across all wellness services.

This project is a frontend-only implementation. All data, services and "smart" features (pose detection, wearable sync, payments, doctor availability, delivery) are simulated with local mock data. The app should look and behave like a real wellness app from the user's point of view, while staying simple enough to understand and explain.

### Companion document

Visual design (colors, typography, spacing, components, screen direction, and the list of patterns to avoid) is defined in **`design.md`**. This plan defines what to build. `design.md` defines how it looks. Both must be followed.

---

## 2. Project Principles

1. Build the complete frontend experience, not production infrastructure.
2. Beginner to intermediate code: simple classes, simple widgets, readable logic.
3. Clean, small, simple project directory that reflects the size of the project.
4. No emojis and no em dashes anywhere in the codebase, UI text or mock data.
5. Minimal packages.
6. Clarity over cleverness. Functionality over architecture.
7. The finished app must feel deliberately designed, not template-generated (see `design.md`).

---

## 3. Out of Scope (Must NOT Be Implemented)

The following must not exist in the project, not even as real systems:

- Firebase or any backend
- Backend deployment or server
- Authentication (no login, no signup, no accounts)
- REST APIs or GraphQL
- Real-time database or WebSockets
- Real-time video streaming or WebRTC
- Real pose-estimation model, machine learning or computer vision
- Real camera-based rep detection
- Real wearable or smartwatch integration
- Real payment gateway or real subscription billing
- Real doctor availability or scheduling system
- Real food delivery or order fulfillment
- Complex database architecture
- Cloud storage or cloud functions

The app starts at the splash screen and goes straight to the main app. There is no login or signup screen.

---

## 4. Required Features (Mapped to the University Brief)

Every item below must be visible and demonstrable in the app.

| # | Required Feature | Frontend Implementation |
| --- | --- | --- |
| 1 | Live workout classes with instructor video and participant grid | Local video (or placeholder image) for the instructor plus a grid of mock participants |
| 2 | Workout tracking with rep counting | Simulated rep counter driven by a local timer |
| 3 | Rep counting via phone camera (pose estimation) | Camera preview placeholder with simulated pose status (no real detection) |
| 4 | Form correction tips | Predefined feedback text shown during the workout |
| 5 | Calories burned display | Local calculation or mock values that update during a workout |
| 6 | Heart rate zones | Mock heart rate that changes over time, mapped to Zone 1 to Zone 5 |
| 7 | Heart rate with wearable sync | Simulated "Sync wearable" button and status (mock data, no real device) |
| 8 | Meal planner with calorie calculation | Breakfast, lunch, dinner, snacks with a daily total that updates when meals are added or removed |
| 9 | Grocery list generation | List generated from the ingredients of the planned meals, with check-off |
| 10 | Meditation library with ambient sounds | Library of sessions plus ambient sound selector and volume control |
| 11 | Guided meditation sessions | Meditation player with play and pause, progress and completion |
| 12 | Fitness challenges | Active and completed challenges with progress and join button |
| 13 | Leaderboard | Hardcoded ranked users, including "You" |
| 14 | Achievement badges | Locked and unlocked badge grid |
| 15 | Achievement unlock conditions | Simple local logic (example: 10 workouts unlocks Workout Warrior) |
| 16 | Progress photos timeline with date stamps | Bundled sample images shown in a dated timeline |
| 17 | Yoga session with pose detection and alignment tips | Yoga player with simulated pose status and alignment tips |
| 18 | Doctor consultation booking with specialist selection | Specialist, doctor, date, time, summary, confirmation |
| 19 | Healthy meal delivery with menu and nutrition info | Menu, meal details, nutrition, simulated order flow |
| 20 | Family plan member management with profiles | Add, edit, remove, view family members |
| 21 | Pricing strategy | Membership screen with exact prices (Section 5) |

---

## 5. Pricing Requirements

These must be shown exactly as written:

| Plan | Price | Detail |
| --- | --- | --- |
| Monthly Pass | ₹999 / month | Unlimited live classes |
| Annual Membership | ₹6999 / year | Save 40% |
| Meal Plan | ₹399 / day | 3 healthy meals |
| Family Plan | Additional member at 50% discount | Applies to the selected membership |

Notes:

- The annual label must read "Save 40%" as given in the brief.
- Family discount rule (simple local logic): each added member costs 50% of the selected membership price. Example for Monthly: each extra member is ₹499.50. Example for Annual: each extra member is ₹3499.50.
- Plan selection only shows a confirmation dialog and a "Membership activated" state. No payment of any kind.
- Layout: do not show a three-column or three-tier pricing row. Monthly and Annual are two stacked selectable rows. Meal Plan and Family Plan are separate add-on rows (see `design.md`, section 7.7).

---

## 6. Navigation Structure

Bottom navigation with five tabs:

```
Home | Workouts | Nutrition | Progress | Profile
```

```
Home
  Live Workout, Yoga, Meditation, Challenges,
  Doctor Consultation, Healthy Meals

Workouts
  Workout Library, Live Classes, Workout Tracking, Yoga

Nutrition
  Meal Planner, Healthy Meals, Meal Details, Order Summary, Grocery List

Progress
  Workout Statistics, Calories, Heart Rate, Challenges,
  Leaderboard, Achievements, Progress Photos

Profile
  Personal Profile, Family Members, Membership, Settings
    Settings
      Legal: Terms of Service, Privacy Policy
```

Navigation uses `Navigator.push()` and `Navigator.pop()` (or simple named routes). No routing package.

---

## 7. Screen Specifications

### 7.1 Splash Screen
App name, Cure.fit-inspired wordmark, a simple fade-in, then navigation to the main app. No real initialization.

### 7.2 Home Dashboard
Order of sections:

1. Header with wordmark, notification icon, greeting and profile image
2. Three module cards stacked vertically at full width:
   - Activity (steps and calories burned)
   - Nutrition (meals logged, progress bar)
   - Wellness (Meditation and Yoga shortcuts)
3. Daily stats: calories burned, workout minutes, current heart rate
4. Live workout card
5. Recommended workout
6. Meal recommendation
7. Current challenge
8. Achievement preview

Never place three feature cards side by side in a row.

### 7.3 Live Workout Classes
- Class list with title, instructor, duration, difficulty, participant count, scheduled time
- "Live now" highlight
- Class details and a Join class button

### 7.4 Live Workout Screen
- Instructor video area (local video or placeholder image, not streamed)
- Participant grid using mock profile images
- Workout timer
- Current exercise
- Rep counter
- Calories burned
- Heart rate and heart rate zone
- Pause and End workout controls

### 7.5 Workout Tracking
- Exercise name, rep count, target reps, timer
- Exercise progress indicator
- Start exercise button (starts simulated rep counting)
- Form correction tips
- Calories burned
- Workout completion summary
- Completing a workout updates local progress and can unlock achievements

### 7.6 Simulated Pose Detection (Workouts)
- Camera preview placeholder with a static pose overlay
- Status panel with values such as Posture: Good, Knee alignment: Good, Back position: Needs improvement
- Predefined tip, for example "Keep your back straight."
- Status values rotate from a local list or timer. No camera processing and no ML.

### 7.7 Calories and Heart Rate Zones
Zones (mock values mapped with simple if/else logic):

```
Zone 1 - Recovery
Zone 2 - Fat Burn
Zone 3 - Cardio
Zone 4 - Peak
Zone 5 - Maximum
```

- Shown as a five-segment bar with the active zone highlighted and named in text.
- Includes a "Sync wearable" button that shows a short loading state and then a "Wearable synced" status with mock values. No real device connection.

### 7.8 Yoga
- Categories: Beginner, Flexibility, Strength, Morning Yoga, Stress Relief, Back Care
- Session list with difficulty, duration, instructor
- Yoga session screen: pose image and name, hold timer, instructions, progress, next pose
- Simulated pose detection and alignment tips (Back: Good, Leg: Good, Shoulders: Adjust)

### 7.9 Meditation
- Library with categories: Guided, Sleep, Stress Relief, Breathing, Focus
- Each item: title, duration, description, category, image
- Player: play and pause, progress indicator, ambient sound selector (for example Rain, Forest, Ocean), volume control, session completion
- Local audio files or placeholder controls

### 7.10 Meal Planner
- Breakfast, lunch, dinner, snacks
- Calories, protein, carbohydrates, fat
- Daily calorie total (breakfast + lunch + dinner + snacks), updated when meals are added or removed
- Generate grocery list button

### 7.11 Grocery List
- Generated from the ingredients of the meals in today's plan
- Duplicate ingredients combined
- Checkbox to mark items as done

### 7.12 Healthy Meal Delivery
- Menu with meal image, name, price, calories, protein
- Meal details: ingredients, description, full nutrition info
- Order flow (all local):

```
Meal Menu -> Meal Details -> Add to Order -> Order Summary
  -> Confirm Order -> Order Confirmed
```

### 7.13 Challenges and Leaderboard
- Active and completed challenges with goal, duration, participants, progress bar, percentage
- Join challenge button
- Leaderboard with hardcoded users and points, including "You"

### 7.14 Achievements
- Badge grid, visibly different for locked and unlocked
- Each badge shows its unlock condition
- Examples: First Workout, Workout Warrior (10 workouts), 7 Day Streak, Calorie Crusher (5,000 calories), Yoga Beginner (5 yoga sessions)
- Unlock logic example:

```dart
if (completedWorkouts >= 10) {
  achievementUnlocked = true;
}
```

- Unlocking shows a simple dialog with the badge and a short message. No confetti or sparkle effects.
- State lasts for the app session only.

### 7.15 Progress
- Total workouts, total calories, workout time, current streak
- Monthly calendar with logged workout days marked
- Simple charts: weekly calories, weekly workout duration, heart rate zones
- Challenge and achievement progress
- Progress photos timeline: image, date stamp, optional weight and note, in date order, with a before and after comparison

### 7.16 Doctor Consultation
- Specialist categories: Nutritionist, Physiotherapist, General Physician, Sports Medicine, Mental Wellness
- Doctor list, then doctor profile: image, name, specialty, experience, rating, fee, description
- Booking flow (all simulated):

```
Specialist -> Doctor List -> Doctor Profile -> Select Date
  -> Select Time -> Booking Summary -> Booking Confirmed
```

- Hardcoded time slots. No real availability.
- The booking summary shows a short demo-only note and a link to the Terms of Service and Privacy Policy.

### 7.17 Family Plan
- Main user and family members with membership status
- Add, edit, remove member
- Member profile screen
- Form fields: Name, Age, Gender, Fitness Goal (with validation)
- Family discount shown using the rule in Section 5

### 7.18 Membership
- Current plan banner
- Membership section: Monthly and Annual as two stacked selectable rows
- Add-ons section: Meal Plan and Family Plan as separate rows
- Short comparison table (Monthly versus Annual)
- Select plan button, confirmation dialog, "Membership activated" state
- Small line under the button linking to Terms of Service and Privacy Policy
- UI-only, no payment

### 7.19 Profile and Settings
- Profile image, name, age, fitness goal, membership, family member count, unlocked achievements count
- Settings list including a Legal section

### 7.20 Legal Screens (Terms of Service and Privacy Policy)
- Two static, scrollable text screens reachable from Profile, then Settings, then Legal
- Also linked from the membership screen and the doctor booking summary
- Plain mock copy written for the project (what the app is, what data is shown, that nothing is sent anywhere, demo-only medical note)
- No backend, no acceptance tracking, no forms

---

## 8. Loading States (Skeleton Loaders)

- Screens that show lists or dashboards display a skeleton placeholder first, then the mock data after a short simulated delay (about 600 ms, using `Future.delayed`).
- Use one small reusable widget, `SkeletonBox`, built with an `AnimationController` that pulses opacity. No shimmer package and no gradient.
- Apply it to: Home module cards, workout list, meal menu, doctor list, progress charts and progress photos.
- Skeleton shapes should match the final layout (card height, image block, two text lines).

---

## 9. Project Directory

Keep it flat and simple.

```
lib/
|-- main.dart
|-- app_state.dart              (small shared state: completed workouts, calories, unlocked badges, order, meal plan)
|
|-- models/
|   |-- workout.dart
|   |-- participant.dart
|   |-- yoga_session.dart
|   |-- meditation.dart
|   |-- meal.dart
|   |-- doctor.dart
|   |-- challenge.dart
|   |-- achievement.dart
|   |-- family_member.dart
|   |-- membership_plan.dart
|   `-- progress_photo.dart
|
|-- data/
|   |-- workout_data.dart
|   |-- participant_data.dart
|   |-- yoga_data.dart
|   |-- meditation_data.dart
|   |-- meal_data.dart
|   |-- doctor_data.dart
|   |-- challenge_data.dart
|   |-- achievement_data.dart
|   |-- family_data.dart
|   |-- membership_data.dart
|   |-- progress_data.dart
|   `-- legal_text.dart         (Terms of Service and Privacy Policy text)
|
|-- screens/
|   |-- splash_screen.dart
|   |-- main_screen.dart        (bottom navigation)
|   |-- home/
|   |-- workouts/
|   |-- yoga/
|   |-- meditation/
|   |-- nutrition/
|   |-- challenges/
|   |-- progress/
|   |-- doctors/
|   |-- family/
|   |-- membership/
|   `-- profile/
|       |-- profile_screen.dart
|       |-- settings_screen.dart
|       |-- terms_screen.dart
|       `-- privacy_screen.dart
|
|-- widgets/
|   |-- workout_card.dart
|   |-- meal_card.dart
|   |-- doctor_card.dart
|   |-- challenge_card.dart
|   |-- achievement_card.dart
|   |-- stat_card.dart
|   |-- section_header.dart
|   |-- primary_button.dart
|   `-- skeleton_box.dart
|
`-- theme/
    `-- app_theme.dart          (colors, type scale, component themes from design.md)

assets/
|-- images/
|-- videos/
|-- audio/
`-- fonts/                      (Work Sans, bundled locally)
```

Do NOT create these layers: repositories, services, datasources, usecases, entities, domain, infrastructure, dependency injection, or any clean-architecture structure.

Create a reusable widget only when it is used in more than one place.

---

## 10. State Management

- Use `setState` and local widget state for screen-level things (rep count, timers, selected doctor, selected slot, grocery checkboxes, form state, skeleton loading flag).
- For the few values shared across screens (completed workouts, total calories, unlocked achievements, meal plan, current order, membership), use one small `app_state.dart` built with Flutter's built-in `ChangeNotifier`, or simple shared variables.
- No Provider, Riverpod, Bloc, GetX, or any state-management package.

---

## 11. Packages

Keep dependencies minimal. Allowed only if needed:

- `video_player` for the local instructor video
- `audioplayers` (or `just_audio`) for local meditation audio
- `fl_chart` for progress charts (or draw simple charts with built-in widgets)

Fonts are bundled as local assets, so `google_fonts` is not needed. Icons use Flutter's built-in Material Icons (outlined), so no icon package is added.

Not allowed: Firebase packages, HTTP or Dio, any backend or authentication package, payment packages, ML or pose-estimation packages, Bluetooth or health/wearable packages, shimmer packages, third-party icon packs.

---

## 12. Mock Data

- All data lives in Dart files under `lib/data/`, separate from screens.
- Data should be realistic enough to look complete: workout names, instructors, participants, meals with nutrition, doctors with specialties and time slots, challenges, leaderboard, achievements, family members, progress photos, legal text.
- Use believable Indian names, realistic calorie values, and the rupee symbol with correct amounts.
- Example:

```dart
final List<Workout> workouts = [
  Workout(
    title: 'Full Body Strength',
    duration: 45,
    calories: 320,
  ),
];
```

---

## 13. Code Style Rules

- **No emojis anywhere**: not in Dart code, comments, strings, button labels, mock data, error messages, or UI text. Use `Icon(Icons.favorite_outline)` style icons instead.
- **No em dashes** in code, comments, UI text or mock data. Use commas, colons or separate sentences.
- Simple, readable, beginner-friendly code that can be explained in a presentation.
- Meaningful names: `WorkoutCard`, `MealPlannerScreen`, `DoctorProfileScreen`.
- Comments only where they help, for example: `// Simulates heart rate changes during the workout.`
- Keep widgets small and avoid giant screen files.
- Avoid unnecessary abstraction, design patterns, and unused features.
- Prefer simple logic:

```dart
final totalCalories = breakfastCalories +
    lunchCalories +
    dinnerCalories +
    snackCalories;
```

---

## 14. UI Design Direction (Summary)

The full rules are in `design.md`. Key points:

- Earthy palette: Deep Forest, Charcoal Olive, Soft Bone, Warm Oat, with Sage, Teal, Orange and Terracotta accents
- Soft Bone background, never pure white or pure black
- Solid fills only, no gradients
- 1px borders instead of shadows, elevation 0 everywhere
- Tight corner radius (4, 6 or 8)
- Work Sans typography, sentence case, scale of 24, 16, 14 and 12
- Material Icons (outlined) only
- One accent per screen area
- Dark treatment for camera and video screens (Live Workout, Workout Tracking, Yoga session, Meditation player)
- Plain rows and numbers instead of checkmark bullets
- No hover animations, no sparkle or confetti, no animated arrows
- Skeleton loaders, Terms of Service and Privacy Policy screens included
- Responsive using `SafeArea`, `Expanded`, `Flexible`, `ListView`, `GridView`, `SingleChildScrollView`

---

## 15. Development Order

1. **Setup:** project, assets, fonts, theme (`app_theme.dart` from `design.md`), `main.dart`, bottom navigation
2. **Basic UI:** splash, home, profile, reusable widgets, `SkeletonBox`
3. **Workouts:** list, details, live workout, participant grid, tracking, rep counter, calories, heart rate zones, wearable sync UI, form correction
4. **Yoga:** library, session, simulated pose detection, alignment tips
5. **Meditation:** library, player, ambient sound UI
6. **Nutrition:** meal planner, calorie calculation, grocery list, meal menu, details, order flow
7. **Challenges:** list, progress, leaderboard, achievements, unlock logic
8. **Progress:** statistics, calendar, charts, progress photos timeline
9. **Doctors:** specialists, list, profile, date and time, booking confirmation
10. **Family:** list, add, edit, remove, member profile
11. **Membership:** plans, pricing, family discount, simulated confirmation
12. **Settings and legal:** settings screen, Terms of Service, Privacy Policy, links from membership and booking
13. **Final polish:** consistent spacing, colors and typography, empty and validation states, skeleton loaders on all list screens, navigation testing, cleanup, design.md checklist review

---

## 16. Testing Checklist

Manually test:

- Bottom navigation and every screen reachable
- Buttons, forms and validation
- Rep counter and timer
- Heart rate zone changes
- Wearable sync simulation
- Meal calorie total updates
- Grocery list generation and checkboxes
- Challenge progress and leaderboard
- Achievement unlocking and unlock dialog
- Doctor booking flow
- Meal order flow
- Family member add, edit, remove
- Membership selection and family discount calculation
- Skeleton loaders appear and then resolve on list and dashboard screens
- Terms of Service and Privacy Policy open from Settings, membership and booking summary
- Scrolling and different mobile screen sizes
- Search the codebase for emojis, em dashes, `Colors.white`, `Colors.black`, `BoxShadow` and `elevation` values above 0

---

## 17. Final Feature Checklist

- [ ] Live workout classes with instructor video and participant grid
- [ ] Workout tracking with rep counting
- [ ] Simulated phone-camera pose detection for rep counting
- [ ] Form correction tips
- [ ] Calories burned display
- [ ] Heart rate zones
- [ ] Simulated wearable sync
- [ ] Meal planner with calorie calculation
- [ ] Grocery list generated from the meal plan
- [ ] Meditation library
- [ ] Ambient sounds
- [ ] Guided meditation sessions
- [ ] Fitness challenges
- [ ] Leaderboard
- [ ] Achievement badges with unlock conditions
- [ ] Progress photos timeline with date stamps
- [ ] Yoga session with simulated pose detection
- [ ] Yoga alignment tips
- [ ] Doctor consultation with specialist selection and booking flow
- [ ] Healthy meal delivery with menu, nutrition info and order flow
- [ ] Family plan member management with profiles
- [ ] Monthly pass ₹999 (unlimited live classes)
- [ ] Annual membership ₹6999 (Save 40%)
- [ ] Meal plan ₹399/day (3 healthy meals)
- [ ] Family plan: additional member at 50% discount
- [ ] Skeleton loaders on list and dashboard screens
- [ ] Terms of Service screen
- [ ] Privacy Policy screen
- [ ] Theme and components follow `design.md`

---

## 18. Definition of Done

- The app launches and all main sections open from the bottom navigation.
- Every feature in the checklist is visibly demonstrable with mock data.
- Pricing matches Section 5 exactly and is not shown as a three-tier row.
- The UI follows `design.md`: palette, type scale, spacing, radius, borders, no shadows, no gradients.
- Skeleton loaders, Terms of Service and Privacy Policy are present.
- The code is simple, readable and beginner-friendly.
- The directory matches Section 9 and stays simple.
- There are no emojis and no em dashes in the codebase or UI text.
- There is no backend, authentication, API, real payment, real wearable, real pose estimation, real video streaming, real doctor system, or real food delivery.

---

## 19. Demonstration Flow

```
Launch -> Home Dashboard -> Live Workout (instructor, participants,
reps, form tips, calories, heart rate, wearable sync) -> Yoga (pose
detection, alignment) -> Meditation (play, ambient sound) -> Meal
Planner (calories, grocery list) -> Challenges (leaderboard, badge
unlock) -> Progress (stats, charts, photos timeline) -> Doctors (book
consultation) -> Healthy Meals (order) -> Profile (family members,
membership plans, Terms of Service, Privacy Policy)
```

---

## 20. Final Principle

> Build the complete frontend experience, not the production infrastructure.

Prioritize clarity over complexity and functionality over unnecessary architecture.
