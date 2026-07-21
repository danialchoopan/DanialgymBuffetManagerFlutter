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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.vazirmatn().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مدیریت باشگاه و بوفه')),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1B5E20),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'داشبورد'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'اعضا'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'تمرینات'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'بوفه'),
          BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'گزارش‌ها'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0: return const DashboardScreen();
      case 1: return const MembersScreen();
      case 2: return const WorkoutsScreen();
      case 3: return const BuffetScreen();
      case 4: return const ReportsScreen();
      default: return const DashboardScreen();
    }
  }
}

// Dashboard
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('خوش آمدید! 👋', style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(DateFormat('yyyy/MM/dd').format(DateTime.now()), style: TextStyle(color: Colors.grey[600])),
                    ],
                  )),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFF1B5E20).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.fitness_center, size: 40, color: Color(0xFF1B5E20)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('آمار سریع', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _statCard('کل اعضا', '۱,۲۵۰', Icons.people, Colors.blue)),
            const SizedBox(width: 12),
            Expanded(child: _statCard('اعضای فعال', '۹۸۰', Icons.check_circle, Colors.green)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _statCard('حضور امروز', '۱۲۵', Icons.how_to_reg, Colors.orange)),
            const SizedBox(width: 12),
            Expanded(child: _statCard('درآمد', '۵.۲M', Icons.attach_money, Colors.purple)),
          ]),
          const SizedBox(height: 16),
          Text('دسترسی سریع', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _actionCard('افزودن عضو', Icons.person_add, Colors.green)),
            const SizedBox(width: 8),
            Expanded(child: _actionCard('ورود عضو', Icons.login, Colors.blue)),
            const SizedBox(width: 8),
            Expanded(child: _actionCard('سفارش', Icons.shopping_cart, Colors.orange)),
          ]),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('فعالیت‌های اخیر', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _activityItem('ورود عضو', 'علی محمدی وارد شد', '۲ ساعت پیش', Colors.green),
                  _activityItem('سفارش جدید', 'سفارش #۱۲۳۴', '۳ ساعت پیش', Colors.orange),
                  _activityItem('پرداخت', 'رضا احمدی - ۵۰۰K', '۵ ساعت پیش', Colors.purple),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(String title, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _activityItem(String title, String subtitle, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Icon(Icons.circle, size: 8, color: color),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ])),
        Text(time, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
      ]),
    );
  }
}

// Members
class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        final members = [
          {'name': 'علی محمدی', 'status': 'فعال', 'color': Colors.green},
          {'name': 'رضا احمدی', 'status': 'فعال', 'color': Colors.green},
          {'name': 'سارا کریمی', 'status': 'منقضی', 'color': Colors.red},
          {'name': 'محمد حسینی', 'status': 'در انتظار', 'color': Colors.orange},
          {'name': 'زهرا عباسی', 'status': 'فعال', 'color': Colors.green},
        ];
        final m = members[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: m['color'] as Color, child: Text('${(m['name'] as String)[0]}', style: const TextStyle(color: Colors.white))),
            title: Text(m['name'] as String),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: m['color'] as Color, borderRadius: BorderRadius.circular(12)),
              child: Text(m['status'] as String, style: const TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        );
      },
    );
  }
}

// Workouts
class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('برنامه‌های تمرینی', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _programCard('تمرینات قدرتی', '۴ هفته', Colors.blue),
        _programCard('کاهش وزن', '۸ هفته', Colors.green),
        _programCard('افزایش حجم', '۱۲ هفته', Colors.orange),
      ],
    );
  }

  Widget _programCard(String name, String duration, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.fitness_center, color: color),
        title: Text(name),
        subtitle: Text(duration),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

// Buffet
class BuffetScreen extends StatelessWidget {
  const BuffetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('محصولات', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _productCard('پروتئین شیک', '۱۵۰K تومان', 'موجود', Colors.green),
        _productCard('آب معدنی', '۱۰K تومان', 'موجود', Colors.blue),
        _productCard('موز', '۲۵K تومان', 'کم موجود', Colors.orange),
        _productCard('نوار انرژی', '۸۵K تومان', 'تمام شده', Colors.red),
      ],
    );
  }

  Widget _productCard(String name, String price, String stock, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.restaurant, color: Colors.grey),
        title: Text(name),
        subtitle: Text(price),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Text(stock, style: TextStyle(color: color, fontSize: 11)),
        ),
      ),
    );
  }
}

// Reports
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('گزارش‌ها', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _reportCard('گزارش روزانه', Icons.calendar_today, Colors.blue),
        _reportCard('گزارش ماهانه', Icons.calendar_month, Colors.green),
        _reportCard('گزارش اعضا', Icons.people, Colors.orange),
        _reportCard('خروجی PDF', Icons.picture_as_pdf, Colors.red),
      ],
    );
  }

  Widget _reportCard(String name, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(name),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}