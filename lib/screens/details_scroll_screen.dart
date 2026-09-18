import 'package:flutter/material.dart';

// ==========================================
// 1. MODELS
// ==========================================

class Exercise {
  final String number;
  final String title;
  final String duration;

  const Exercise({
    required this.number,
    required this.title,
    required this.duration,
  });
}

class WorkoutDetail {
  final String title;
  final String description;
  final String imagePath;
  final String duration;
  final String calories;
  final List<Exercise> exercises;

  const WorkoutDetail({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.duration,
    required this.calories,
    required this.exercises,
  });
}

// ==========================================
// 2. MAIN SCREEN
// ==========================================

class DetailsScrollScreen extends StatelessWidget {
  const DetailsScrollScreen({super.key});

  static const workout = WorkoutDetail(
    title: 'Full Body Workout',
    description:
        'A complete workout designed to improve your strength, endurance, and overall fitness.',
    imagePath: 'assets/images/Details - Scroll.jpg',
    duration: '30 min',
    calories: '240 kcal',
    exercises: [
      Exercise(
        number: '01',
        title: 'Warm Up',
        duration: '5 min',
      ),
      Exercise(
        number: '02',
        title: 'Squats',
        duration: '10 min',
      ),
      Exercise(
        number: '03',
        title: 'Push Ups',
        duration: '5 min',
      ),
      Exercise(
        number: '04',
        title: 'Lunges',
        duration: '5 min',
      ),
      Exercise(
        number: '05',
        title: 'Cool Down',
        duration: '5 min',
      ),
    ],
  );

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
          'Workout Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WorkoutHeaderImage(
              imagePath: workout.imagePath,
            ),

            const SizedBox(height: 26),

            WorkoutTitleSection(
              title: workout.title,
              description: workout.description,
            ),

            const SizedBox(height: 24),

            WorkoutInfoCardRow(
              duration: workout.duration,
              calories: workout.calories,
            ),

            const SizedBox(height: 24),

            WorkoutExerciseList(
              exercises: workout.exercises,
            ),

            const SizedBox(height: 18),

            StartWorkoutButton(
              onPressed: () {},
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. HEADER IMAGE
// ==========================================

class WorkoutHeaderImage extends StatelessWidget {
  final String imagePath;

  const WorkoutHeaderImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          width: 220,
          height: 130,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 220,
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16),
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
    );
  }
}

// ==========================================
// 4. TITLE SECTION
// ==========================================

class WorkoutTitleSection extends StatelessWidget {
  final String title;
  final String description;

  const WorkoutTitleSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. INFO CARDS
// ==========================================

class WorkoutInfoCardRow extends StatelessWidget {
  final String duration;
  final String calories;

  const WorkoutInfoCardRow({
    super.key,
    required this.duration,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoCard(
          icon: Icons.timer_outlined,
          title: duration,
        ),

        const SizedBox(width: 12),

        InfoCard(
          icon: Icons.local_fire_department_outlined,
          title: calories,
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.black87,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 6. EXERCISES
// ==========================================

class WorkoutExerciseList extends StatelessWidget {
  final List<Exercise> exercises;

  const WorkoutExerciseList({
    super.key,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Workout Exercises',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        ...exercises.map(
          (exercise) => ExerciseTile(
            exercise: exercise,
          ),
        ),
      ],
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;

  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFFE9EDF2),
            child: Text(
              exercise.number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              exercise.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Text(
            exercise.duration,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. START WORKOUT BUTTON
// ==========================================

class StartWorkoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartWorkoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'START WORKOUT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}