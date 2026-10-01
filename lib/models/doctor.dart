class Doctor {
  final String id;
  final String name;
  final String specialty;
  final int experienceYears;
  final double rating;
  final int fee; // in rupees
  final String description;
  final String imagePath;
  final List<String> availableDates;
  final List<String> availableSlots;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experienceYears,
    required this.rating,
    required this.fee,
    required this.description,
    required this.imagePath,
    required this.availableDates,
    required this.availableSlots,
  });
}
