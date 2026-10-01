# Cure.fit Fitness & Wellness - Design System

This document defines the visual design for the Cure.fit Flutter project. It is based on the provided reference image (palette, typography and five key screens) and is adjusted so the finished app feels deliberately designed rather than generated from a template.

The design direction is **earthy, calm and editorial**: warm neutrals, muted natural accents, flat surfaces separated by thin borders, tight corner radii, and plain language.

---

## 1. Design Principles

1. **Flat and quiet.** Surfaces are separated by color and 1px borders, never by shadows or blur.
2. **Earthy, not loud.** Muted natural colors from the reference palette only. One accent per screen area.
3. **Content first.** Numbers, photos and plain labels carry the interface. Decoration is minimal.
4. **Consistent.** The same spacing, radius, border and type scale on every screen.
5. **Honest copy.** Plain sentence-case text. No hype, no filler, no emojis, no em dashes.
6. **Simple to build.** Everything here can be done with built-in Flutter widgets and one small theme file.

---

## 2. Color

### 2.1 Primary palette (from reference)

| Token | Name | Hex | Use |
| --- | --- | --- | --- |
| `deepForest` | Deep Forest | `#161A17` | Primary text, dark screen background |
| `charcoalOlive` | Charcoal Olive | `#2C3531` | Dark surfaces, cards on dark screens |
| `softBone` | Soft Bone | `#F9F8F6` | App background (never pure white) |
| `warmOat` | Warm Oat | `#E3DAC9` | Dividers, tracks, selected states, placeholders |

### 2.2 Accent palette (from reference)

| Token | Name | Hex | Use |
| --- | --- | --- | --- |
| `sage` | Sage Green | `#7C9082` | Wellness module, secondary data, locked-to-unlocked states |
| `teal` | Fresh Teal | `#48B1BF` | Primary buttons, Activity module, selected day, pose overlay |
| `orange` | Earthy Orange | `#D66853` | Nutrition highlights, calories, alerts badge |
| `terracotta` | Warm Terracotta | `#B56357` | Nutrition module, errors, destructive actions |

### 2.3 Derived neutrals (tints of the palette above)

| Token | Hex | Use |
| --- | --- | --- |
| `surface` | `#F1ECE2` | Card background on light screens (a lighter Warm Oat) |
| `border` | `#D5CBB8` | 1px borders on cards, inputs, dialogs (a darker Warm Oat) |
| `textSecondary` | `#5B6660` | Secondary text on light backgrounds |
| `textOnDarkSecondary` | `#B9C0BB` | Secondary text on dark backgrounds |
| `ochre` | `#C9A66B` | Heart rate Zone 3 only |

### 2.4 Color rules

- The page background is always `softBone`. Pure white (`#FFFFFF`) and pure black (`#000000`) are never used anywhere, including cards, dialogs, images placeholders and text.
- **No gradients anywhere.** Every fill is a single solid color.
- **One accent per screen area.** A screen uses neutrals plus at most one accent, with these exceptions:
  - Home: the three stacked module cards each use their own module color (Activity = teal, Nutrition = terracotta, Wellness = sage).
  - Heart rate zone bar (see 2.5).
- Do not use neon colors, bright pastels, rainbow sequences, or purple.
- Text on `teal`, `orange` and `sage` fills uses `deepForest`. Text on `terracotta`, `charcoalOlive` and `deepForest` fills uses `softBone`.
- `teal` is used as a fill only (buttons, selected day, overlay lines). It is not used for small text on light backgrounds because the contrast is too low. Text links use `deepForest` with an underline.
- Never use color alone to carry meaning. Pair it with a text label (for example "Zone 4 - Peak", "Needs improvement").

### 2.5 Heart rate zones

The zone bar is a row of five **solid, separate segments** (not a gradient), each labeled in text.

| Zone | Name | Color |
| --- | --- | --- |
| 1 | Recovery | `sage` |
| 2 | Fat Burn | `teal` |
| 3 | Cardio | `ochre` |
| 4 | Peak | `orange` |
| 5 | Maximum | `terracotta` |

The active zone segment is full height and the others are dimmed to 40 percent opacity.

---

## 3. Typography

**Font family:** Work Sans, bundled as a local asset (no extra package needed). Fallback: the platform default sans-serif.

```yaml
# pubspec.yaml
flutter:
  fonts:
    - family: WorkSans
      fonts:
        - asset: assets/fonts/WorkSans-Regular.ttf
        - asset: assets/fonts/WorkSans-Medium.ttf
          weight: 500
        - asset: assets/fonts/WorkSans-SemiBold.ttf
          weight: 600
```

