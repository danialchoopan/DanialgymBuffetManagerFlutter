import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF1B5E20),
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const GymBuffetManagerApp());
}

class GymBuffetManagerApp extends StatelessWidget {
  const GymBuffetManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدیریت باشگاه و بوفه',
      debugShowCheckedModeBanner: false,
      
      // RTL Support
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      
      // Theme
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.vazirmatn().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      
      // RTL by default
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      
      home: const MainScreen(),
    );
  }
}

// ============================================================
// MAIN SCREEN WITH NAVIGATION
// ============================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<String> _titles = [
    'داشبورد',
    'اعضا',
    'تمرینات',
    'بوفه',
    'گزارش‌ها',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(context),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => _showProfile(context),
          ),
        ],
      ),
      drawer: isDesktop ? null : _buildDrawer(context),
      body: _buildBody(),
      bottomNavigationBar: isDesktop ? null : _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const MembersScreen();
      case 2:
        return const WorkoutsScreen();
      case 3:
        return const BuffetScreen();
      case 4:
        return const ReportsScreen();
      default:
        return const DashboardScreen();
    }
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
                    Icons.fitness_center,
                    size: 30,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'مدیریت باشگاه و بوفه',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
          _buildDrawerItem(0, Icons.dashboard, 'داشبورد'),
          _buildDrawerItem(1, Icons.people, 'اعضا'),
          _buildDrawerItem(2, Icons.fitness_center, 'تمرینات'),
          _buildDrawerItem(3, Icons.restaurant, 'بوفه'),
          _buildDrawerItem(4, Icons.assessment, 'گزارش‌ها'),
          const Divider(),
          _buildDrawerItem(5, Icons.settings, 'تنظیمات'),
          _buildDrawerItem(6, Icons.backup, 'پشتیبان‌گیری'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: _currentIndex == index ? const Color(0xFF1B5E20) : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          color: _currentIndex == index ? const Color(0xFF1B5E20) : Colors.black,
          fontWeight: _currentIndex == index ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: _currentIndex == index,
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1B5E20),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'داشبورد'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'اعضا'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'تمرینات'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'بوفه'),
        BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'گزارش‌ها'),
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('اعلان‌ها', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text('هشدار موجودی'),
              subtitle: const Text('مکمل‌های ورزشی رو به اتمام است'),
              trailing: const Text('۲ ساعت پیش'),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text('انقضای عضویت'),
              subtitle: const Text('۵ عضویت این هفته منقضی می‌شود'),
              trailing: const Text('۵ ساعت پیش'),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF1B5E20),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('مدیر سیستم', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('admin@gym.com', style: TextStyle(color: Colors.grey)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('تنظیمات'),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('خروج', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD SCREEN
// ============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 16),
          _buildQuickStats(context),
          const SizedBox(height: 16),
          _buildQuickActions(context),
          const SizedBox(height: 16),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyy/MM/dd - EEEE', 'fa_IR').format(now);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'خوش آمدید! 👋',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateStr,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B5E20).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.fitness_center, size: 40, color: Color(0xFF1B5E20)),
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
        const Text('آمار سریع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard('کل اعضا', '۱,۲۵۰', Icons.people, const Color(0xFF2196F3))),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard('اعضای فعال', '۹۸۰', Icons.check_circle, const Color(0xFF4CAF50))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard('حضور امروز', '۱۲۵', Icons.how_to_reg, const Color(0xFFFF9800))),
            const SizedBox(width: 12),
            Expanded(child: _buildStatCard('درآمد امروز', '۵,۲۰۰,۰۰۰', Icons.attach_money, const Color(0xFF9C27B0))),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('دسترسی سریع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActionCard(context, 'افزودن عضو', Icons.person_add, const Color(0xFF4CAF50))),
            const SizedBox(width: 8),
            Expanded(child: _buildActionCard(context, 'ورود عضو', Icons.login, const Color(0xFF2196F3))),
            const SizedBox(width: 8),
            Expanded(child: _buildActionCard(context, 'سفارش جدید', Icons.shopping_cart, const Color(0xFFFF9800))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildActionCard(context, 'پرداخت', Icons.payment, const Color(0xFF9C27B0))),
            const SizedBox(width: 8),
            Expanded(child: _buildActionCard(context, 'گزارش‌ها', Icons.assessment, const Color(0xFF009688))),
            const SizedBox(width: 8),
            Expanded(child: _buildActionCard(context, 'تنظیمات', Icons.settings, const Color(0xFF607D8B))),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('باز کردن $title...')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('فعالیت‌های اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

// ============================================================
// MEMBERS SCREEN
// ============================================================

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'جستجوی اعضا...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilterChip(label: const Text('همه'), selected: true, onSelected: (v) {}, selectedColor: const Color(0xFF1B5E20), labelStyle: const TextStyle(color: Colors.white)),
              const SizedBox(width: 8),
              FilterChip(label: const Text('فعال'), selected: false, onSelected: (v) {}),
              const SizedBox(width: 8),
              FilterChip(label: const Text('منقضی'), selected: false, onSelected: (v) {}),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) => _buildMemberCard(context, index),
          ),
        ),
      ],
    );
  }

  Widget _buildMemberCard(BuildContext context, int index) {
    final members = [
      {'name': 'علی محمدی', 'phone': '۰۹۱۲۱۲۳۴۵۶۷', 'status': 'فعال', 'expiry': '۱۴۰۳/۰۵/۲۴', 'statusEn': 'Active'},
      {'name': 'رضا احمدی', 'phone': '۰۹۱۲۹۸۷۶۵۴۳', 'status': 'فعال', 'expiry': '۱۴۰۳/۰۷/۲۸', 'statusEn': 'Active'},
      {'name': 'سارا کریمی', 'phone': '۰۹۱۲۵۵۵۴۴۳۳', 'status': 'در حال انقضا', 'expiry': '۱۴۰۳/۰۴/۰۳', 'statusEn': 'Expiring'},
      {'name': 'محمد حسینی', 'phone': '۰۹۱۲۱۱۱۲۲۳۳', 'status': 'منقضی', 'expiry': '۱۴۰۳/۰۳/۱۴', 'statusEn': 'Expired'},
      {'name': 'زهرا عباسی', 'phone': '۰۹۱۲۳۳۳۴۴۵۵', 'status': 'فعال', 'expiry': '۱۴۰۳/۱۰/۱۰', 'statusEn': 'Active'},
    ];
    
    final member = members[index];
    final isExpired = member['statusEn'] == 'Expired';
    final isExpiring = member['statusEn'] == 'Expiring';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isExpired ? Colors.red : (isExpiring ? Colors.orange : const Color(0xFF1B5E20)),
          child: Text(member['name']![0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(member['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('تاریخ انقضا: ${member['expiry']}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isExpired ? Colors.red : (isExpiring ? Colors.orange : const Color(0xFF4CAF50)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(member['status']!, style: const TextStyle(color: Colors.white, fontSize: 11)),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('مشاهده ${member['name']}')),
          );
        },
      ),
    );
  }
}

