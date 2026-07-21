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
      title: 'Gym & Buffet Manager',
      debugShowCheckedModeBanner: false,
      
      // RTL by default
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      
      // Theme
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      
      // RTL support
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
    'Dashboard',
    'Members',
    'Workouts',
    'Buffet',
    'Reports',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
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
                  'Gym Buffet Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(0, Icons.dashboard, 'Dashboard'),
          _buildDrawerItem(1, Icons.people, 'Members'),
          _buildDrawerItem(2, Icons.fitness_center, 'Workouts'),
          _buildDrawerItem(3, Icons.restaurant, 'Buffet'),
          _buildDrawerItem(4, Icons.assessment, 'Reports'),
          const Divider(),
          _buildDrawerItem(5, Icons.settings, 'Settings'),
          _buildDrawerItem(6, Icons.backup, 'Backup'),
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
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Buffet'),
        BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'Reports'),
      ],
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.warning, color: Colors.orange),
              title: const Text('Low Stock Alert'),
              subtitle: const Text('Vitamin supplements running low'),
              trailing: const Text('2h ago'),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: const Text('Membership Expiring'),
              subtitle: const Text('5 memberships expiring this week'),
              trailing: const Text('5h ago'),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
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
            const Text(
              'Admin User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('admin@gym.com', style: TextStyle(color: Colors.grey)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
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
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(now);
    
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
                    'Welcome Back! 👋',
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
        const Text('Quick Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard('Total Members', '1,250', Icons.people, const Color(0xFF2196F3)),
            _buildStatCard('Active Members', '980', Icons.check_circle, const Color(0xFF4CAF50)),
            _buildStatCard("Today's Attendance", '125', Icons.how_to_reg, const Color(0xFFFF9800)),
            _buildStatCard("Today's Revenue", '\$5,200', Icons.attach_money, const Color(0xFF9C27B0)),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
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
        const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(context, 'Add Member', Icons.person_add, const Color(0xFF4CAF50), const MembersScreen()),
            _buildActionCard(context, 'Check-in', Icons.login, const Color(0xFF2196F3), null),
            _buildActionCard(context, 'New Order', Icons.shopping_cart, const Color(0xFFFF9800), const BuffetScreen()),
            _buildActionCard(context, 'Payment', Icons.payment, const Color(0xFF9C27B0), null),
            _buildActionCard(context, 'Reports', Icons.assessment, const Color(0xFF009688), const ReportsScreen()),
            _buildActionCard(context, 'Settings', Icons.settings, const Color(0xFF607D8B), null),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon, Color color, Widget? screen) {
    return Card(
      child: InkWell(
        onTap: screen != null
            ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen))
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title - Coming Soon')),
                );
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
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
            const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildActivityItem('Member Check-in', 'Ali Mohammad checked in', '2h ago', Icons.login, const Color(0xFF4CAF50)),
            _buildActivityItem('New Order', 'Order #1234 - \$150', '3h ago', Icons.shopping_cart, const Color(0xFFFF9800)),
            _buildActivityItem('Payment Received', 'Reza Ahmadi - \$500', '5h ago', Icons.payment, const Color(0xFF9C27B0)),
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
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search members...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        // Filter Chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: true,
                onSelected: (v) {},
                selectedColor: const Color(0xFF1B5E20),
                checkmarkColor: Colors.white,
                labelStyle: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8),
              FilterChip(label: const Text('Active'), selected: false, onSelected: (v) {}),
              const SizedBox(width: 8),
              FilterChip(label: const Text('Expired'), selected: false, onSelected: (v) {}),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Member List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            itemBuilder: (context, index) => _buildMemberCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildMemberCard(int index) {
    final members = [
      {'name': 'Ali Mohammad', 'phone': '09121234567', 'status': 'Active', 'expiry': '2024/08/15'},
      {'name': 'Reza Ahmadi', 'phone': '09129876543', 'status': 'Active', 'expiry': '2024/10/20'},
      {'name': 'Sara Karimi', 'phone': '09125554433', 'status': 'Expiring', 'expiry': '2024/07/25'},
      {'name': 'Mohammad Hosseini', 'phone': '09121112233', 'status': 'Expired', 'expiry': '2024/07/05'},
      {'name': 'Zahra Abbasi', 'phone': '09123334455', 'status': 'Active', 'expiry': '2025/01/01'},
    ];
    
    final member = members[index % members.length];
    final isExpired = member['status'] == 'Expired';
    final isExpiring = member['status'] == 'Expiring';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isExpired ? Colors.red : (isExpiring ? Colors.orange : const Color(0xFF1B5E20)),
          child: Text(member['name']![0], style: const TextStyle(color: Colors.white)),
        ),
        title: Text(member['name']!, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('Expires: ${member['expiry']}'),
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
            SnackBar(content: Text('Viewing ${member['name']}')),
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
          const Text('Exercise Library', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildExerciseCategory('Chest', Icons.fitness_center, const Color(0xFF2196F3)),
                _buildExerciseCategory('Back', Icons.accessibility_new, const Color(0xFF4CAF50)),
                _buildExerciseCategory('Legs', Icons.directions_run, const Color(0xFFFF9800)),
                _buildExerciseCategory('Arms', Icons.sports_martial_arts, const Color(0xFF9C27B0)),
                _buildExerciseCategory('Core', Icons.self_improvement, const Color(0xFF009688)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Workout Programs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildProgramCard('Strength Training', '4 weeks', '3 days/week', const Color(0xFF2196F3)),
          _buildProgramCard('Weight Loss', '8 weeks', '5 days/week', const Color(0xFF4CAF50)),
          _buildProgramCard('Muscle Building', '12 weeks', '4 days/week', const Color(0xFFFF9800)),
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
          const Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
            children: [
              _buildProductCard('Protein Shake', '\$150,000', 'In Stock', const Color(0xFF4CAF50)),
              _buildProductCard('Water', '\$10,000', 'In Stock', const Color(0xFF2196F3)),
              _buildProductCard('Banana', '\$25,000', 'Low Stock', const Color(0xFFFF9800)),
              _buildProductCard('Energy Bar', '\$85,000', 'Out of Stock', const Color(0xFFF44336)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Recent Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildOrderCard('#1234', 'Ali Mohammad', '\$150,000', 'Completed'),
          _buildOrderCard('#1235', 'Guest', '\$45,000', 'Pending'),
          _buildOrderCard('#1236', 'Reza Ahmadi', '\$220,000', 'Preparing'),
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
      case 'Completed':
        statusColor = const Color(0xFF4CAF50);
        break;
      case 'Pending':
        statusColor = const Color(0xFFFF9800);
        break;
      default:
        statusColor = const Color(0xFF2196F3);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('Order $id', style: const TextStyle(fontWeight: FontWeight.w500)),
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
          const Text('Financial Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Income', '+\$15,000,000', const Color(0xFF4CAF50))),
              const SizedBox(width: 12),
              Expanded(child: _buildSummaryCard('Expenses', '-\$8,000,000', const Color(0xFFF44336))),
            ],
          ),
          const SizedBox(height: 8),
          _buildSummaryCard('Net Profit', '+\$7,000,000', const Color(0xFF2196F3)),
          const SizedBox(height: 20),
          const Text('Report Types', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildReportOption('Daily Report', Icons.calendar_today, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating daily report...')));
          }),
          _buildReportOption('Monthly Report', Icons.calendar_month, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating monthly report...')));
          }),
          _buildReportOption('Member Report', Icons.people, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating member report...')));
          }),
          _buildReportOption('Attendance Report', Icons.how_to_reg, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Generating attendance report...')));
          }),
          _buildReportOption('Export to PDF', Icons.picture_as_pdf, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting to PDF...')));
          }),
          _buildReportOption('Export to Excel', Icons.table_chart, () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting to Excel...')));
          }),
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
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1B5E20)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_left),
        onTap: onTap,
      ),
    );
  }
}