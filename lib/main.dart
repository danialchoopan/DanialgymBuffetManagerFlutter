import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ResponsiveMainScreen(),
    );
  }
}

// ============================================================
// RESPONSIVE MAIN SCREEN
// ============================================================

class ResponsiveMainScreen extends StatelessWidget {
  const ResponsiveMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final isTablet = constraints.maxWidth > 600 && constraints.maxWidth <= 1024;

        return Scaffold(
          body: Row(
            children: [
              // Sidebar for Desktop
              if (isDesktop) const Sidebar(),
              // Main Content
              Expanded(
                child: Scaffold(
                  appBar: isDesktop ? null : AppBar(title: const Text('مدیریت باشگاه و بوفه')),
                  body: const MainContent(),
                  bottomNavigationBar: isDesktop ? null : const BottomNavBar(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// SIDEBAR (Desktop)
// ============================================================

class SidebarWrapper extends StatefulWidget {
  const StatefulWidget({super.key, required this.child});
  final Widget child;
  @override
  State<StatefulWidget> createState() => _StatefulWidgetState();
}

class _SidebarWrapperState extends State<SidebarWrapper> {
  @override
  Widget build(BuildContext context) => widget.child;
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1B5E20),
            child: const Row(
              children: [
                Icon(Icons.fitness_center, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text('باشگاه و بوفه', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _navItem(Icons.dashboard, 'داشبورد'),
                _navItem(Icons.people, 'اعضا'),
                _navItem(Icons.fitness_center, 'تمرینات'),
                _navItem(Icons.check_circle, 'حضور و غیاب'),
                _navItem(Icons.restaurant, 'بوفه'),
                _navItem(Icons.assessment, 'گزارش‌ها'),
                const Divider(),
                _navItem(Icons.settings, 'تنظیمات'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B5E20)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {},
    );
  }
}

// ============================================================
// BOTTOM NAV (Mobile/Tablet)
// ============================================================

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
}

// ============================================================
// MAIN CONTENT
// ============================================================

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              _welcomeCard(),
              const SizedBox(height: 16),

              // Quick Stats - Responsive Grid
              Text('آمار سریع', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _responsiveGrid(
                isWide: isWide,
                children: [
                  _statCard('کل اعضا', '۱,۲۵۰', Icons.people, Colors.blue),
                  _statCard('اعضای فعال', '۹۸۰', Icons.check_circle, Colors.green),
                  _statCard('حضور امروز', '۱۲۵', Icons.how_to_reg, Colors.orange),
                  _statCard('درآمد', '۵.۲M', Icons.attach_money, Colors.purple),
                ],
              ),
              const SizedBox(height: 16),

              // Quick Actions - Responsive Grid
              Text('دسترسی سریع', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _responsiveGrid(
                isWide: isWide,
                children: [
                  _actionCard(context, 'افزودن عضو', Icons.person_add, Colors.green, const AddMemberPage()),
                  _actionCard(context, 'ورود عضو', Icons.login, Colors.blue, const CheckInPage()),
                  _actionCard(context, 'سفارش جدید', Icons.shopping_cart, Colors.orange, const NewOrderPage()),
                  _actionCard(context, 'پرداخت', Icons.payment, Colors.purple, const PaymentPage()),
                  _actionCard(context, 'گزارش‌ها', Icons.assessment, Colors.teal, const ReportsPage()),
                  _actionCard(context, 'تنظیمات', Icons.settings, Colors.grey, const SettingsPage()),
                ],
              ),
              const SizedBox(height: 16),

              // Recent Activity
              _recentActivity(),
            ],
          ),
        );
      },
    );
  }

  Widget _responsiveGrid({required bool isWide, required List<Widget> children}) {
    return GridView.count(
      crossAxisCount: isWide ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: children,
    );
  }

  Widget _welcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('خوش آمدید! 👋', style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('تاریخ: ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}', style: TextStyle(color: Colors.grey[600])),
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

  Widget _actionCard(BuildContext context, String title, IconData icon, Color color, Widget page) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('فعالیت‌های اخیر', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _activityItem('ورود عضو', 'علی محمدی وارد شد', '۲ ساعت پیش', Colors.green),
            _activityItem('سفارش جدید', 'سفارش #۱۲۳۴ - ۱۵۰K', '۳ ساعت پیش', Colors.orange),
            _activityItem('پرداخت', 'رضا احمدی - ۵۰۰K', '۵ ساعت پیش', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _activityItem(String title, String subtitle, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
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

// ============================================================
// FUNCTIONAL PAGES
// ============================================================

// Add Member Page
class AddMemberPage extends StatelessWidget {
  const AddMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('افزودن عضو جدید')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textField('نام کامل', Icons.person),
            const SizedBox(height: 12),
            _textField('شماره تلفن', Icons.phone, keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            _textField('ایمیل', Icons.email, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            _textField('تاریخ تولد', Icons.calendar_today),
            const SizedBox(height: 12),
            _textField('آدرس', Icons.location_on),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('عضو با موفقیت اضافه شد!')));
                  Navigator.pop(context);
                },
                child: const Text('ذخیره عضو', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, IconData icon, {TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

// Check-in Page
class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود عضو')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Color(0xFF1B5E20)),
            const SizedBox(height: 24),
            Text('اسکن QR Code', style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('یا شماره عضو را وارد کنید', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ورود عضو با موفقیت ثبت شد!')));
                  Navigator.pop(context);
                },
                child: const Text('ثبت ورود', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New Order Page
class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سفارش جدید')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _productTile('پروتئین شیک', '۱۵۰,۰۰۰ تومان'),
          _productTile('آب معدنی', '۱۰,۰۰۰ تومان'),
          _productTile('موز', '۲۵,۰۰۰ تومان'),
          _productTile('نوار انرژی', '۸۵,۰۰۰ تومان'),
          _productTile('شیر کم‌چرب', '۳۵,۰۰۰ تومان'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('جمع کل:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('۳۰۵,۰۰۰ تومان', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1B5E20))),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('سفارش با موفقیت ثبت شد!')));
                        Navigator.pop(context);
                      },
                      child: const Text('ثبت سفارش', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productTile(String name, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.restaurant),
        title: Text(name),
        subtitle: Text(price),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle, color: Color(0xFF1B5E20)),
          onPressed: () {},
        ),
      ),
    );
  }
}

// Payment Page
class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پرداخت')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _paymentOption('پرداخت عضویت', '۵۰۰,۰۰۰ تومان', Colors.green, Icons.card_membership),
            _paymentOption('پرداخت بوفه', '۱۵۰,۰۰۰ تومان', Colors.blue, Icons.restaurant),
            _paymentOption('پرداخت جلسات خصوصی', '۸۰۰,۰۰۰ تومان', Colors.orange, Icons.fitness_center),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('روش پرداخت', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text('نقدی'),
                      trailing: Radio(value: 1, groupValue: 1, onChanged: (v) {}),
                    ),
                    ListTile(
                      leading: const Icon(Icons.credit_card),
                      title: const Text('کارت'),
                      trailing: Radio(value: 2, groupValue: 1, onChanged: (v) {}),
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_balance),
                      title: const Text('انتقال بانکی'),
                      trailing: Radio(value: 3, groupValue: 1, onChanged: (v) {}),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('پرداخت با موفقیت انجام شد!')));
                          Navigator.pop(context);
                        },
                        child: const Text('تکمیل پرداخت', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String title, String amount, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(amount),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

// Reports Page
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('گزارش‌ها')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _reportCard('گزارش روزانه', 'امروز - ۱۵,۰۰۰,۰۰۰ درآمد', Icons.calendar_today, Colors.blue),
          _reportCard('گزارش ماهانه', 'تیر ماه - ۴۵۰,۰۰۰,۰۰۰ درآمد', Icons.calendar_month, Colors.green),
          _reportCard('گزارش اعضا', '۱,۲۵۰ عضو کل', Icons.people, Colors.orange),
          _reportCard('گزارش حضور', 'میانگین ۱۲۰ نفر روزانه', Icons.how_to_reg, Colors.purple),
          _reportCard('گزارش مالی', 'سود خالص: ۱۲۰,۰۰۰,۰۰۰', Icons.account_balance, Colors.teal),
          _reportCard('خروجی PDF', 'دانلود گزارش PDF', Icons.picture_as_pdf, Colors.red),
          _reportCard('خروجی اکسل', 'دانلود گزارش اکسل', Icons.table_chart, Colors.green),
        ],
      ),
    );
  }

  Widget _reportCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات')),
      body: ListView(
        children: [
          _settingsTile('اطلاعات باشگاه', Icons.business, () {}),
          _settingsTile('مدیریت کاربران', Icons.people, () {}),
          _settingsTile('تنظیمات مالی', Icons.account_balance, () {}),
          _settingsTile('پشتیبان‌گیری', Icons.backup, () {}),
          _settingsTile('پشتیبانی', Icons.support, () {}),
          _settingsTile('درباره برنامه', Icons.info, () {}),
        ],
      ),
    );
  }

  Widget _settingsTile(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1B5E20)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_left),
        onTap: onTap,
      ),
    );
  }
}