// ============================================================
// WORKOUTS SCREEN
// ============================================================

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('کتابخانه تمرینات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildExerciseCategory('سینه', Icons.fitness_center, const Color(0xFF2196F3)),
                _buildExerciseCategory('پشت', Icons.accessibility_new, const Color(0xFF4CAF50)),
                _buildExerciseCategory('پا', Icons.directions_run, const Color(0xFFFF9800)),
                _buildExerciseCategory('بازو', Icons.sports_martial_arts, const Color(0xFF9C27B0)),
                _buildExerciseCategory('شکم', Icons.self_improvement, const Color(0xFF009688)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('برنامه‌های تمرینی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildProgramCard('تمرینات قدرتی', '۴ هفته', '۳ روز در هفته', const Color(0xFF2196F3)),
          _buildProgramCard('کاهش وزن', '۸ هفته', '۵ روز در هفته', const Color(0xFF4CAF50)),
          _buildProgramCard('افزایش حجم', '۱۲ هفته', '۴ روز در هفته', const Color(0xFFFF9800)),
        ],
      ),
    );
  }

  Widget _buildExerciseCategory(String name, IconData icon, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(name, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildProgramCard(String name, String duration, String frequency, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.fitness_center, color: color),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('$duration | $frequency'),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

// ============================================================
// BUFFET SCREEN
// ============================================================

class BuffetScreen extends StatelessWidget {
  const BuffetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('محصولات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildProductCard('پروتئین شیک', '۱۵۰,۰۰۰ تومان', 'موجود', const Color(0xFF4CAF50))),
              const SizedBox(width: 12),
              Expanded(child: _buildProductCard('آب معدنی', '۱۰,۰۰۰ تومان', 'موجود', const Color(0xFF2196F3))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildProductCard('موز', '۲۵,۰۰۰ تومان', 'کم موجود', const Color(0xFFFF9800))),
              const SizedBox(width: 12),
              Expanded(child: _buildProductCard('نوار انرژی', '۸۵,۰۰۰ تومان', 'تمام شده', const Color(0xFFF44336))),
            ],
          ),
          const SizedBox(height: 20),
          const Text('سفارشات اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOrderCard('#۱۲۳۴', 'علی محمدی', '۱۵۰,۰۰۰ تومان', 'تکمیل شده'),
          _buildOrderCard('#۱۲۳۵', 'مشتری', '۴۵,۰۰۰ تومان', 'در انتظار'),
          _buildOrderCard('#۱۲۳۶', 'رضا احمدی', '۲۲۰,۰۰۰ تومان', 'در حال آماده‌سازی'),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String stock, Color stockColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: stockColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(stock, style: TextStyle(color: stockColor, fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(String id, String customer, String total, String status) {
    Color statusColor;
    switch (status) {
      case 'تکمیل شده':
        statusColor = const Color(0xFF4CAF50);
        break;
      case 'در انتظار':
        statusColor = const Color(0xFFFF9800);
        break;
      default:
        statusColor = const Color(0xFF2196F3);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('سفارش $id', style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('$customer | $total'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 11)),
        ),
      ),
    );
  }
}

// ============================================================
// REPORTS SCREEN
// ============================================================

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('خلاصه مالی', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('درآمد', '+۱۵,۰۰۰,۰۰۰ تومان', const Color(0xFF4CAF50))),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('هزینه‌ها', '-۸,۰۰۰,۰۰۰ تومان', const Color(0xFFF44336))),
            ],
          ),
          const SizedBox(height: 8),
          _buildSummaryCard('سود خالص', '+۷,۰۰۰,۰۰۰ تومان', const Color(0xFF2196F3)),
          const SizedBox(height: 20),
          const Text('انواع گزارش', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildReportOption(context, 'گزارش روزانه', Icons.calendar_today),
          _buildReportOption(context, 'گزارش ماهانه', Icons.calendar_month),
          _buildReportOption(context, 'گزارش اعضا', Icons.people),
          _buildReportOption(context, 'گزارش حضور', Icons.how_to_reg),
          _buildReportOption(context, 'خروجی PDF', Icons.picture_as_pdf),
          _buildReportOption(context, 'خروجی اکسل', Icons.table_chart),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1B5E20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_left),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تولید $title...')),
          );
        },
      ),
    );
  }
}