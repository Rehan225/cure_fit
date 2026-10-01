class ProgressPhoto {
  final String id;
  final String title;
  final String dateStamp;
  final double weightKg;
  final String note;
  final String imagePath;
  final bool isBefore;
  final bool isAfter;

  const ProgressPhoto({
    required this.id,
    required this.title,
    required this.dateStamp,
    required this.weightKg,
    required this.note,
    required this.imagePath,
    this.isBefore = false,
    this.isAfter = false,
  });
}
