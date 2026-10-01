# Cure.fit Fitness & Wellness

A Flutter mobile application that integrates gym workouts, live classes, yoga, meditation, healthy meal delivery, doctor consultations, and family membership management into a unified wellness platform.

This is an academic university demonstration project engineered to showcase modern Flutter frontend architecture, custom component design, reactive state management, and fluid UI flows. The application runs entirely offline using structured local mock data, with zero external backend, database, or API dependencies.

---

## Table of Contents

- [Overview](#overview)
- [Core Features](#core-features)
  - [Workouts & Live Classes](#workouts--live-classes)
  - [Yoga Studio](#yoga-studio)
  - [Meditation & Mindfulness](#meditation--mindfulness)
  - [Nutrition & Healthy Meal Delivery](#nutrition--healthy-meal-delivery)
  - [Challenges & Badges](#challenges--badges)
  - [Progress & Analytics](#progress--analytics)
  - [Telehealth Consultations](#telehealth-consultations)
  - [Family & Membership Plans](#family--membership-plans)
  - [Profile, Settings & Legal](#profile-settings--legal)
- [Design System & Theme](#design-system--theme)
- [Architecture & State Management](#architecture--state-management)
- [Project Structure](#project-structure)
- [Pricing Structure](#pricing-structure)
- [Simulated Capabilities](#simulated-capabilities)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Testing & Quality Assurance](#testing--quality-assurance)
- [Demo Presentation Flow](#demo-presentation-flow)
- [Project Scope & Disclaimer](#project-scope--disclaimer)
- [Author & Credits](#author--credits)

---

## Overview

- **Problem Statement**: Modern wellness applications often fragment user experiences across disparate apps for workouts, nutrition, mindfulness, and healthcare. Cure.fit provides a cohesive design and navigation paradigm that combines all wellness verticals under one mobile interface.
- **Approach**: Focus on a complete, robust frontend presentation. Every screen, state transition, dialog, sheet, and form is implemented as native Flutter UI. Real-world services are simulated locally with realistic mock data and responsive client-side state.
- **Complexity Level**: Intermediate Flutter development featuring clear widget composition, predictable `setState` updates, reactive `ChangeNotifier` coordination, custom painters, and a clean flat architecture without unnecessary abstraction layers.

---

## Core Features

### Workouts & Live Classes
- **Session Library**: Filterable workout list categorized by target areas (Strength, HIIT, Core, Upper Body, Lower Body).
- **Live Class Experience**: Immersive dark-mode classroom interface featuring trainer stream display, live attendee grid, and interactive session controls.
- **Biometric Zones**: Dynamic heart rate tracking across 5 simulated zones (Recovery, Fat Burn, Cardio, Peak, Maximum) with real-time zone status.
- **Simulated Wearable Sync**: One-tap toggle simulating Bluetooth connectivity with fitness trackers.
- **Real-Time Workout Tracking**: Active session mode with pose estimation overlay (custom painter skeletal wireframe), real-time rep counter, elapsed timer, calorie burn counter, and posture feedback cues.

### Yoga Studio
- **Guided Routines**: Categorized sessions for Morning Yoga, Flexibility, Back Care, Strength, and Stress Relief.
- **Active Pose Studio**: Dedicated pose player with step-by-step guidance, pose duration timers, alignment feedback, and pose-by-pose navigation.

### Meditation & Mindfulness
- **Audio Library**: Curated sessions for Breathing, Sleep, Stress Relief, Focus, and Guided Meditation.
- **Mindfulness Player**: Calming ambient dark-mode player with progress scrubber, playback toggles, elapsed duration counter, and ambient background sound mixing (Rain, Forest, Waves, White Noise) with individual volume controls.

### Nutrition & Healthy Meal Delivery
- **Daily Meal Planner**: Tabulated schedule tracking Breakfast, Lunch, Dinner, and Snacks.
- **Macro & Calorie Engine**: Automatic calculation of daily calories, protein, carbs, and fat with visual breakdown charts.
- **Automated Grocery Checklist**: Generates consolidated ingredient shopping checklists from planned meals with interactive item completion toggles and clear-all actions.
- **Healthy Delivery Menu**: 2-column food catalog with high-resolution food thumbnails (16:10 aspect ratio), detailed nutrition statistics, and direct "Add to order" buttons.
- **Cart & Order Flow**: Full slide-over cart drawer with price subtotals, item removal, and simulated checkout confirmation.

### Challenges & Badges
- **Active Fitness Challenges**: Community events with progress bars, participant counters, and join/leave status toggles.
- **Live Leaderboard**: Community ranking board highlighting your current ranking and point totals.
- **Achievement Badges**: Grid of milestones (e.g., Streak Master, Century Club, Early Riser) with locked/unlocked states and tap-to-inspect requirements modal.

### Progress & Analytics
- **Summary Metrics**: High-level counters for completed workouts, total calories burned, active streak days, and total minutes.
- **Monthly Activity Calendar**: Interactive 30-day calendar displaying workout completion indicators.
- **Weekly Bar Charts**: Visual charts tracking weekly volume and calorie burn distributions.
- **Transformation Timeline**: Side-by-side Before and After visual progress photo comparisons.

### Telehealth Consultations
- **Specialist Directory**: Filter verified specialists by specialty (Nutritionist, Physiotherapist, General Physician, Sports Medicine, Mental Wellness).
- **Doctor Profiles & Booking**: Comprehensive profiles detailing qualifications, experience, consultation fees, and available time slots with simulated appointment confirmation.

### Family & Membership Plans
- **Cult Pass Tiers**: Comparison between Monthly Pass and Annual Pass with highlighted savings.
- **Family Plan Management**: Add, update, and remove linked family member profiles.
- **Automated Discount Engine**: Real-time 50% discount calculator for each linked family member.

### Profile, Settings & Legal
- **User Hub**: Profile overview displaying streak, membership status, and quick links.
- **App Preferences**: Notification toggles and simulated wearable sync switches.
- **Legal Compliance**: Complete, dedicated screens for Terms of Service and Privacy Policy.

---

## Design System & Theme

The user interface follows a clean, earthy, and functional aesthetic designed to foster focus and calm:

- **Color Palette**:
  - Deep Forest (`#161A17`): Primary headers, high-contrast dark surfaces, and text.
  - Charcoal Olive (`#2C302B`): Secondary surfaces, dark cards, and player backgrounds.
  - Soft Bone (`#F9F8F6`): Neutral background canvas.
  - Warm Oat (`#EFECE6`): Inactive chips, secondary containers, and borders.
  - Teal (`#5E8C83`): Primary call-to-action buttons and active indicators.
  - Sage (`#94A89A`): Completed states and success accents.
  - Terracotta (`#C26D53`): Live class badges and warning indicators.
  - Orange (`#D48344`): Calorie counters and metric highlights.
- **Typography**: Work Sans font family across a disciplined scale (24px Title, 16px Subtitle, 14px Body, 12px Label).
- **Component Geometry**: Solid fills, subtle 1px borders, and consistent border radii (4px small, 6px medium, 8px large).
- **No Emojis or Drop Shadows**: Clean flat presentation relying on typography, color contrast, and outlined Material Icons.
- **Skeleton Screens**: Built-in skeleton pulse loaders for all lists, dashboards, and media grids during content loading.

---

## Architecture & State Management

The application is structured for clarity, maintainability, and quick comprehension:

```
                  +-------------------------+
                  |       main.dart         |
                  +------------+------------+
                               |
                        +------v------+
                        | SplashScreen|
                        +------+------+
                               |
                        +------v------+
                        | MainScreen  |
                        +------+------+
                               |
     +------------+------------+------------+------------+
     |            |            |            |            |
+----v-----+ +----v----+ +-----v----+ +-----v----+ +-----v-----+
|   Home   | |Workouts | |Nutrition | | Progress | |  Profile  |
|  Screen  | | Screen  | |  Screen  | |  Screen  | |  Screen   |
+----+-----+ +----+----+ +-----+----+ +-----+----+ +-----+-----+
     |            |            |            |            |
     +------------+------------+------------+------------+
                               |
                     +---------v---------+
                     |    app_state.dart | (Global ChangeNotifier)
                     +-------------------+
```

- **Global State**: Managed centrally through `app_state.dart` via Flutter's native `ChangeNotifier`.
- **Reactive UI**: Screens subscribe using `AnimatedBuilder`, re-rendering automatically when workouts are completed, cart items change, or family members are modified.
- **Local Ephemeral State**: Handled cleanly with `StatefulWidget` and `setState` for tab switching, timers, and input forms.
- **Navigation**: Clean declarative and imperative navigation using standard `Navigator.push` and `Navigator.pop`.

---

## Project Structure

```
lib/
|-- main.dart                         # Application entrypoint
|-- app_state.dart                    # Central shared ChangeNotifier state
|-- models/                           # Immutable data model classes
|   |-- achievement.dart
|   |-- challenge.dart
|   |-- doctor.dart
|   |-- family_member.dart
|   |-- meal.dart
|   |-- meditation.dart
|   |-- membership_plan.dart
|   |-- participant.dart
|   |-- progress_photo.dart
|   |-- workout.dart
|   `-- yoga_session.dart
|-- data/                             # Mock data repositories and legal texts
|   |-- achievement_data.dart
|   |-- challenge_data.dart
|   |-- doctor_data.dart
|   |-- family_data.dart
|   |-- legal_text.dart
|   |-- meal_data.dart
|   |-- meditation_data.dart
|   |-- membership_data.dart
|   |-- participant_data.dart
|   |-- progress_data.dart
|   |-- workout_data.dart
|   `-- yoga_data.dart
|-- screens/                          # Screen widgets organized by feature
|   |-- splash_screen.dart
|   |-- main_screen.dart
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
|-- widgets/                          # Reusable UI component library
|   |-- achievement_card.dart
|   |-- challenge_card.dart
|   |-- doctor_card.dart
|   |-- meal_card.dart
|   |-- primary_button.dart
|   |-- section_header.dart
|   |-- skeleton_box.dart
|   |-- stat_card.dart
|   `-- workout_card.dart
`-- theme/                            # Design tokens and theme definitions
    `-- app_theme.dart
```

---

## Pricing Structure

The application displays transparent membership and nutrition pricing tiers:

| Tier | Listed Price | Inclusions |
| :--- | :--- | :--- |
| **Monthly Pass** | ₹999 / month | Unlimited live workouts, yoga, and meditation |
| **Annual Membership** | ₹6999 / year | All-access pass with 40% annual savings |
| **Healthy Meal Plan** | ₹399 / day | 3 customized chef-curated nutrition meals |
| **Family Add-On** | 50% discount | Half-price pass applied to selected membership |

*Family Discount Illustration:*
- Under the **Monthly Pass**, each additional family member pass is billed at **₹499.50/month**.
- Under the **Annual Membership**, each additional family member pass is billed at **₹3,499.50/year**.

---

## Simulated Capabilities

All operations in this project are intentionally simulated on the client side:

| Capability | Client Simulation Mechanism |
| :--- | :--- |
| **Live Workout Stream** | High-contrast instructor view with real-time periodic metrics |
| **Rep Counting** | Animated timer-based increment counter simulating motion capture |
| **Pose Detection** | Skeletal joint overlay using Flutter CustomPainter |
| **Heart Rate** | Periodic algorithm fluctuating heart rate within biometric zones |
| **Wearable Sync** | Simulated Bluetooth connection status with reactive UI banner |
| **Meal Delivery** | Client-side cart calculation with animated confirmation dialog |
| **Doctor Consultations** | Slot selection with instant local appointment confirmation |
| **Family Members** | In-memory CRUD operations with state persistence during the session |

---

## Tech Stack

- **Framework**: Flutter (Dart SDK ^3.13.0)
- **Platforms Supported**: Android, iOS, macOS, Web, Linux, Windows
- **State Management**: Built-in `ChangeNotifier` with `AnimatedBuilder`
- **Iconography**: Flutter Material Icons (Outlined)
- **Typography**: Google Work Sans font bundled locally in `assets/fonts/`
- **Zero Third-Party Clutter**: Pure Flutter implementation without unnecessary external packages

---

## Getting Started

### Prerequisites

Ensure you have the following installed on your development workstation:
- Flutter SDK (stable channel, 3.13.0 or newer)
- Dart SDK (bundled with Flutter)
- Android Studio / Xcode (for device emulators)
- Git command-line tool

Verify your installation by running:
```bash
flutter doctor
```

### Installation

Clone the repository to your local machine:
```bash
git clone https://github.com/Rehan225/cure_fit.git
cd cure_fit
```

Fetch project dependencies:
```bash
flutter pub get
```

### Running the App

Launch the application on an active simulator, emulator, or connected physical device:
```bash
flutter run
```

---

## Testing & Quality Assurance

The codebase includes automated tests validating launch transitions, tab navigation, sub-screen flows, state transitions, and overflow prevention:

Run static analysis:
```bash
flutter analyze
```

Run test suite:
```bash
flutter test
```

Build verification (compiles Dart kernel and validates asset packaging):
```bash
flutter build bundle
```

---

## Demo Presentation Flow

Recommended sequence when walking through the application:

1. **Splash & Dashboard**: Launch the app, observe the branded fade transition, and explore the Home dashboard overview.
2. **Workouts & Live Stream**: Open the Workouts tab, inspect category filters, and join the active Live Class to view the dark theme, participant grid, and heart rate telemetry.
3. **Active Rep Tracking**: Start a workout tracking session to view the custom pose estimation overlay and rep counter.
4. **Mindfulness & Audio**: Open Yoga and Meditation routines, launch the meditation player, and experiment with ambient sound sliders.
5. **Nutrition & Delivery**: Navigate to Nutrition, examine macro totals, generate the consolidated grocery checklist, browse the Healthy Delivery grid, and add meals to the cart.
6. **Community & Challenges**: Review active fitness challenges, inspect the community leaderboard, and tap badges to view achievement criteria.
7. **Progress Analytics**: Inspect the 30-day activity calendar, weekly charts, and before/after photo timeline.
8. **Doctor Booking**: Filter specialists, select a doctor profile, pick an appointment slot, and complete the booking.
9. **Family & Legal**: Open Profile to manage family passes, inspect 50% discount calculations, switch preferences in Settings, and review the Terms of Service.

---

## Project Scope & Disclaimer

This software was developed solely as an academic university project to demonstrate mobile application engineering and user interface design in Flutter. 

- No real payments or financial transactions are processed.
- No real medical advice or actual doctor consultations are provided.
- No actual food ordering or delivery logistics are dispatched.
- All biometric figures, participant profiles, and workout metrics are generated simulations.

---

## Author & Credits

- **Developer**: Rehan Mulani
- **GitHub**: [@Rehan225](https://github.com/Rehan225)
- **Repository**: [https://github.com/Rehan225/cure_fit](https://github.com/Rehan225/cure_fit)
- **Year**: 2026

