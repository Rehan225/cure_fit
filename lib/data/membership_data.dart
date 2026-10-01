import '../models/membership_plan.dart';

const MembershipPlan monthlyPlan = MembershipPlan(
  type: MembershipType.monthly,
  name: 'Monthly Pass',
  price: 999,
  billingPeriod: 'month',
  description: 'Unlimited live classes and on-demand workout library.',
);

const MembershipPlan annualPlan = MembershipPlan(
  type: MembershipType.annual,
  name: 'Annual Membership',
  price: 6999,
  billingPeriod: 'year',
  description: 'Full 12-month unlimited access with priority live spots.',
  discountTag: 'Save 40%',
);

const int mealPlanPricePerDay = 399;
const String mealPlanDescription =
    '3 healthy meals cooked fresh and delivered daily.';

// Helper function to calculate family discount based on membership type
double getFamilyMemberPrice(MembershipType type) {
  if (type == MembershipType.monthly) {
    return 499.50;
  } else {
    return 3499.50;
  }
}
