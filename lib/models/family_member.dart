class FamilyMember {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String fitnessGoal;
  final String membershipStatus;

  const FamilyMember({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.fitnessGoal,
    required this.membershipStatus,
  });

  FamilyMember copyWith({
    String? name,
    int? age,
    String? gender,
    String? fitnessGoal,
    String? membershipStatus,
  }) {
    return FamilyMember(
      id: id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      membershipStatus: membershipStatus ?? this.membershipStatus,
    );
  }
}
