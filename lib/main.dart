import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GymBuffetManagerApp());
}

class GymBuffetManagerApp extends StatelessWidget {
  const GymBuffetManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدیریت باشگاه و بوفه',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final isDesktop = constraints.maxWidth > 1024;

        return Scaffold(
          appBar: _buildAppBar(context, isTablet),
          drawer: isTablet ? null : _buildDrawer(context),
          body: isDesktop
              ? _buildDesktopLayout(context)
              : isTablet
                  ? _buildTabletLayout(context)
                  : _buildMobileLayout(context),
          bottomNavigationBar: !isTablet ? _buildBottomNav(context) : null,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isTablet) {
    return AppBar(
      title: Text(
        'مدیریت باشگاه و بوفه',
        style: GoogleFonts.vazirmatn(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xFF1B5E20),
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
        if (isTablet)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF1B5E20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 36,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'مدیر سیستم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'admin@gym.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'داشبورد', () {}),
          _buildDrawerItem(Icons.people, 'اعضا', () {}),
          _buildDrawerItem(Icons.fitness_center, 'تمرینات', () {}),
          _buildDrawerItem(Icons.check_circle, 'حضور و غیاب', () {}),
          _buildDrawerItem(Icons.restaurant, 'بوفه', () {}),
          _buildDrawerItem(Icons.assessment, 'گزارش‌ها', () {}),
          const Divider(),
          _buildDrawerItem(Icons.settings, 'تنظیمات', () {}),
          _buildDrawerItem(Icons.backup, 'پشتیبان‌گیری', () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B5E20)),
      title: Text(title),
      onTap: onTap,
    );
  }

  // ============================================================
  // RESPONSIVE LAYOUTS
  // ============================================================

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 20),
          _buildQuickStats(context),
          const SizedBox(height: 20),
          _buildQuickActions(context),
          const SizedBox(height: 20),
          _buildRecentActivity(context),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 24),
          _buildQuickStats(context),
          const SizedBox(height: 24),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildRecentActivity(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Sidebar Navigation
        SizedBox(
          width: 250,
          child: _buildDesktopSidebar(context),
        ),
        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(context),
                const SizedBox(height: 24),
                _buildQuickStats(context),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildQuickActions(context),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildRecentActivity(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSidebar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1B5E20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: Color(0xFF1B5E20),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'باشگاه بدنسازی',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSidebarItem(Icons.dashboard, 'داشبورد', true),
                _buildSidebarItem(Icons.people, 'اعضا', false),
                _buildSidebarItem(Icons.fitness_center, 'تمرینات', false),
                _buildSidebarItem(Icons.check_circle, 'حضور و غیاب', false),
                _buildSidebarItem(Icons.restaurant, 'بوفه', false),
                _buildSidebarItem(Icons.assessment, 'گزارش‌ها', false),
                const Divider(),
                _buildSidebarItem(Icons.settings, 'تنظیمات', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1B5E20).withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFF1B5E20) : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1B5E20) : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // ============================================================
  // CONTENT SECTIONS
  // ============================================================

  Widget _buildWelcomeSection(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'سلام 👋',
                    style: GoogleFonts.vazirmatn(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'به مدیریت باشگاه و بوفه خوش آمدید',
                    style: GoogleFonts.vazirmatn(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تاریخ امروز: ${_getPersianDate()}',
                    style: GoogleFonts.vazirmatn(
                      fontSize: 14,
                      color: const Color(0xFF1B5E20),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1B5E20).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.fitness_center,
                size: 48,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'آمار سریع',
          style: GoogleFonts.vazirmatn(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ResponsiveBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 800 ? 4 : 2;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('کل اعضا', '۱,۲۵۰', Icons.people, const Color(0xFF2196F3)),
                _buildStatCard('اعضای فعال', '۹۸۰', Icons.check_circle, const Color(0xFF4CAF50)),
                _buildStatCard('حضور امروز', '۱۲۵', Icons.how_to_reg, const Color(0xFFFF9800)),
                _buildStatCard('درآمد امروز', '۵.۲M', Icons.attach_money, const Color(0xFF9C27B0)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: GoogleFonts.vazirmatn(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.vazirmatn(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'دسترسی سریع',
          style: GoogleFonts.vazirmatn(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ResponsiveBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 800 ? 4 : 3;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                _buildActionCard('افزودن عضو', Icons.person_add, const Color(0xFF4CAF50)),
                _buildActionCard('ورود عضو', Icons.login, const Color(0xFF2196F3)),
                _buildActionCard('سفارش جدید', Icons.shopping_cart, const Color(0xFFFF9800)),
                _buildActionCard('پرداخت', Icons.payment, const Color(0xFF9C27B0)),
                _buildActionCard('گزارش‌ها', Icons.assessment, const Color(0xFF009688)),
                _buildActionCard('تنظیمات', Icons.settings, const Color(0xFF607D8B)),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.vazirmatn(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'فعالیت‌های اخیر',
              style: GoogleFonts.vazirmatn(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildActivityItem('ورود عضو', 'علی محمدی وارد شد', '۲ ساعت پیش', Icons.login, const Color(0xFF4CAF50)),
            _buildActivityItem('سفارش جدید', 'سفارش #۱۲۳۴ - ۱۵۰,۰۰۰ تومان', '۳ ساعت پیش', Icons.shopping_cart, const Color(0xFFFF9800)),
            _buildActivityItem('پرداخت', 'رضا احمدی - ۵۰۰,۰۰۰ تومان', '۵ ساعت پیش', Icons.payment, const Color(0xFF9C27B0)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.vazirmatn(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.vazirmatn(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.vazirmatn(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1B5E20),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'داشبورد'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'اعضا'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'تمرینات'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'بوفه'),
        BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'گزارش‌ها'),
      ],
      onTap: (index) {},
    );
  }

  String _getPersianDate() {
    final now = DateTime.now();
    return '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}';
  }
}

// ============================================================
// RESPONSIVE BUILDER WIDGET
// ============================================================

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: builder,
    );
  }
}