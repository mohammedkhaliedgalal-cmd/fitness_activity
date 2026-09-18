import 'package:flutter/material.dart';
import 'workout_details_screen.dart';

class LibraryPlayScreen extends StatefulWidget {
  const LibraryPlayScreen({super.key});

  @override
  State<LibraryPlayScreen> createState() => _LibraryPlayScreenState();
}

class _LibraryPlayScreenState extends State<LibraryPlayScreen> {
  bool isPlaying = false;

  void openWorkoutDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Library Play',
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
          children: [
            const SizedBox(height: 10),

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Library-Play.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.play_circle_outline,
                        size: 55,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Workout Library',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose a workout and start training whenever you are ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            _workoutItem(
              title: 'Full Body Workout',
              duration: '30 min',
              level: 'Beginner',
              icon: Icons.fitness_center,
            ),

            const SizedBox(height: 12),

            _workoutItem(
              title: 'Cardio Training',
              duration: '25 min',
              level: 'Intermediate',
              icon: Icons.directions_run,
            ),

            const SizedBox(height: 12),

            _workoutItem(
              title: 'Strength Workout',
              duration: '40 min',
              level: 'Advanced',
              icon: Icons.sports_gymnastics,
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    size: 50,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isPlaying ? 'Workout is playing' : 'Ready to play',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      label: Text(
                        isPlaying ? 'PAUSE' : 'PLAY WORKOUT',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _workoutItem({
    required String title,
    required String duration,
    required String level,
    required IconData icon,
  }) {
    return InkWell(
      onTap: openWorkoutDetails,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 26,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '$duration • $level',
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
              size: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}