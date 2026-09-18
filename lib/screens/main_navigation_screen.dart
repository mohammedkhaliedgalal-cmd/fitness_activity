import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'activity_screen.dart';
import 'add_comment_screen.dart';
import 'all_images_screen.dart';
import 'all_screen.dart';
import 'chat_screen.dart';
import 'close_friends_screen.dart';
import 'details_scroll_screen.dart';
import 'duel_screen.dart';
import 'duels_screen.dart';
import 'edit_screen.dart';
import 'home_screen.dart';
import 'journey_screen.dart';
import 'library_play_screen.dart';
import 'library_screen.dart';
import 'live_session_screen.dart';
import 'map_screen.dart';
import 'map_style_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';
import 'playing_screen.dart';
import 'pricing_screen.dart';
import 'random_screen.dart';
import 'reward_screen.dart';
import 'scroll_1_screen.dart';
import 'scroll_2_screen.dart';
import 'scroll_3_screen.dart';
import 'scroll_4_screen.dart';
import 'scroll_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onDarkModeChanged;

  const MainNavigationScreen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    ActivityScreen(),
    JourneyScreen(),
    MapScreen(),
  ];

  // =========================
  // OPEN DRAWER SCREEN
  // =========================
  void openScreen(Widget screen) {
    Navigator.of(context).pop();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    });
  }

  // =========================
  // TOGGLE DARK MODE
  // =========================
  void toggleDarkMode() {
    Navigator.of(context).pop();
    widget.onDarkModeChanged();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fitness Activity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),

      // =========================
      // DRAWER
      // =========================
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // =========================
              // DRAWER HEADER
              // =========================
              Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  25,
                  20,
                  25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          isDark ? Colors.white12 : Colors.black12,
                      child: Icon(
                        Icons.fitness_center,
                        size: 30,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Fitness Activity',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'All Features',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // =========================
              // ACCOUNT
              // =========================
              _buildDrawerSectionTitle('Account'),

              _buildDrawerItem(
                icon: Icons.person_outline,
                title: 'Account',
                targetScreen: const AccountScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.chat_outlined,
                title: 'Chat',
                targetScreen: const ChatScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.message_outlined,
                title: 'Messages',
                targetScreen: const MessagesScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                targetScreen: const NotificationsScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.search,
                title: 'Search',
                targetScreen: const SearchScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                targetScreen: const SettingsScreen(),
              ),

              const Divider(),

              // =========================
              // WORKOUT
              // =========================
              _buildDrawerSectionTitle('Workout'),

              _buildDrawerItem(
                icon: Icons.fitness_center,
                title: 'Library',
                targetScreen: const LibraryScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.play_circle_outline,
                title: 'Library Play',
                targetScreen: const LibraryPlayScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.music_note,
                title: 'Playing',
                targetScreen: const PlayingScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.shuffle,
                title: 'Random Workout',
                targetScreen: const RandomScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.sports_score,
                title: 'Duels',
                targetScreen: const DuelsScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.sports_mma,
                title: 'Duel',
                targetScreen: const DuelScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.live_tv,
                title: 'Live Session',
                targetScreen: const LiveSessionScreen(),
              ),

              const Divider(),

              // =========================
              // COMMUNITY
              // =========================
              _buildDrawerSectionTitle('Community'),

              _buildDrawerItem(
                icon: Icons.people_outline,
                title: 'Close Friends',
                targetScreen: const CloseFriendsScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.comment_outlined,
                title: 'Add Comment',
                targetScreen: const AddCommentScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.edit_outlined,
                title: 'Edit Profile',
                targetScreen: const EditScreen(),
              ),

              const Divider(),

              // =========================
              // MORE
              // =========================
              _buildDrawerSectionTitle('More'),

              _buildDrawerItem(
                icon: Icons.map_outlined,
                title: 'Map Style',
                targetScreen: const MapStyleScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.emoji_events_outlined,
                title: 'Rewards',
                targetScreen: const RewardScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.info_outline,
                title: 'Workout Details',
                targetScreen: const DetailsScrollScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.view_list_outlined,
                title: 'Workouts',
                targetScreen: const ScrollScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.list_alt_outlined,
                title: 'Exercise List',
                targetScreen: const Scroll1Screen(),
              ),

              _buildDrawerItem(
                icon: Icons.show_chart,
                title: 'Activity Progress',
                targetScreen: const Scroll2Screen(),
              ),

              _buildDrawerItem(
                icon: Icons.emoji_events_outlined,
                title: 'Achievements',
                targetScreen: const Scroll3Screen(),
              ),

              _buildDrawerItem(
                icon: Icons.calendar_month_outlined,
                title: 'Weekly Activity',
                targetScreen: const Scroll4Screen(),
              ),

              _buildDrawerItem(
                icon: Icons.apps,
                title: 'All',
                targetScreen: const AllScreen(),
              ),

              _buildDrawerItem(
                icon: Icons.workspace_premium_outlined,
                title: 'Pricing',
                targetScreen: const PricingScreen(),
              ),

              const Divider(),

              // =========================
              // ALL IMAGES
              // =========================
              _buildDrawerItem(
                icon: Icons.photo_library_outlined,
                title: 'All Images',
                targetScreen: const AllImagesScreen(),
              ),

              const Divider(),

              // =========================
              // DARK MODE
              // =========================
              ListTile(
                leading: Icon(
                  isDark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                title: Text(
                  isDark ? 'Light Mode' : 'Dark Mode',
                ),
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) {
                    toggleDarkMode();
                  },
                ),
                dense: true,
                onTap: toggleDarkMode,
              ),
            ],
          ),
        ),
      ),

      // =========================
      // MAIN SCREENS
      // =========================
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor:
            isDark ? Colors.white60 : Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk_outlined),
            activeIcon: Icon(Icons.directions_walk),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            activeIcon: Icon(Icons.flag),
            label: 'Journey',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
    );
  }

  // =========================
  // DRAWER SECTION TITLE
  // =========================
  Widget _buildDrawerSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        8,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // =========================
  // DRAWER ITEM
  // =========================
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Widget targetScreen,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: isDark ? Colors.white : Colors.black87,
      ),
      title: Text(title),
      dense: true,
      onTap: () {
        openScreen(targetScreen);
      },
    );
  }
}