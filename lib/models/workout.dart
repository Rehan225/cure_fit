class Workout {
  final String id;
  final String title;
  final String instructor;
  final int duration; // in minutes
  final int calories;
  final String difficulty;
  final int participantCount;
  final String scheduledTime;
  final bool isLiveNow;
  final String imagePath;
  final List<String> exercises;

  const Workout({
    required this.id,
    required this.title,
    required this.instructor,
    required this.duration,
    required this.calories,
    required this.difficulty,
    required this.participantCount,
    required this.scheduledTime,
    this.isLiveNow = false,
    required this.imagePath,
    required this.exercises,
  });
}
