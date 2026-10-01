class Achievement {
  final String id;
  final String title;
  final String description;
  final String unlockCondition;
  final bool isUnlocked;
  final int currentProgress;
  final int targetProgress;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.unlockCondition,
    required this.isUnlocked,
    required this.currentProgress,
    required this.targetProgress,
  });

  Achievement copyWith({
    bool? isUnlocked,
    int? currentProgress,
    int? targetProgress,
  }) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      unlockCondition: unlockCondition,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
    );
  }
}
