import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutSessionScreen extends StatefulWidget {
  const WorkoutSessionScreen({super.key});

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  Timer? _timer;

  final List<Map<String, dynamic>> exercises = const [
    {
      'name': 'Warm Up',
      'duration': 60,
      'image': 'assets/images/Start Workout.jpg',
    },
    {
      'name': 'Squats',
      'duration': 30,
      'image': 'assets/images/Start Workout.jpg',
    },
    {
      'name': 'Push Ups',
      'duration': 30,
      'image': 'assets/images/Start Workout.jpg',
    },
    {
      'name': 'Lunges',
      'duration': 30,
      'image': 'assets/images/Start Workout.jpg',
    },
    {
      'name': 'Plank',
      'duration': 30,
      'image': 'assets/images/Start Workout.jpg',
    },
  ];

  int currentExercise = 0;
  int seconds = 60;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    seconds = exercises[0]['duration'];
  }

  void startTimer() {
    if (isRunning) return;

    setState(() {
      isRunning = true;
    });

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          nextExercise();
        }
      },
    );
  }

  void pauseTimer() {
    _timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void nextExercise() {
    _timer?.cancel();

    if (currentExercise < exercises.length - 1) {
      setState(() {
        currentExercise++;
        seconds = exercises[currentExercise]['duration'];
        isRunning = false;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Next exercise: ${exercises[currentExercise]['name']}',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      finishWorkout();
    }
  }

  void finishWorkout() {
    _timer?.cancel();

    setState(() {
      isRunning = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Workout Completed 🎉'),
        content: const Text(
          'Great job! You completed your workout.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);

              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'DONE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetWorkout() {
    _timer?.cancel();

    setState(() {
      currentExercise = 0;
      seconds = exercises[0]['duration'];
      isRunning = false;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Workout reset successfully.'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String formatTime() {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[currentExercise];
    final progress = (currentExercise + 1) / exercises.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Workout Session',
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
            Text(
              'Exercise ${currentExercise + 1} of ${exercises.length}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  exercise['image'],
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      color: Colors.grey.shade200,
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
            const SizedBox(height: 20),
            Text(
              exercise['name'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  formatTime(),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isRunning
                  ? 'Exercise in progress...'
                  : 'Ready to start?',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: isRunning ? pauseTimer : startTimer,
                icon: Icon(
                  isRunning ? Icons.pause : Icons.play_arrow,
                ),
                label: Text(
                  isRunning ? 'PAUSE' : 'START EXERCISE',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: nextExercise,
                icon: Icon(
                  currentExercise == exercises.length - 1
                      ? Icons.check
                      : Icons.skip_next,
                ),
                label: Text(
                  currentExercise == exercises.length - 1
                      ? 'FINISH WORKOUT'
                      : 'NEXT EXERCISE',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: resetWorkout,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'RESET',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}