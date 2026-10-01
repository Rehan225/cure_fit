import '../models/yoga_session.dart';

final List<YogaSession> mockYogaSessions = [
  YogaSession(
    id: 'y1',
    title: 'Morning Sun Salutation',
    category: 'Morning Yoga',
    difficulty: 'Beginner',
    durationMinutes: 20,
    instructor: 'Sunita Krishnan',
    poses: [
      YogaPose(
        name: 'Mountain Pose (Tadasana)',
        durationSeconds: 30,
        instructions: 'Stand tall with feet together, shoulders relaxed, weight evenly distributed.',
        alignmentStatus: 'Posture: Good, Spine: Straight',
        tip: 'Ground through all four corners of your feet.',
      ),
      YogaPose(
        name: 'Upward Salute (Urdhva Hastasana)',
        durationSeconds: 30,
        instructions:
            'Inhale and sweep arms out to the sides and up toward the sky.',
        alignmentStatus: 'Arms: Good, Shoulders: Relax',
        tip: 'Keep your gaze soft toward your thumbs.',
      ),
      YogaPose(
        name: 'Standing Forward Bend (Uttanasana)',
        durationSeconds: 45,
        instructions:
            'Exhale and hinge forward from the hip joints, not the waist.',
        alignmentStatus: 'Hips: Good, Knees: Soft bend',
        tip: 'Bend knees slightly to protect your lower back.',
      ),
      YogaPose(
        name: 'Downward Facing Dog (Adho Mukha Svanasana)',
        durationSeconds: 60,
        instructions: 'Press hands firmly into the ground, lift sitting bones toward the ceiling.',
        alignmentStatus: 'Back: Good, Heels: Lower slightly',
        tip: 'Lengthen your spine before straightening legs.',
      ),
    ],
  ),
  YogaSession(
    id: 'y2',
    title: 'Deep Hip and Hamstring Flexibility',
    category: 'Flexibility',
    difficulty: 'Intermediate',
    durationMinutes: 30,
    instructor: 'Deepak Varma',
    poses: [
      YogaPose(
        name: 'Low Lunge (Anjaneyasana)',
        durationSeconds: 45,
        instructions: 'Step one foot forward between your hands and lower back knee to the mat.',
        alignmentStatus: 'Front Knee: Good, Hips: Square',
        tip: 'Avoid leaning past your front ankle.',
      ),
      YogaPose(
        name: 'Pigeon Pose (Eka Pada Rajakapotasana)',
        durationSeconds: 60,
        instructions: 'Bring your right knee behind right wrist, slide left leg straight back.',
        alignmentStatus: 'Pelvis: Centered, Shoulders: Relaxed',
        tip: 'Place a blanket under hip if tilted.',
      ),
      YogaPose(
        name: 'Seated Forward Fold (Paschimottanasana)',
        durationSeconds: 60,
        instructions:
            'Sit tall, extend legs in front, hinge forward from the hips.',
        alignmentStatus: 'Back: Straight, Neck: Neutral',
        tip: 'Lead with the chest rather than the head.',
      ),
    ],
  ),
  YogaSession(
    id: 'y3',
    title: 'Spine and Back Care Flow',
    category: 'Back Care',
    difficulty: 'Beginner',
    durationMinutes: 25,
    instructor: 'Sunita Krishnan',
    poses: [
      YogaPose(
        name: 'Cat and Cow Stretch (Marjaryasana-Bitilasana)',
        durationSeconds: 60,
        instructions:
            'On hands and knees, arch spine on inhale and round on exhale.',
        alignmentStatus: 'Wrists: Under shoulders, Movement: Smooth',
        tip: 'Synchronize movement with your breath.',
      ),
      YogaPose(
        name: 'Bridge Pose (Setu Bandhasana)',
        durationSeconds: 45,
        instructions:
            'Lie on back with knees bent, feet flat, lift hips toward ceiling.',
        alignmentStatus: 'Knees: Parallel, Glutes: Engaged',
        tip: 'Keep thighs parallel to each other.',
      ),
      YogaPose(
        name: 'Child Pose (Balasana)',
        durationSeconds: 60,
        instructions: 'Kneel on the floor, touch big toes together, sit on heels, fold forward.',
        alignmentStatus: 'Breath: Deep, Back: Lengthened',
        tip: 'Allow torso to rest gently between thighs.',
      ),
    ],
  ),
  YogaSession(
    id: 'y4',
    title: 'Warrior Core and Balance',
    category: 'Strength',
    difficulty: 'Advanced',
    durationMinutes: 35,
    instructor: 'Aman Singhal',
    poses: [
      YogaPose(
        name: 'Warrior II (Virabhadrasana II)',
        durationSeconds: 45,
        instructions: 'Step feet wide, turn front foot forward, bend front knee, extend arms.',
        alignmentStatus: 'Front Knee: Over ankle, Torso: Upright',
        tip: 'Press firmly into the outer edge of back foot.',
      ),
      YogaPose(
        name: 'Warrior III (Virabhadrasana III)',
        durationSeconds: 30,
        instructions: 'Balance on one leg, hinge forward with torso and lift back leg parallel.',
        alignmentStatus: 'Hips: Level, Core: Tight',
        tip: 'Fix gaze on one stationary point on the floor.',
      ),
    ],
  ),
  YogaSession(
    id: 'y5',
    title: 'Evening Stress Relief',
    category: 'Stress Relief',
    difficulty: 'Beginner',
    durationMinutes: 20,
    instructor: 'Deepak Varma',
    poses: [
      YogaPose(
        name: 'Legs Up the Wall (Viparita Karani)',
        durationSeconds: 90,
        instructions:
            'Lie on back and rest legs extended vertically against a wall.',
        alignmentStatus: 'Back: Fully relaxed, Shoulders: Soft',
        tip: 'Place arms comfortably at your sides.',
      ),
      YogaPose(
        name: 'Corpse Pose (Savasana)',
        durationSeconds: 120,
        instructions:
            'Lie flat on your back, arms at sides, palms facing upward.',
        alignmentStatus: 'Mind: Still, Breath: Natural',
        tip: 'Release all conscious muscular effort.',
      ),
    ],
  ),
];