Not allowed: Inter, Geist, Space Grotesk, Space Mono, or any grotesk family.

### Type scale (from the reference image)

| Style | Size | Weight | Line height | Use |
| --- | --- | --- | --- | --- |
| Title | 24 | 600 | 1.25 | Screen titles, key headings |
| Subtitle | 16 | 600 | 1.3 | Section headers, card titles |
| Body | 14 | 400 | 1.45 | Paragraphs, list text |
| Label | 12 | 500 | 1.3 | Captions, tags, units, nav labels |
| Metric | 40 | 600 | 1.1 | Large numbers (BPM, calories, rep count) |

- Timers, BPM and rep counters use tabular figures so digits do not jump while updating:
  `fontFeatures: [FontFeature.tabularFigures()]`
- Sentence case everywhere ("Generate grocery list", not "GENERATE GROCERY LIST").
- Letter spacing stays at default, except Label at 0.2.
- Support system text scaling. Do not lock text sizes.

---

## 4. Layout, Spacing and Shape

### Spacing scale

`4, 8, 12, 16, 24, 32, 48`

- Screen horizontal padding: 16
- Gap between cards: 12
- Gap between sections: 24
- Inside cards: 16

### Corner radius (kept tight and consistent)

| Element | Radius |
| --- | --- |
| Tags, chips, photo tiles, calendar cells | 4 |
| Buttons, inputs | 6 |
| Cards, images, bottom sheets, dialogs | 8 |
| Progress bars | 2 |
| Profile and participant avatars | Circle (only place a circle is used) |

No pill-shaped buttons, no large rounded cards.

### Borders and elevation

- Every card and input has a **1px `border`**.
- **No drop shadows.** Set `elevation: 0` and `surfaceTintColor: Colors.transparent` on all Material widgets (cards, app bar, dialogs, sheets, snackbars, navigation bar).
- Layering is shown with color (`softBone` page, `surface` card) and a border only.
- No blur, no frosted or glass effects, no translucent panels.

### Layout rules

- Single-column, full-width cards in vertical scrolling lists. Use 2-column grids only for small tiles (participants, badges, meals).
- **Never place three feature cards in a row.** No bento-style mixed-size grids.
- Cards never have a colored stripe on one edge. A card is either a solid color fill (module cards) or a `surface` card with a full 1px border.
- No dot grids, radial glows, orbs, or decorative background shapes.
- Use `SafeArea`, `Expanded`, `Flexible`, `ListView` and `GridView`. No fixed screen dimensions.

---

## 5. Icons and Imagery

- **Icons:** Flutter's built-in Material Icons, outlined variants only (for example `Icons.fitness_center_outlined`). Icon sizes are 20 or 24. Do not use Lucide or any third-party icon pack. This is the only icon set in the project, so no extra package is added.
- Icon colors follow text colors (`deepForest`, `textSecondary`, or `softBone` on dark).
- Do not use sparkle, star burst, magic wand or "AI" style icons, and no animated arrows.
- **Photos:** real local images for meals, instructors, doctors, participants and progress photos. Corner radius 8 (tiles 4).
- Text never sits directly on a photo with a gradient overlay. Put text below the image inside the card, or use a flat solid `deepForest` label block.
- Image placeholders use a flat `warmOat` fill with a single outlined icon.
- **No emojis** in the UI, mock data, code or comments.

---

## 6. Components

### Buttons
- **Primary:** fill `teal`, label `deepForest` (Subtitle 16, weight 600), height 48, radius 6, full width on forms and summaries.
- **Secondary:** 1px `deepForest` border, transparent fill, label `deepForest`.
- **Text link:** `deepForest`, underlined.
- **Destructive:** 1px `terracotta` border, label `terracotta`.
- **Disabled:** `warmOat` fill, `textSecondary` label.
- Press feedback is the standard ink ripple in a `warmOat` tone. No hover effects, no scale or bounce animations.

### Cards
- **Standard card:** `surface` fill, 1px `border`, radius 8, padding 16.
- **Module card (Home):** solid accent fill, radius 8, padding 16, title Subtitle, big number Metric, label Label.
- **Dark card:** `charcoalOlive` fill on dark screens, no border needed.

### Stat display
Number in Metric style, unit in Label style directly beside or below it (for example "148" and "BPM"). Icon at top left in 20px outlined style.

### Progress bars
Height 6, radius 2, track `warmOat` (or `deepForest` at 20 percent on colored cards), fill solid accent color. Fill width animates over 250 ms when it changes.

