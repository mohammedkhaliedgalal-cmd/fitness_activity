import 'package:flutter/material.dart';

class Exercise {
  final String title;
  final String duration;
  final String calories;

  const Exercise({
    required this.title,
    required this.duration,
    required this.calories,
  });
}

class Scroll1Screen extends StatelessWidget {
  const Scroll1Screen({super.key});

  final List<Exercise> exercises = const [
    Exercise(
      title: 'Jumping Jacks',
      duration: '30 sec',
      calories: '8 kcal',
    ),
    Exercise(
      title: 'Bodyweight Squats',
      duration: '45 sec',
      calories: '10 kcal',
    ),
    Exercise(
      title: 'Push Ups',
      duration: '40 sec',
      calories: '9 kcal',
    ),
    Exercise(
      title: 'Mountain Climbers',
      duration: '30 sec',
      calories: '12 kcal',
    ),
    Exercise(
      title: 'Plank',
      duration: '60 sec',
      calories: '7 kcal',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Exercise List',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeaderImage();
          }

          if (index == 1) {
            return const Padding(
              padding: EdgeInsets.only(
                top: 26,
                bottom: 16,
              ),
              child: Text(
                'Today’s Exercises',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (index == exercises.length + 2) {
            return _buildStartButton();
          }

          final exerciseIndex = index - 2;
          final exercise = exercises[exerciseIndex];

          return _ExerciseCard(
            index: exerciseIndex + 1,
            exercise: exercise,
          );
        },
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: Container(
        width: 220,
        height: 130,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/Scroll-1.jpg',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.fitness_center,
                  size: 45,
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 10,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'START EXERCISES',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final int index;
  final Exercise exercise;

  const _ExerciseCard({
    required this.index,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFF0F1F3),
            foregroundColor: Colors.black,
            child: Text(
              '$index',
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Text(
            exercise.calories,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}