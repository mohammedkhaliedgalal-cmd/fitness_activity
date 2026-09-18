import 'package:flutter/material.dart';

class Workout {
  final String title;
  final String subtitle;
  final String duration;

  const Workout({
    required this.title,
    required this.subtitle,
    required this.duration,
  });
}

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  static const List<Workout> workouts = [
    Workout(
      title: 'Morning Workout',
      subtitle: 'Start your day with energy',
      duration: '20 min',
    ),
    Workout(
      title: 'Cardio Blast',
      subtitle: 'Improve your endurance',
      duration: '30 min',
    ),
    Workout(
      title: 'Strength Training',
      subtitle: 'Build strength and power',
      duration: '35 min',
    ),
    Workout(
      title: 'Evening Stretch',
      subtitle: 'Relax and recover',
      duration: '15 min',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Workouts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _HeaderSection();
          }

          final workout = workouts[index - 1];

          return _WorkoutTile(
            workout: workout,
          );
        },
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/Scroll.jpg',
              width: 220,
              height: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 220,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 26),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recommended Workouts',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _WorkoutTile extends StatelessWidget {
  final Workout workout;

  const _WorkoutTile({
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFFF0F2F5),
            ),
            child: const Icon(
              Icons.fitness_center,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
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
          Column(
            children: [
              Text(
                workout.duration,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 6),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}