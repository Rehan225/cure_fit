import '../models/challenge.dart';

final List<Challenge> mockChallenges = [
  const Challenge(
    id: 'c1',
    title: '30-Day Consistency Streak',
    description: 'Complete at least 20 minutes of daily activity for 30 consecutive days.',
    goal: '30 Active Days',
    durationDays: 30,
    participantCount: 1420,
    progress: 0.65,
    percentage: 65,
    isJoined: true,
    isCompleted: false,
  ),
  const Challenge(
    id: 'c2',
    title: '10,000 Calorie Burn',
    description: 'Burn a combined 10,000 calories through strength, cardio, and yoga sessions.',
    goal: '10,000 kcal',
    durationDays: 21,
    participantCount: 980,
    progress: 0.42,
    percentage: 42,
    isJoined: true,
    isCompleted: false,
  ),
  const Challenge(
    id: 'c3',
    title: 'Morning Yoga Reset',
    description: 'Practice morning yoga at least 15 days in a month to improve flexibility.',
    goal: '15 Sessions',
    durationDays: 30,
    participantCount: 650,
    progress: 0.80,
    percentage: 80,
    isJoined: false,
    isCompleted: false,
  ),
  const Challenge(
    id: 'c4',
    title: 'HIIT Power Week',
    description:
        'Complete 5 high-intensity interval training workouts in 7 days.',
    goal: '5 HIIT Sessions',
    durationDays: 7,
    participantCount: 1120,
    progress: 1.0,
    percentage: 100,
    isJoined: true,
    isCompleted: true,
  ),
];

class LeaderboardUser {
  final int rank;
  final String name;
  final int points;
  final bool isCurrentUser;

  const LeaderboardUser({
    required this.rank,
    required this.name,
    required this.points,
    this.isCurrentUser = false,
  });
}

final List<LeaderboardUser> mockLeaderboard = [
  const LeaderboardUser(rank: 1, name: 'Sunil Verma', points: 3450),
  const LeaderboardUser(rank: 2, name: 'Pooja Iyer', points: 3120),
  const LeaderboardUser(rank: 3, name: 'Rohan Sharma', points: 2890),
  const LeaderboardUser(
    rank: 4,
    name: 'You (Rehan)',
    points: 2740,
    isCurrentUser: true,
  ),
  const LeaderboardUser(rank: 5, name: 'Divya Reddy', points: 2610),
  const LeaderboardUser(rank: 6, name: 'Amitabh Sen', points: 2430),
  const LeaderboardUser(rank: 7, name: 'Tanvi Joshi', points: 2280),
  const LeaderboardUser(rank: 8, name: 'Kunal Kapoor', points: 2150),
];
