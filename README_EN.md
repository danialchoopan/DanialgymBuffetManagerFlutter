# 🏋️ Gym & Buffet Manager

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.16-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2-0175C2?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android)

**Complete Gym & Buffet Management System - Fully Offline**

</div>

---

## 📱 About the App

**Gym & Buffet Manager** is a comprehensive and professional application for managing fitness gyms. This app works **completely offline** without any internet dependency.

### ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🔒 **High Security** | Database encryption, biometric authentication |
| 📱 **Fully Offline** | No internet required |
| 🎨 **Beautiful UI** | Modern design with RTL support |
| 📊 **Advanced Reporting** | Daily, monthly, and yearly reports |
| 💰 **Complete Accounting** | Track income, expenses, and profit |
| 🍽️ **Buffet Management** | Manage products and orders |

---

## 🎯 Core Modules

### 👥 Member Management
- Member registration and profile management
- Membership tracking (Active/Expired/Suspended)
- Payment history and outstanding balance
- Health records and measurements
- Member progress charts

### 🏋️ Workout & Training
- Comprehensive exercise library with categories
- Personalized workout programs
- Exercise logging and tracking
- Progress tracking with charts
- One-rep max (1RM) calculation

### ✅ Attendance Tracking
- Check-in/Check-out (Manual/QR)
- Attendance history
- Peak hours reporting
- Gym capacity monitoring
- Auto-checkout at closing time

### 🍽️ Buffet Management
- Product catalog with categories
- Order creation and tracking
- Shopping cart
- Inventory management with low stock alerts
- Bill printing

### 💵 Accounting
- Income/Expense tracking
- Invoice management
- Overdue payment tracking
- Daily/Monthly/Yearly financial reports
- Profit & Loss statements

### 📊 Dashboard & Analytics
- Real-time statistics
- Charts and data visualization
- Recent activity feed
- Alerts and notifications

---

## 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.16** | Main framework |
| **Dart 3.2** | Programming language |
| **Vazirmatn** | Persian font |
| **Floor** | SQLite ORM |
| **Hive** | Local storage |
| **BLoC** | State management |
| **GoRouter** | Navigation |
| **GetIt** | Dependency Injection |
| **PDF** | PDF generation |
| **fl_chart** | Charts |

---

## 📁 Project Structure

```
lib/
├── core/                    # Core infrastructure
│   ├── business/           # Business rules
│   ├── constants/          # Constants
│   ├── database/           # Database
│   ├── errors/             # Error handling
│   ├── reports/            # Reporting system
│   ├── routes/             # Navigation
│   ├── security/           # Security
│   ├── services/           # Services
│   ├── themes/             # Themes & styles
│   └── utils/              # Utilities
├── data/                   # Data layer
│   ├── datasources/        # Data sources
│   ├── mappers/            # Data mappers
│   ├── models/             # Data models
│   └── repositories_impl/  # Repository implementations
├── di/                     # Dependency Injection
├── domain/                 # Domain layer
│   ├── entities/           # Entities
│   ├── errors/             # Domain errors
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Use cases
└── presentation/           # Presentation layer
    ├── blocs/              # BLoCs
    ├── cubits/             # Cubits
    ├── pages/              # Pages
    └── widgets/            # Widgets
```

---

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK 3.16+
- Dart SDK 3.2+
- Android Studio or VS Code
- Android SDK 21+ (Android 5.0+)

### Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-username/gym_buffet_manager.git

# 2. Navigate to project directory
cd gym_buffet_manager

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Building APK

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release
```

---

## 📊 Database Schema

### Core Tables

| Table | Description |
|-------|-------------|
| `members` | Member profiles |
| `member_payments` | Member payments |
| `member_health` | Health records |
| `attendance` | Attendance tracking |
| `exercises` | Exercise library |
| `workout_programs` | Workout programs |
| `products` | Buffet products |
| `orders` | Orders |
| `transactions` | Financial transactions |
| `invoices` | Invoices |

---

## 🔐 Security Features

- ✅ Database encryption
- ✅ Password hashing with Argon2
- ✅ Biometric authentication (Fingerprint/Face ID)
- ✅ Role-based access control
- ✅ Audit logging
- ✅ Auto-lock app

---

## 📱 Supported Platforms

| Platform | Minimum Version | Status |
|----------|-----------------|--------|
| Android | 5.0 (API 21) | ✅ Primary |
| iOS | 12.0+ | 🔜 Future |
| Windows | 10 | 🔜 Future |
| Linux | Ubuntu 20.04 | 🔜 Future |

---

## 📄 Documentation

- [Deployment Guide](DEPLOYMENT.md)
- [Changelog](CHANGELOG.md)
- [Implementation Guide](IMPLEMENTATION_GUIDE.md)
- [Project Summary](PROJECT_SUMMARY.md)

---

## 🤝 Contributing

To contribute to this project:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📞 Support

- 📧 Email: support@example.com
- 💬 WhatsApp: Support Group
- 🐛 Issues: [GitHub Issues](https://github.com/your-username/gym_buffet_manager/issues)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Flutter Team
- Vazirmatn developers
- Iranian open-source community

---

<div align="center">

**Made with ❤️ for Iranian Fitness Gyms**

⭐ If this project was helpful, please give it a star!

</div>