import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/themes/typography.dart';
import '../../widgets/common/loading_overlay.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _buildSectionHeader('Account'),
            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.person,
                  title: 'Profile',
                  subtitle: 'Edit your profile information',
                  onTap: () {
                    // TODO: Navigate to profile
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: () {
                    // TODO: Navigate to change password
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.fingerprint,
                  title: 'Biometric Authentication',
                  subtitle: 'Enable fingerprint or face ID',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // TODO: Toggle biometric
                    },
                    activeColor: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Appearance Section
            _buildSectionHeader('Appearance'),
            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Toggle dark mode',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // TODO: Toggle theme
                    },
                    activeColor: AppColors.primaryLight,
                  ),
                ),
                _buildSettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {
                    // TODO: Navigate to language settings
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Data Management Section
            _buildSectionHeader('Data Management'),
            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.backup,
                  title: 'Backup Data',
                  subtitle: 'Create a backup of your data',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/backup');
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.restore,
                  title: 'Restore Data',
                  subtitle: 'Restore from a backup',
                  onTap: () {
                    // TODO: Navigate to restore
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.download,
                  title: 'Export Data',
                  subtitle: 'Export data to CSV or Excel',
                  onTap: () {
                    // TODO: Navigate to export
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.delete_forever,
                  title: 'Clear Data',
                  subtitle: 'Clear all application data',
                  onTap: () {
                    _showClearDataDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // User Management Section (Admin only)
            _buildSectionHeader('User Management'),
            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.people,
                  title: 'Manage Users',
                  subtitle: 'Add, edit, or remove users',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/users');
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.security,
                  title: 'Roles & Permissions',
                  subtitle: 'Manage user roles and permissions',
                  onTap: () {
                    // TODO: Navigate to roles
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // About Section
            _buildSectionHeader('About'),
            _buildSettingsCard(
              children: [
                _buildSettingsTile(
                  icon: Icons.info,
                  title: 'About',
                  subtitle: 'App version 1.0.0',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/about');
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.help,
                  title: 'Help & Support',
                  subtitle: 'Get help with the app',
                  onTap: () {
                    // TODO: Navigate to help
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.description,
                  title: 'Terms & Privacy',
                  subtitle: 'View terms and privacy policy',
                  onTap: () {
                    // TODO: Navigate to terms
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: AppColors.error),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: AppTypography.titleMedium.copyWith(
          color: AppColors.grey600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryLight),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Data'),
          content: const Text(
            'Are you sure you want to clear all application data? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Clear data
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data cleared successfully'),
                  ),
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Logout
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}