### Tags and chips
Radius 4, Label text, `warmOat` fill with `deepForest` text. Selected chip: `deepForest` fill with `softBone` text. Example: the "Save 40%" tag on the annual plan.

### Lists and tips
- Rows separated by 1px `warmOat` dividers.
- Ingredients, form tips and instructions use **plain text rows or numbers (1, 2, 3)**. Do not use checkmark icons as bullets. Use a small status word when needed (for example "Good", "Adjust").
- Interactive checkboxes (grocery list) are real controls with a square 4-radius box, not decorative bullets.

### Inputs
Label above the field (Label style), 1px `border` outline, radius 6, height 48, focused border `deepForest` 1.5px, error text in `terracotta` below the field with a plain message.

### Dialogs and bottom sheets
`softBone` fill, 1px `border`, radius 8 (top corners only for sheets), small flat drag handle in `warmOat`. The scrim is a flat `deepForest` at 50 percent. No blur behind them.

### Snackbar
`deepForest` fill, `softBone` text, radius 6, short plain message.

### App bar
`softBone` background, flat, left-aligned Subtitle title, `Icons.arrow_back` for back. On dark screens: `deepForest` background and `softBone` title.

### Bottom navigation
Five tabs: Home, Workouts, Nutrition, Progress, Profile. Flat bar with a 1px top `border`, always show labels. Selected item uses `deepForest` icon and label with a `warmOat` indicator of radius 6. Unselected items use `textSecondary`.

### Calendar (Progress)
Monthly grid with Label-size weekday headers. Selected day is a `teal` filled square with radius 4 and `deepForest` text. Days with a logged workout show a small solid `sage` dot beneath the number (a single marker, not a dot-grid pattern).

### Charts
Flat solid bars or simple lines. Bars in `sage`, today or selected bar in `teal`. 1px solid gridlines in `warmOat`, few of them. No gradient fills, no shadows under lines, no glow.

### Badges (Achievements)
Square tile, radius 8, 2-column grid.
- **Unlocked:** solid `sage` fill, `deepForest` icon and title.
- **Locked:** `surface` fill, 1px `border`, `textSecondary` icon and title, with the unlock condition shown as plain text underneath (for example "Complete 10 workouts, 6 done").
- Unlocking shows a simple dialog with the badge and a short message. No confetti and no sparkle effects.

### Skeleton loaders
Mock data is shown after a short simulated load (about 600 ms) on list and dashboard screens so skeleton loaders are visible and meaningful.
- One small reusable widget (`SkeletonBox`) drawing a `warmOat` rectangle with radius 4.
- Animation is a gentle opacity pulse between 100 and 60 percent over 1.2 seconds. No moving gradient shimmer.
- Used on: Home module cards, workout list, meal menu, doctor list, progress charts and photos.
- Skeleton shapes match the real layout (card height, image block, two text lines).

---

## 7. Screen Direction

### 7.1 Live Workout (dark screen)
- Background `deepForest`, participant tiles radius 4 in a 2-column or 3-column grid of small squares, instructor video area large at the top.
- A small "Live" tag in `terracotta` with text label.
- Bottom panel uses `softBone` with a top border and radius 8 at top corners. It contains:
  - Heart rate: Metric "148" with "BPM", the five-segment zone bar, and text "Zone 3 - Cardio".
  - Calories burned: Metric "350" with "kcal".
  - Pause and End workout buttons (secondary and destructive styles).
- Timer and current exercise sit above the grid in Subtitle and Label styles.

### 7.2 Workout Tracking (dark screen)
- Camera placeholder fills the upper area (flat `charcoalOlive` with the sample pose photo).
- Pose overlay: 2px `teal` lines with small `teal` joint dots, drawn with `CustomPainter` or a static image. It is a simulation only.
- Top left status label "Pose detected" (Label on `charcoalOlive`).
- Rep counter at bottom right in Metric style, for example "12 / 15", with the label "Reps".
- Bottom sheet `charcoalOlive` titled "Form correction tips" with plain text rows and a status word on the right ("Good" or "Adjust"). No checkmark icons.

### 7.3 Home Dashboard
- Header: "Cure.fit" wordmark in Title style with "Fitness & Wellness" in Label style, notification icon with a small `orange` dot badge.
- Greeting line and a short date.
- Three module cards **stacked vertically, full width**:
  1. Activity (`teal`): steps and calories as two Metric values.
  2. Nutrition (`terracotta`): "3 / 3 meals logged" with a progress bar.
  3. Wellness (`sage`): two inner tiles for Meditation and Yoga in `softBone` with 1px `border`.
