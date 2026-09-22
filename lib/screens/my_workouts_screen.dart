import 'package:flutter/material.dart';

import 'workout_session_screen.dart';

// ==========================================
// WORKOUT MODEL
// ==========================================

class WorkoutModel {
  final String title;
  final String subtitle;
  final String duration;
  final String calories;
  final IconData icon;

  const WorkoutModel({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.calories,
    required this.icon,
  });
}

// ==========================================
// MY WORKOUTS SCREEN
// ==========================================

class MyWorkoutsScreen extends StatelessWidget {
  const MyWorkoutsScreen({super.key});

  static const List<WorkoutModel> workouts = [
    WorkoutModel(
      title: 'Full Body Workout',
      subtitle: '45 min • 320 kcal',
      duration: '45 Minutes',
      calories: '320 kcal',
      icon: Icons.fitness_center,
    ),
    WorkoutModel(
      title: 'Cardio Workout',
      subtitle: '30 min • 250 kcal',
      duration: '30 Minutes',
      calories: '250 kcal',
      icon: Icons.directions_run,
    ),
    WorkoutModel(
      title: 'Strength Training',
      subtitle: '40 min • 300 kcal',
      duration: '40 Minutes',
      calories: '300 kcal',
      icon: Icons.sports_gymnastics,
    ),
    WorkoutModel(
      title: 'Morning Workout',
      subtitle: '25 min • 180 kcal',
      duration: '25 Minutes',
      calories: '180 kcal',
      icon: Icons.wb_sunny_outlined,
    ),
  ];

  void _openWorkout(
    BuildContext context,
    WorkoutModel workout,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutInfoScreen(
          workout: workout,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'My Workouts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // WORKOUT IMAGE
            // ==========================================

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/My workouts.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'My Workouts',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Manage your workouts and keep track of your progress.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // WORKOUT LIST
            // ==========================================

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: workouts.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final workout = workouts[index];

                return _workoutCard(
                  context: context,
                  workout: workout,
                );
              },
            ),

            const SizedBox(height: 25),

            // ==========================================
            // BACK BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'BACK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _workoutCard({
    required BuildContext context,
    required WorkoutModel workout,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          _openWorkout(context, workout);
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // ==========================================
              // WORKOUT ICON
              // ==========================================

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  workout.icon,
                  size: 27,
                  color: Colors.black,
                ),
              ),

              const SizedBox(width: 15),

              // ==========================================
              // WORKOUT INFORMATION
              // ==========================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      workout.subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// WORKOUT INFO SCREEN
// ==========================================

class WorkoutInfoScreen extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutInfoScreen({
    super.key,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFullBody =
        workout.title == 'Full Body Workout';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: Text(
          workout.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // ==========================================
            // WORKOUT ICON
            // ==========================================

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                workout.icon,
                size: 55,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              workout.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ==========================================
            // DURATION & CALORIES
            // ==========================================

            Row(
              children: [
                Expanded(
                  child: _detailCard(
                    Icons.timer_outlined,
                    'Duration',
                    workout.duration,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _detailCard(
                    Icons.local_fire_department_outlined,
                    'Calories',
                    workout.calories,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              isFullBody
                  ? 'Complete your full body workout and stay consistent with your fitness goals.'
                  : 'Stay active and keep working toward your fitness goals.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 35),

            // ==========================================
            // START WORKOUT
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const WorkoutSessionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'START WORKOUT',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ==========================================
            // BACK BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'BACK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // DETAIL CARD
  // ==========================================

  Widget _detailCard(
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}