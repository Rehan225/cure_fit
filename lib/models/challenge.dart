class Challenge {
  final String id;
  final String title;
  final String description;
  final String goal;
  final int durationDays;
  final int participantCount;
  final double progress; // 0.0 to 1.0
  final int percentage; // 0 to 100
  final bool isJoined;
  final bool isCompleted;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.durationDays,
    required this.participantCount,
    required this.progress,
    required this.percentage,
    this.isJoined = false,
    this.isCompleted = false,
  });

  Challenge copyWith({
    bool? isJoined,
    double? progress,
    int? percentage,
    bool? isCompleted,
  }) {
    return Challenge(
      id: id,
      title: title,
      description: description,
      goal: goal,
      durationDays: durationDays,
      participantCount: participantCount,
      progress: progress ?? this.progress,
      percentage: percentage ?? this.percentage,
      isJoined: isJoined ?? this.isJoined,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