- After the module cards, continue with the sections from the plan (Live Now, Recommended, Meal, Challenge, Achievement preview) as full-width `surface` cards or simple lists. The Live Now card uses `charcoalOlive` with `softBone` text.
- Section headers: Subtitle on the left, an underlined "See all" text link on the right.

### 7.4 Meal Planner
- Large food photo at the top (radius 8) with no overlay.
- Meal name in Title, ingredients as plain divided rows.
- Nutrition info as two boxes side by side (Calories, Protein) on `surface` with 1px `border`. Additional values (carbs, fat) appear as rows beneath.
- Daily total shown as a Metric with a per-meal breakdown list.
- Full-width primary button "Generate grocery list" in `teal`.

### 7.5 Progress Timeline
- Month title with previous and next arrow icons (static, not animated).
- Calendar as described in section 6.
- Weight change shown as a tag, for example "5 kg lost", in `warmOat`.
- Before and after photos side by side with a simple static divider, each with a date stamp in Label style beneath it.
- Weekly charts below in flat `sage` bars.

### 7.6 Other Screens (follow the same system)
- **Yoga session and Meditation player:** dark screens like Live Workout. Yoga shows pose name in Title, hold timer in Metric, alignment status words (Good, Adjust), next pose in Label. Meditation shows title, a thin progress bar, play and pause control, ambient sound as a list of selectable rows, and a volume slider with `teal` active track.
- **Challenges and Leaderboard:** `surface` cards with progress bars. Leaderboard as a plain ranked list with dividers. The "You" row uses a `warmOat` fill.
- **Doctors:** list of `surface` cards with square photo (radius 4), name, specialty, fee. Date and time slots as chips.
- **Meal menu and order:** 2-column grid of meal cards, order summary as a divided list with a total row.
- **Family:** list rows with avatars and plan status tags. Forms follow the input spec.
- **Profile and Settings:** divided list rows. Includes Terms of Service and Privacy Policy (see 9).

### 7.7 Membership Screen (pricing layout)
Avoid a three-tier pricing row. Use this structure instead:
1. **Current plan** banner at the top.
2. **Membership** section: two full-width selectable rows stacked vertically.
   - Monthly pass: "₹999 / month", "Unlimited live classes".
   - Annual membership: "₹6999 / year", "Save 40%" tag.
   The selected row has a 2px `deepForest` border.
3. **Add-ons** section: two separate list rows, not cards in a row.
   - Meal plan: "₹399 / day", "3 healthy meals".
   - Family plan: "Add a member at 50% discount", with the calculated price shown for the selected membership.
4. Short plain comparison table (Monthly versus Annual), then the primary button "Select plan".
5. A small text line under the button linking to Terms of Service and Privacy Policy.

---

## 8. Motion

Motion is used only when it explains a change in state.

| Where | Motion | Duration |
| --- | --- | --- |
| Screen transitions | Flutter default page transition | Default |
| Progress bars | Fill width change | 250 ms |
| Rep counter, timer, BPM | Number updates, no animation | None |
| Skeleton loaders | Opacity pulse | 1.2 s loop |
| Splash | Simple fade in of the wordmark, then navigate | 800 ms |
| Dialogs and sheets | Default | Default |

Not allowed: hover animations, scale or bounce on press, animated arrows, parallax, confetti, sparkle or particle effects, looping decorative animations.

---

## 9. Legal and Trust Content

The app includes static legal screens so it feels like a real product. They are plain text screens with mock copy and no backend.

- **Terms of Service** screen and **Privacy Policy** screen, reachable from Profile, then Settings, then Legal.
- The membership screen and the doctor booking summary show a short line linking to both.
- The doctor consultation flow includes a plain note: "Consultations in this app are for demonstration only and do not replace professional medical advice."
- Each legal screen uses Title, then Subtitle headings and Body paragraphs on `softBone`, in a simple scrollable column.

---

## 10. Copy and Content Rules

- No emojis. No em dashes (use commas, colons, or separate sentences). Ranges are written with "to" (for example "6 to 8 reps").
- Plain, specific labels: "Start exercise", "Join class", "Book consultation", "Confirm order".
- No hype phrases such as "unlock your potential", "supercharge", "level up".
- Mock data uses believable Indian names, realistic calorie and nutrition values, and the rupee symbol with correct numbers (₹999, ₹6999, ₹399).
- Dates are written in full ("15 September 2026").

---

## 11. Flutter Theme Starter

