import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MembersPage(),
    const WorkoutsPage(),
    const BuffetPage(),
    const ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym & Buffet Manager'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        selectedItemColor: const Color(0xFF1B5E20),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Buffet'),
          BottomNavigationBarItem(icon: Icon(Icons.assessment), label: 'Reports'),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD PAGE
// ============================================================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back!', style: GoogleFonts.vazirmatn(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Dashboard', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  const Icon(Icons.fitness_center, size: 40, color: Color(0xFF1B5E20)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Stats
          Text('Quick Stats', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _statCard('Total Members', '1,250', Icons.people, Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _statCard('Active', '980', Icons.check_circle, Colors.green)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _statCard("Today's Attendance", '125', Icons.how_to_reg, Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _statCard("Today's Revenue", '\$5,200', Icons.attach_money, Colors.purple)),
            ],
          ),
          const SizedBox(height: 16),

          // Quick Actions
          Text('Quick Actions', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _actionButton(context, 'Add Member', Icons.person_add, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMemberPage())))),
              const SizedBox(width: 8),
              Expanded(child: _actionButton(context, 'Check-in', Icons.login, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckInPage())))),
              const SizedBox(width: 8),
              Expanded(child: _actionButton(context, 'New Order', Icons.shopping_cart, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewOrderPage())))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _actionButton(context, 'Payment', Icons.payment, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentPage())))),
              const SizedBox(width: 8),
              Expanded(child: _actionButton(context, 'Reports', Icons.assessment, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsPage())))),
              const SizedBox(width: 8),
              Expanded(child: _actionButton(context, 'Settings', Icons.settings, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())))),
            ],
          ),
          const SizedBox(height: 16),

          // Recent Activity
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Activity', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _activityItem('Member Check-in', 'Ali Mohammad', '2h ago', Colors.green),
                  _activityItem('New Order', 'Order #1234 - \$150', '3h ago', Colors.orange),
                  _activityItem('Payment', 'Reza Ahmadi - \$500', '5h ago', Colors.purple),
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
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF1B5E20), size: 28),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityItem(String title, String subtitle, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

// ============================================================
// MEMBERS PAGE
// ============================================================

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search members...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) {
              final members = [
                {'name': 'Ali Mohammad', 'status': 'Active', 'color': Colors.green},
                {'name': 'Reza Ahmadi', 'status': 'Active', 'color': Colors.green},
                {'name': 'Sara Karimi', 'status': 'Expired', 'color': Colors.red},
                {'name': 'Mohammad Hosseini', 'status': 'Pending', 'color': Colors.orange},
                {'name': 'Zahra Abbasi', 'status': 'Active', 'color': Colors.green},
              ];
              final m = members[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: m['color'] as Color,
                    child: Text('${(m['name'] as String)[0]}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(m['name'] as String),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: m['color'] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(m['status'] as String, style: const TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Viewing ${m['name']}')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ============================================================
// WORKOUTS PAGE
// ============================================================

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Workout Programs', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _programCard('Strength Training', '4 weeks, 3 days/week', Colors.blue),
        _programCard('Weight Loss', '8 weeks, 5 days/week', Colors.green),
        _programCard('Muscle Building', '12 weeks, 4 days/week', Colors.orange),
      ],
    );
  }

  Widget _programCard(String name, String details, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(Icons.fitness_center, color: color),
        title: Text(name),
        subtitle: Text(details),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

// ============================================================
// BUFFET PAGE
// ============================================================

class BuffetPage extends StatelessWidget {
  const BuffetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Products', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _productCard('Protein Shake', '\$150,000', 'In Stock', Colors.green),
        _productCard('Water', '\$10,000', 'In Stock', Colors.blue),
        _productCard('Banana', '\$25,000', 'Low Stock', Colors.orange),
        _productCard('Energy Bar', '\$85,000', 'Out of Stock', Colors.red),
      ],
    );
  }

  Widget _productCard(String name, String price, String stock, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.restaurant),
        title: Text(name),
        subtitle: Text(price),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(stock, style: TextStyle(color: color, fontSize: 11)),
        ),
      ),
    );
  }
}

// ============================================================
// REPORTS PAGE
// ============================================================

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Reports', style: GoogleFonts.vazirmatn(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _reportCard('Daily Report', Icons.calendar_today, Colors.blue),
        _reportCard('Monthly Report', Icons.calendar_month, Colors.green),
        _reportCard('Member Report', Icons.people, Colors.orange),
        _reportCard('Financial Report', Icons.account_balance, Colors.purple),
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
        onTap: () {},
      ),
    );
  }
}

// ============================================================
// SUB PAGES (Functional)
// ============================================================

class AddMemberPage extends StatelessWidget {
  const AddMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Member')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Phone', border: OutlineInputBorder()), keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()), keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Member added!')));
                  Navigator.pop(context);
                },
                child: const Text('Save Member', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100, color: Color(0xFF1B5E20)),
            const SizedBox(height: 24),
            const Text('Scan QR Code', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check-in recorded!')));
                Navigator.pop(context);
              },
              child: const Text('Manual Check-in', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Order')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _productTile('Protein Shake', '\$150,000'),
          _productTile('Water', '\$10,000'),
          _productTile('Banana', '\$25,000'),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$185,000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed!')));
                        Navigator.pop(context);
                      },
                      child: const Text('Place Order', style: TextStyle(color: Colors.white)),
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

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
          const SizedBox(height: 12),
          const Text('Payment Method'),
          RadioListTile(title: const Text('Cash'), value: 1, groupValue: 1, onChanged: (v) {}),
          RadioListTile(title: const Text('Card'), value: 2, groupValue: 1, onChanged: (v) {}),
          RadioListTile(title: const Text('Transfer'), value: 3, groupValue: 1, onChanged: (v) {}),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B5E20)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment recorded!')));
                Navigator.pop(context);
              },
              child: const Text('Complete Payment', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(leading: const Icon(Icons.business), title: const Text('Gym Info'), trailing: const Icon(Icons.chevron_left), onTap: () {}),
          ListTile(leading: const Icon(Icons.people), title: const Text('User Management'), trailing: const Icon(Icons.chevron_left), onTap: () {}),
          ListTile(leading: const Icon(Icons.backup), title: const Text('Backup'), trailing: const Icon(Icons.chevron_left), onTap: () {}),
          ListTile(leading: const Icon(Icons.info), title: const Text('About'), trailing: const Icon(Icons.chevron_left), onTap: () {}),
        ],
      ),
    );
  }
}