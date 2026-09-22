import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'language_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool sound = true;
  bool music = true;
  bool darkMode = false;

  final AudioPlayer _musicPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Start music automatically when Settings opens
    _startMusic();
  }

  Future<void> _startMusic() async {
    if (!music) return;

    try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(sound ? 1.0 : 0.0);
      await _musicPlayer.play(
        AssetSource('audio/workout_music.mp3'),
      );
    } catch (e) {
      debugPrint('Music error: $e');
    }
  }

  Future<void> _stopMusic() async {
    try {
      await _musicPlayer.stop();
    } catch (e) {
      debugPrint('Music stop error: $e');
    }
  }

  Future<void> _toggleMusic(bool value) async {
    setState(() {
      music = value;
    });

    if (value) {
      await _startMusic();
    } else {
      await _stopMusic();
    }
  }

  Future<void> _toggleSound(bool value) async {
    setState(() {
      sound = value;
    });

    try {
      await _musicPlayer.setVolume(value ? 1.0 : 0.0);
    } catch (e) {
      debugPrint('Sound error: $e');
    }
  }

  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

  @override
  void dispose() {
    _musicPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Settings',
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

            // Settings Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Setting.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.settings,
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
              'Settings',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Customize your fitness app experience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // Notifications
            _settingsItem(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'Receive workout notifications',
              trailing: Switch(
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            // Sound
            _settingsItem(
              icon: Icons.volume_up_outlined,
              title: 'Sound',
              subtitle: sound
                  ? 'App sounds are enabled'
                  : 'App sounds are disabled',
              trailing: Switch(
                value: sound,
                onChanged: _toggleSound,
              ),
            ),

            const SizedBox(height: 12),

            // Music
            _settingsItem(
              icon: Icons.music_note_outlined,
              title: 'Music',
              subtitle: music
                  ? 'Workout music is playing'
                  : 'Workout music is disabled',
              trailing: Switch(
                value: music,
                onChanged: _toggleMusic,
              ),
            ),

            const SizedBox(height: 12),

            // Dark Mode
            _settingsItem(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              subtitle: darkMode
                  ? 'Dark appearance is enabled'
                  : 'Use dark appearance',
              trailing: Switch(
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            // Language
            _settingsItem(
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Privacy
            _settingsItem(
              icon: Icons.lock_outline,
              title: 'Privacy',
              subtitle: 'Manage your privacy settings',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                showMessage(
                  'Privacy',
                  'Privacy settings are available here.',
                );
              },
            ),

            const SizedBox(height: 12),

            // About
            _settingsItem(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'About Fitness Activity',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                showMessage(
                  'About Fitness Activity',
                  'Fitness Activity\n\nVersion 1.0.0',
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 25,
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

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            trailing,
          ],
        ),
      ),
    );
  }
}