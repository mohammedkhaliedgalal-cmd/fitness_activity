import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutSessionScreen extends StatefulWidget {
  const WorkoutSessionScreen({super.key});

  @override
  State<WorkoutSessionScreen> createState() =>
      _WorkoutSessionScreenState();
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
    seconds = exercises[0]['duration'] as int;
  }

  // ==========================================
  // START TIMER
  // ==========================================

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

  // ==========================================
  // PAUSE TIMER
  // ==========================================

  void pauseTimer() {
    _timer?.cancel();

    if (!mounted) return;

    setState(() {
      isRunning = false;
    });
  }

  // ==========================================
  // NEXT EXERCISE
  // ==========================================

  void nextExercise() {
    _timer?.cancel();

    if (currentExercise < exercises.length - 1) {
      setState(() {
        currentExercise++;
        seconds = exercises[currentExercise]['duration'] as int;
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

  // ==========================================
  // FINISH WORKOUT
  // ==========================================

  void finishWorkout() {
    _timer?.cancel();

    setState(() {
      isRunning = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Workout Completed 🎉',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          content: const Text(
            'Great job! You completed your workout.',
            softWrap: true,
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================
  // RESET WORKOUT
  // ==========================================

  void resetWorkout() {
    _timer?.cancel();

    setState(() {
      currentExercise = 0;
      seconds = exercises[0]['duration'] as int;
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

  // ==========================================
  // FORMAT TIME
  // ==========================================

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

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    final exercise = exercises[currentExercise];

    final progress =
        (currentExercise + 1) / exercises.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      // ==========================================
      // APP BAR
      // ==========================================

      appBar: AppBar(
        title: const Text(
          'Workout Session',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      // ==========================================
      // BODY
      // ==========================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ==========================================
            // EXERCISE PROGRESS
            // ==========================================

            Text(
              'Exercise ${currentExercise + 1} of ${exercises.length}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // EXERCISE IMAGE
            // ==========================================

            Center(
              child: Container(
                width: 220,
                height: 130,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    exercise['image'] as String,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.fitness_center,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // EXERCISE NAME
            // ==========================================

            Text(
              exercise['name'] as String,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // TIMER
            // ==========================================

            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formatTime(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================
            // STATUS
            // ==========================================

            Text(
              isRunning
                  ? 'Exercise in progress...'
                  : 'Ready to start?',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // START / PAUSE BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: isRunning
                    ? pauseTimer
                    : startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: Icon(
                  isRunning
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                label: Text(
                  isRunning
                      ? 'PAUSE'
                      : 'START EXERCISE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ==========================================
            // NEXT / FINISH BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: nextExercise,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: Icon(
                  currentExercise == exercises.length - 1
                      ? Icons.check
                      : Icons.skip_next,
                ),
                label: Text(
                  currentExercise == exercises.length - 1
                      ? 'FINISH WORKOUT'
                      : 'NEXT EXERCISE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ==========================================
            // RESET BUTTON
            // ==========================================

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: resetWorkout,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'RESET',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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