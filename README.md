# Gym Buffet Manager - پکیج مدیریت باشگاه و بوفه

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.16.0-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.2.0-0175C2?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)

**سیستم جامع مدیریت باشگاه بدنسازی و بوفه**

</div>

---

## 📱 ویژگی‌های اصلی

### مدیریت اعضا
- ثبت‌نام و مدیریت پروفایل اعضا
- پیگیری وضعیت عضویت (فعال/منقضی/تعلیق)
- تاریخچه پرداخت و مانده حساب
- تاریخچه حضور و غیاب
- گزارش‌گیری و خروجی گرفتن

### مدیریت تمرینات
- کتابخانه تمرینات با دسته‌بندی
- برنامه‌های تمرینی شخصی‌سازی شده
- ثبت تمرینات اعضا
- پیگیری پیشرفت با نمودار
- محاسبه یک تکرار بیشینه

### حضور و غیاب
- ثبت ورود و خروج (دستی/QR)
- تاریخچه حضور
- گزارش ساعت‌های پیک
- ظرفیت‌سنجی سالن

### مدیریت بوفه
- مدیریت محصولات و موجودی
- ثبت سفارش و پیگیری وضعیت
- سبد خرید
- چاپ فاکتور
- هشدار کم بودن موجودی

### حسابداری
- ثبت درآمد و هزینه
- مدیریت فاکتورها
- پیگیری پرداخت‌های معوق
- گزارش‌های مالی روزانه/ماهانه/سالانه
- صورت سود و زیان

### داشبورد و تحلیل
- آمار لحظه‌ای
- نمودارها و تجسم داده‌ها
- فعالیت‌های اخیر
- هشدارها و اعلان‌ها

---

## 🛠️ فناوری‌های استفاده شده

| فناوری | کاربرد |
|--------|--------|
| Flutter 3.16 | فریمورک UI |
| Dart 3.2 | زبان برنامه‌نویسی |
| Floor | ORM پایگاه داده SQLite |
| Hive | ذخیره‌سازی محلی |
| BLoC | مدیریت State |
| Go Router | مسیریابی |
| GetIt | Dependency Injection |
| PDF | تولید PDF |
| fl_chart | نمودارها |

---

## 📁 ساختار پروژه

```
lib/
├── core/                    # هسته برنامه
│   ├── business/           # قوانین تجاری
│   ├── constants/          # ثابت‌ها
│   ├── database/           # پایگاه داده
│   ├── errors/             # مدیریت خطاها
│   ├── reports/            # سیستم گزارش‌گیری
│   ├── routes/             # مسیریابی
│   ├── security/           # امنیت
│   ├── services/           # سرویس‌ها
│   ├── themes/             # تم و استایل
│   └── utils/              # ابزارها
├── data/                   # لایه داده
│   ├── datasources/        # منابع داده
│   ├── mappers/            # تبدیل مدل‌ها
│   ├── models/             # مدل‌های داده
│   └── repositories_impl/  # پیاده‌سازی Repository
├── di/                     # Dependency Injection
├── domain/                 # لایه دامنه
│   ├── entities/           # موجودیت‌ها
│   ├── errors/             # خطاهای دامنه
│   ├── repositories/       # رابط‌های Repository
│   └── usecases/           # Use Cases
└── presentation/           # لایه نمایش
    ├── blocs/              # BLoC ها
    ├── cubits/             # Cubit ها
    ├── pages/              # صفحات
    └── widgets/            # ویجت‌ها
```

---

## 🚀 نصب و راه‌اندازی

### پیش‌نیازها
- Flutter SDK 3.16+
- Dart SDK 3.2+
- Android Studio یا VS Code
- Android SDK 21+

### مراحل نصب

```bash
# کلون کردن پروژه
git clone https://github.com/your-repo/gym_buffet_manager.git

# ورود به پوشه پروژه
cd gym_buffet_manager

# نصب وابستگی‌ها
flutter pub get

# اجرای برنامه
flutter run
```

### ساخت APK

```bash
# ساخت APK
flutter build apk --release

# ساخت App Bundle
flutter build appbundle --release
```

---

## 📊 تست‌ها

```bash
# اجرای تمام تست‌ها
flutter test

# اجرای تست‌ها با coverage
flutter test --coverage

# اجرای تست‌های خاص
flutter test test/unit/
flutter test test/widget/
flutter test test/blocs/
```

---

## 📦 ساختار پایگاه داده

### جداول اصلی
- `members` - اطلاعات اعضا
- `member_payments` - پرداخت‌های اعضا
- `member_health` - سوابق سلامت
- `workout_programs` - برنامه‌های تمرینی
- `exercises` - کتابخانه تمرینات
- `workout_logs` - سوابق تمرین
- `trainers` - مربیان
- `products` - محصولات بوفه
- `orders` - سفارشات
- `transactions` - تراکنش‌های مالی
- `attendance` - حضور و غیاب
- `staff` - کارکنان

---

## 🔐 امنیت

- رمزگذاری پایگاه داده
- هش رمز عبور با Argon2
- احراز هویت بیومتریک
- کنترل دسترسی بر اساس نقش
- گزارش حسابرسی

---

## 📱 نسخه‌های پشتیبانی شده

| پلتفرم | حداقل نسخه |
|---------|------------|
| Android | 5.0 (API 21) |
| iOS | 12.0 |
| Windows | 10 |
| Linux | Ubuntu 20.04 |

---

## 📄 مستندات

- [راهنمای استقرار](DEPLOYMENT.md)
- [تاریخچه تغییرات](CHANGELOG.md)
- [قانون مجوز](LICENSE)

---

## 🤝 مشارکت

برای مشارکت در پروژه:
1. Fork کنید
2. Branch جدید بسازید (`git checkout -b feature/amazing-feature`)
3. تغییرات را commit کنید (`git commit -m 'Add amazing feature'`)
4. Push کنید (`git push origin feature/amazing-feature`)
5. Pull Request ایجاد کنید

---

## 📞 پشتیبانی

- ایمیل: support@example.com
- واتساپ: گروه پشتیبانی
- GitHub Issues: [لینک]

---

## 📜 مجوز

این پروژه تحت مجوز MIT منتشر شده است. See [LICENSE](LICENSE) for details.

---

<div align="center">

**ساخته شده با ❤️ برای باشگاه‌های بدنسازی ایران**

</div>