Keep all of this in `lib/theme/app_theme.dart`.

```dart
import 'package:flutter/material.dart';

class AppColors {
  static const deepForest = Color(0xFF161A17);
  static const charcoalOlive = Color(0xFF2C3531);
  static const softBone = Color(0xFFF9F8F6);
  static const warmOat = Color(0xFFE3DAC9);

  static const sage = Color(0xFF7C9082);
  static const teal = Color(0xFF48B1BF);
  static const orange = Color(0xFFD66853);
  static const terracotta = Color(0xFFB56357);

  static const surface = Color(0xFFF1ECE2);
  static const border = Color(0xFFD5CBB8);
  static const textSecondary = Color(0xFF5B6660);
  static const textOnDarkSecondary = Color(0xFFB9C0BB);
  static const ochre = Color(0xFFC9A66B);
}

class AppTheme {
  static const double radiusSmall = 4;
  static const double radiusMedium = 6;
  static const double radiusLarge = 8;

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'WorkSans',
      scaffoldBackgroundColor: AppColors.softBone,
      colorScheme: const ColorScheme.light(
        primary: AppColors.teal,
        onPrimary: AppColors.deepForest,
        surface: AppColors.softBone,
        onSurface: AppColors.deepForest,
        error: AppColors.terracotta,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.softBone,
        foregroundColor: AppColors.deepForest,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: AppColors.deepForest,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.warmOat,
        thickness: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.softBone,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.warmOat,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.deepForest, width: 1.5),
        ),
      ),
    );
  }
}
```

Dark screens (Live Workout, Workout Tracking, Yoga session, Meditation player) wrap their content in a local `Theme` or use `deepForest` and `charcoalOlive` directly. The rest of the app stays on the light theme.

---

## 12. Anti-Template Checklist

Every pattern below is either avoided or handled as described.

| Pattern | Decision in this design |
| --- | --- |
| Harsh gradients | Avoided. All fills are solid. The heart rate bar is five solid segments. |
| Lucide icons | Avoided. Flutter Material Icons (outlined) only. |
| Pure white background | Avoided. `softBone` background, `surface` cards. |
| Rainbow coloring | Avoided. One accent per area. The only multi-color element is the five-zone heart rate bar, which is ordered and labeled. |
| Drop shadows | Avoided. Elevation 0 everywhere, borders instead. |
| Three feature cards in a row | Avoided. Cards are stacked full width. |
| Emojis | Avoided everywhere. |
| Liquid glass and blur | Avoided. |
| Em dashes | Avoided in UI text, mock data, code and this document. |
| Inter, Geist, Space, Grotesk fonts | Avoided. Work Sans is used. |
| Colored left stripe on cards | Avoided. Cards use full borders or solid fills. |
| Bento grids | Avoided. Uniform lists and simple 2-column tile grids only. |
| Terminal window visuals | Not used. |
| Checkmark bullets | Avoided. Plain rows, numbers, and status words. |
| Three pricing tiers | Avoided. Two stacked membership rows plus separate add-on rows. |
| Soft, large corner radius | Avoided. Radius is 4, 6 or 8. |
| Purple and black | Avoided. Palette is olive, bone, oat, sage, teal and terracotta. |
| Missing skeleton loaders | Included. Opacity-pulse skeletons on list and dashboard screens. |
| Radial orbs | Avoided. |
| Dot grids | Avoided. Only a single marker dot under logged calendar days. |
| Sparkle icons | Avoided. |
| Animated arrows | Avoided. Navigation arrows are static. |
| Missing Terms of Service | Included. Static screen under Settings, linked from membership. |
| Missing Privacy Policy | Included. Static screen under Settings, linked from membership. |
| Hover animations on everything | Avoided. Standard press ripple only. |
| Neon and basic pastel colors | Avoided. Muted earthy palette only. |

### Deliberate deviations from the reference image

The reference image was used for palette, type scale, screen structure and content. These items in the image were changed on purpose to meet the rules above:

- The gradient heart rate bar became five solid segments.
- Checkmark icons in the form correction tips became plain rows with status words.
- Large rounded card corners became radius 8 or smaller.
- Soft shadows on cards and phone frames were removed in favor of 1px borders.
- The image's sans-serif appearance was replaced with Work Sans.

### Allowed exceptions

- Flutter's built-in Material Icons are used because they ship with Flutter and avoid extra dependencies.
- The heart rate zone bar uses five colors because it encodes ordered data, and each segment is also labeled in text.
- Home uses three differently colored module cards, stacked vertically, to match the reference image.
