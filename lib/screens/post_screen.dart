import 'package:flutter/material.dart';
import 'comments_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final Set<String> likedPosts = {};
  final Set<String> savedPosts = {};

  final Map<String, int> likesCount = {
    'Today Activity': 0,
    'Discover': 0,
    'Friends': 0,
    'Your Reward': 0,
  };

  void toggleLike(String title) {
    setState(() {
      if (likedPosts.contains(title)) {
        likedPosts.remove(title);
        likesCount[title] = (likesCount[title] ?? 1) - 1;
      } else {
        likedPosts.add(title);
        likesCount[title] = (likesCount[title] ?? 0) + 1;
      }
    });
  }

  void toggleSave(String title) {
    setState(() {
      if (savedPosts.contains(title)) {
        savedPosts.remove(title);
      } else {
        savedPosts.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Posts',
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
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            _postCard(
              context,
              image: 'assets/images/Feeds.jpg',
              title: 'Today Activity',
              description:
                  'Keep moving and stay consistent with your workout.',
            ),
            _postCard(
              context,
              image: 'assets/images/Discover.jpg',
              title: 'Discover',
              description:
                  'Discover new workouts and fitness activities.',
            ),
            _postCard(
              context,
              image: 'assets/images/Friends.jpg',
              title: 'Friends',
              description:
                  'Share your progress with your friends.',
            ),
            _postCard(
              context,
              image: 'assets/images/Reward.jpg',
              title: 'Your Reward',
              description:
                  'Keep going and achieve your daily goals.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _postCard(
    BuildContext context, {
    required String image,
    required String title,
    required String description,
  }) {
    final bool isLiked = likedPosts.contains(title);
    final bool isSaved = savedPosts.contains(title);
    final int likes = likesCount[title] ?? 0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                width: 220,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 220,
                    height: 130,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        toggleLike(title);
                      },
                      icon: Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                    ),
                    if (likes > 0)
                      Text(
                        '$likes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CommentsScreen(
                              postTitle: title,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.chat_bubble_outline,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        toggleSave(title);
                      },
                      icon: Icon(
                        isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: isSaved ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}