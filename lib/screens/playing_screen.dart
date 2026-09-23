import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  bool isPlaying = true;
  double progress = 0.35;

  final int totalSeconds = 35 * 60;

  final AudioPlayer _musicPlayer = AudioPlayer();

  static const String _musicFile =
      'audio/Albumaty.Com_lyl_almhmdy_bghyr_alyk_mn_alaywn (1).mp3';

  int get currentSeconds {
    return (progress * totalSeconds).round();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _startMusic();
  }

  Future<void> _startMusic() async {
    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);

      await _musicPlayer.setVolume(1.0);

      await _musicPlayer.play(
        AssetSource(_musicFile),
      );

      if (mounted) {
        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint('Playing screen music error: $e');

      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  Future<void> _pauseMusic() async {
    try {
      await _musicPlayer.pause();

      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    } catch (e) {
      debugPrint('Music pause error: $e');
    }
  }

  Future<void> _resumeMusic() async {
    try {
      await _musicPlayer.resume();

      if (mounted) {
        setState(() {
          isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint('Music resume error: $e');
    }
  }

  Future<void> _toggleMusic() async {
    if (isPlaying) {
      await _pauseMusic();
    } else {
      await _resumeMusic();
    }
  }

  void changeProgress(double amount) {
    setState(() {
      progress = (progress + amount).clamp(0.0, 1.0);

      if (progress >= 1.0) {
        isPlaying = false;
      }
    });

    if (progress >= 1.0) {
      _pauseMusic();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Workout Complete'),
            content: const Text(
              'Congratulations! You completed your workout.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _musicPlayer.stop();
    _musicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Playing',
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

            // Playing Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Playing.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Now Playing',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Follow your workout and stay focused until you reach your goal.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    size: 55,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Full Body Workout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Workout Session',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Slider(
                    value: progress,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      setState(() {
                        progress = value;
                      });
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatTime(currentSeconds),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        formatTime(totalSeconds),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          changeProgress(-0.05);
                        },
                        icon: const Icon(
                          Icons.replay_10,
                          size: 32,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: _toggleMusic,
                          icon: Icon(
                            isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      IconButton(
                        onPressed: () {
                          changeProgress(0.05);
                        },
                        icon: const Icon(
                          Icons.forward_10,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.timer_outlined,
                    value: formatTime(currentSeconds),
                    title: 'Time',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.local_fire_department_outlined,
                    value: '180',
                    title: 'Calories',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 12,
      ),
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
      child: Column(
        children: [
          Icon(
            icon,
            size: 25,
            color: Colors.black,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
