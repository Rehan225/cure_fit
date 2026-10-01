enum MembershipType { monthly, annual }

class MembershipPlan {
  final MembershipType type;
  final String name;
  final int price; // in rupees
  final String billingPeriod;
  final String description;
  final String? discountTag;

  const MembershipPlan({
    required this.type,
    required this.name,
    required this.price,
    required this.billingPeriod,
    required this.description,
    this.discountTag,
  });
}
