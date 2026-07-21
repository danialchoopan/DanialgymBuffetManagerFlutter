import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.grey500,
      selectedLabelStyle: AppTypography.labelSmall.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTypography.labelSmall,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Members',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Buffet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Reports',
        ),
      ],
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;

  const AppDrawer({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.white,
                  child: Icon(
                    Icons.person,
                    size: 36,
                    color: AppColors.primaryLight,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gym Buffet Manager',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'admin@gym.com',
                  style: TextStyle(
                    color: AppColors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            route: '/dashboard',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'Members',
            route: '/members',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.fitness_center,
            title: 'Workouts',
            route: '/workouts',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.restaurant,
            title: 'Buffet',
            route: '/buffet',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.assessment,
            title: 'Reports',
            route: '/reports',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.people_outline,
            title: 'Trainers',
            route: '/trainers',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            route: '/settings',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          _buildDrawerItem(
            icon: Icons.backup,
            title: 'Backup',
            route: '/backup',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            route: '/logout',
            currentRoute: currentRoute,
            onTap: onNavigate,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required String route,
    required String currentRoute,
    required ValueChanged<String> onTap,
  }) {
    final isSelected = currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryLight : AppColors.grey600,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryLight : AppColors.grey800,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primaryLight.withOpacity(0.1),
      onTap: () => onTap(route),
    );
  }
}