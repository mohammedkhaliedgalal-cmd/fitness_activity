
import 'package:flutter/material.dart';

class AllImagesScreen extends StatelessWidget {
  const AllImagesScreen({super.key});

  static const List<String> images = [
    'Account.jpg',
    'Activity.jpg',
    'Add Comment.jpg',
    'All.jpg',
    'Calendar.jpg',
    'Chat.jpg',
    'Close Friends.jpg',
    'Details - Scroll.jpg',
    'Details.jpg',
    'Discover.jpg',
    'Duel.jpg',
    'Duels.jpg',
    'Edit.jpg',
    'Feeds.jpg',
    'Frame 3.jpg',
    'Friends.jpg',
    'Home.jpg',
    'Jounery-1.jpg',
    'Jounery.jpg',
    'Library-All.jpg',
    'Library-Play.jpg',
    'Live session.jpg',
    'Map style.jpg',
    'Map.jpg',
    'Messages.jpg',
    'My workouts.jpg',
    'Notifications.jpg',
    'Playing.jpg',
    'Pricing.jpg',
    'Random.jpg',
    'Reward Scroll.jpg',
    'Reward.jpg',
    'Scroll 2.jpg',
    'Scroll 3.jpg',
    'Scroll 4.jpg',
    'Scroll-1.jpg',
    'Scroll.jpg',
    'Search.jpg',
    'Setting.jpg',
    'Start Workout.jpg',
    'Stats Scroll.jpg',
    'Workout Details.jpg',
    'Your rute.jpg',
  ];

  void openImage(
    BuildContext context,
    String imageName,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          child: Padding(
            padding: const EdgeInsets.all(15),

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    imageName,
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: Image.asset(
                      'assets/images/$imageName',
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.contain,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          height: 180,
                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Text(
                            'Image not found\n$imageName',
                            textAlign: TextAlign.center,

                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 45,

                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },

                      child: const Text(
                        'CLOSE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'All Images',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: images.length,

        itemBuilder: (context, index) {
          final imageName = images[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 25),

            child: Column(
              children: [
                Text(
                  '${index + 1}. $imageName',
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // Small Centered Image
                Center(
                  child: InkWell(
                    onTap: () {
                      openImage(context, imageName);
                    },

                    borderRadius: BorderRadius.circular(18),

                    child: Container(
                      width: 220,
                      height: 130,

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

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),

                        child: Image.asset(
                          'assets/images/$imageName',
                          width: 220,
                          height: 130,
                          fit: BoxFit.cover,

                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: Text(
                                'Image not found\n$imageName',
                                textAlign: TextAlign.center,

                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}