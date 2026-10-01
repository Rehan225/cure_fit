import '../models/progress_photo.dart';

class WeeklyDataPoint {
  final String dayLabel;
  final double value;
  final bool isToday;

  const WeeklyDataPoint({
    required this.dayLabel,
    required this.value,
    this.isToday = false,
  });
}

final List<WeeklyDataPoint> mockWeeklyCalories = [
  const WeeklyDataPoint(dayLabel: 'Mon', value: 420),
  const WeeklyDataPoint(dayLabel: 'Tue', value: 380),
  const WeeklyDataPoint(dayLabel: 'Wed', value: 510),
  const WeeklyDataPoint(dayLabel: 'Thu', value: 290),
  const WeeklyDataPoint(dayLabel: 'Fri', value: 460),
  const WeeklyDataPoint(dayLabel: 'Sat', value: 620),
  const WeeklyDataPoint(dayLabel: 'Sun', value: 350, isToday: true),
];

final List<WeeklyDataPoint> mockWeeklyDurationMinutes = [
  const WeeklyDataPoint(dayLabel: 'Mon', value: 45),
  const WeeklyDataPoint(dayLabel: 'Tue', value: 35),
  const WeeklyDataPoint(dayLabel: 'Wed', value: 50),
  const WeeklyDataPoint(dayLabel: 'Thu', value: 30),
  const WeeklyDataPoint(dayLabel: 'Fri', value: 45),
  const WeeklyDataPoint(dayLabel: 'Sat', value: 60),
  const WeeklyDataPoint(dayLabel: 'Sun', value: 40, isToday: true),
];

// Zone distribution percentage
final Map<String, int> mockZoneDistribution = {
  'Zone 1 (Recovery)': 15,
  'Zone 2 (Fat Burn)': 30,
  'Zone 3 (Cardio)': 35,
  'Zone 4 (Peak)': 15,
  'Zone 5 (Maximum)': 5,
};

// Logged workout days in current month (1 to 31)
final Set<int> mockLoggedWorkoutDays = {
  2,
  4,
  5,
  7,
  9,
  11,
  12,
  14,
  16,
  18,
  19,
  21,
  23,
  25,
  26,
  28,
  30,
};

final List<ProgressPhoto> mockProgressPhotos = [
  const ProgressPhoto(
    id: 'ph_1',
    title: 'Baseline Assessment',
    dateStamp: '01 June 2026',
    weightKg: 81.5,
    note: 'Initial posture and body composition photo taken before starting routine.',
    imagePath: 'assets/images/photo_before.png',
    isBefore: true,
  ),
  const ProgressPhoto(
    id: 'ph_2',
    title: 'Month 1 Checkpoint',
    dateStamp: '01 July 2026',
    weightKg: 79.2,
    note: 'Noticeable endurance improvement during morning cardio sessions.',
    imagePath: 'assets/images/photo_month1.png',
  ),
  const ProgressPhoto(
    id: 'ph_3',
    title: 'Month 2 Checkpoint',
    dateStamp: '01 August 2026',
    weightKg: 77.8,
    note: 'Increased core stability and cleaner squat depth.',
    imagePath: 'assets/images/photo_month2.png',
  ),
  const ProgressPhoto(
    id: 'ph_4',
    title: 'Current Status',
    dateStamp: '15 September 2026',
    weightKg: 76.5,
    note: 'Total 5 kg reduction in body weight with increased lean muscle definition.',
    imagePath: 'assets/images/photo_after.png',
    isAfter: true,
  ),
];
