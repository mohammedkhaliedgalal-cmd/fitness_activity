import 'package:flutter/material.dart';
import 'library_play_screen.dart';
import 'my_workouts_screen.dart';
import 'playing_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  void openScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Library',
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

            // Library Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Library-All.jpg',
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
                        Icons.library_books_outlined,
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
              'Library',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Explore your saved workouts and fitness content.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            _libraryItem(
              context: context,
              icon: Icons.fitness_center,
              title: 'Workouts',
              subtitle: 'Your saved workout programs',
              onTap: () {
                openScreen(
                  context,
                  const MyWorkoutsScreen(),
                );
              },
            ),

            const SizedBox(height: 12),

            _libraryItem(
              context: context,
              icon: Icons.play_circle_outline,
              title: 'Videos',
              subtitle: 'Saved workout videos',
              onTap: () {
                openScreen(
                  context,
                  const LibraryPlayScreen(),
                );
              },
            ),

            const SizedBox(height: 12),

            _libraryItem(
              context: context,
              icon: Icons.favorite_outline,
              title: 'Favorites',
              subtitle: 'Your favorite fitness content',
              onTap: () {
                openScreen(
                  context,
                  const PlayingScreen(),
                );
              },
            ),

            const SizedBox(height: 12),

            _libraryItem(
              context: context,
              icon: Icons.bookmark_outline,
              title: 'Saved',
              subtitle: 'Content you saved for later',
              onTap: () {
                openScreen(
                  context,
                  const LibraryPlayScreen(),
                );
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  openScreen(
                    context,
                    const LibraryPlayScreen(),
                  );
                },
                icon: const Icon(
                  Icons.library_books_outlined,
                ),
                label: const Text(
                  'EXPLORE LIBRARY',
                  style: TextStyle(
                    fontSize: 15,
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

  Widget _libraryItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
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
              color: Colors.black.withOpacity(0.04),
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