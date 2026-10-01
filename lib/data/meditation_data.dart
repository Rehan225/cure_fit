import '../models/meditation.dart';

final List<MeditationSession> mockMeditationSessions = [
  MeditationSession(
    id: 'm1',
    title: 'Mindful Morning Breathing',
    durationMinutes: 10,
    description: 'Start your morning with centered awareness and diaphragmatic breath work.',
    category: 'Breathing',
    imagePath: 'assets/images/meditation_breathing.png',
  ),
  MeditationSession(
    id: 'm2',
    title: 'Deep Restful Sleep',
    durationMinutes: 20,
    description: 'Progressive muscle relaxation designed to quiet the mind before bedtime.',
    category: 'Sleep',
    imagePath: 'assets/images/meditation_sleep.png',
  ),
  MeditationSession(
    id: 'm3',
    title: 'Workday Stress Release',
    durationMinutes: 12,
    description:
        'Release shoulder and mental tension with guided gentle body scans.',
    category: 'Stress Relief',
    imagePath: 'assets/images/meditation_stress.png',
  ),
  MeditationSession(
    id: 'm4',
    title: 'Deep Work Focus Flow',
    durationMinutes: 15,
    description: 'Sharpen cognitive clarity and dissolve distractions with single-point awareness.',
    category: 'Focus',
    imagePath: 'assets/images/meditation_focus.png',
  ),
  MeditationSession(
    id: 'm5',
    title: 'Self-Compassion and Calm',
    durationMinutes: 14,
    description: 'Cultivate inner resilience and calm through guided contemplative pauses.',
    category: 'Guided',
    imagePath: 'assets/images/meditation_guided.png',
  ),
];

final List<String> mockAmbientSounds = [
  'Rain',
  'Forest',
  'Ocean',
  'Gentle Wind',
  'Silence',
];
