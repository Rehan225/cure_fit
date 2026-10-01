class YogaPose {
  final String name;
  final int durationSeconds;
  final String instructions;
  final String
  alignmentStatus; // e.g. "Back: Good, Leg: Good, Shoulders: Adjust"
  final String tip;

  const YogaPose({
    required this.name,
    required this.durationSeconds,
    required this.instructions,
    required this.alignmentStatus,
    required this.tip,
  });
}

class YogaSession {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final int durationMinutes;
  final String instructor;
  final List<YogaPose> poses;

  const YogaSession({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.instructor,
    required this.poses,
  });
}
