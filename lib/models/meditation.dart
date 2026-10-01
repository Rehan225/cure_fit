class MeditationSession {
  final String id;
  final String title;
  final int durationMinutes;
  final String description;
  final String category;
  final String imagePath;

  const MeditationSession({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.description,
    required this.category,
    required this.imagePath,
  });
}
