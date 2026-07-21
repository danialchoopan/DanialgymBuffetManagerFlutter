import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_buffet_manager/presentation/widgets/common/custom_widgets.dart';
import 'package:gym_buffet_manager/core/themes/colors.dart';

void main() {
  group('CustomButton', () {
    testWidgets('should render primary button with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'ذخیره',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('ذخیره'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should render outlined button when isOutlined is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'لغو',
              onPressed: () {},
              isOutlined: true,
            ),
          ),
        ),
      );

      expect(find.text('لغو'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('should show loading indicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'ذخیره',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render button with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'افزودن',
              onPressed: () {},
              icon: Icons.add,
            ),
          ),
        ),
      );

      expect(find.text('افزودن'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'کلیک',
              onPressed: () => wasPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('کلیک'));
      expect(wasPressed, isTrue);
    });

    testWidgets('should not call onPressed when isLoading', (tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'ذخیره',
              onPressed: () => wasPressed = true,
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('ذخیره'));
      expect(wasPressed, isFalse);
    });
  });

  group('CustomTextField', () {
    testWidgets('should render text field with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'نام',
            ),
          ),
        ),
      );

      expect(find.text('نام'), findsOneWidget);
    });

    testWidgets('should render text field with hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'نام',
              hint: 'نام خود را وارد کنید',
            ),
          ),
        ),
      );

      expect(find.text('نام خود را وارد کنید'), findsOneWidget);
    });

    testWidgets('should show prefix icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'تلفن',
              prefixIcon: Icons.phone,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.phone), findsOneWidget);
    });

    testWidgets('should show suffix icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'رمز عبور',
              obscureText: true,
              suffixIcon: Icons.visibility,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should accept user input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              label: 'نام',
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'علی');
      expect(controller.text, equals('علی'));
    });
  });

  group('CustomCard', () {
    testWidgets('should render card with child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCard(
              onTap: () => wasTapped = true,
              child: Text('کلیک'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CustomCard));
      expect(wasTapped, isTrue);
    });
  });

  group('StatCard', () {
    testWidgets('should render stat card with title and value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'اعضا',
              value: '256',
              icon: Icons.people,
              color: AppColors.primary,
            ),
          ),
        ),
      );

      expect(find.text('256'), findsOneWidget);
      expect(find.text('اعضا'), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
    });

    testWidgets('should show change indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'اعضا',
              value: '256',
              icon: Icons.people,
              color: AppColors.primary,
              change: '+12%',
              isPositiveChange: true,
            ),
          ),
        ),
      );

      expect(find.text('+12%'), findsOneWidget);
    });
  });

  group('StatusBadge', () {
    testWidgets('should render badge with text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatusBadge(
              text: 'فعال',
              backgroundColor: AppColors.success,
            ),
          ),
        ),
      );

      expect(find.text('فعال'), findsOneWidget);
    });

    testWidgets('should render badge with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatusBadge(
              text: 'پرداخت شده',
              backgroundColor: AppColors.success,
              icon: Icons.check_circle,
            ),
          ),
        ),
      );

      expect(find.text('پرداخت شده'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });

  group('EmptyState', () {
    testWidgets('should render empty state with title and message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.people_outline,
              title: 'هیچ عضوی یافت نشد',
              message: 'اولین عضو خود را اضافه کنید',
            ),
          ),
        ),
      );

      expect(find.text('هیچ عضوی یافت نشد'), findsOneWidget);
      expect(find.text('اولین عضو خود را اضافه کنید'), findsOneWidget);
      expect(find.byIcon(Icons.people_outline), findsOneWidget);
    });

    testWidgets('should show button when buttonText is provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.people_outline,
              title: 'هیچ عضوی یافت نشد',
              message: 'اولین عضو خود را اضافه کنید',
              buttonText: 'افزودن عضو',
              onButtonPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('افزودن عضو'), findsOneWidget);
    });
  });

  group('LoadingOverlay', () {
    testWidgets('should show child when not loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: false,
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.text('محتوا'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show loading when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingOverlay(
              isLoading: true,
              message: 'در حال بارگذاری...',
              child: Text('محتوا'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('در حال بارگذاری...'), findsOneWidget);
    });
  });

  group('SectionHeader', () {
    testWidgets('should render section header with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'اطلاعات شخصی',
            ),
          ),
        ),
      );

      expect(find.text('اطلاعات شخصی'), findsOneWidget);
    });

    testWidgets('should render section header with subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'اطلاعات شخصی',
              subtitle: 'اطلاعات پایه عضو',
            ),
          ),
        ),
      );

      expect(find.text('اطلاعات پایه عضو'), findsOneWidget);
    });

    testWidgets('should render action widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'پرداخت‌ها',
              action: TextButton(
                onPressed: () {},
                child: Text('مشاهده همه'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('مشاهده همه'), findsOneWidget);
    });
  });

  group('CustomListTile', () {
    testWidgets('should render list tile with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'تنظیمات',
            ),
          ),
        ),
      );

      expect(find.text('تنظیمات'), findsOneWidget);
    });

    testWidgets('should render list tile with subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'تنظیمات',
              subtitle: 'تنظیمات برنامه',
            ),
          ),
        ),
      );

      expect(find.text('تنظیمات برنامه'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListTile(
              title: 'تنظیمات',
              onTap: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('تنظیمات'));
      expect(wasTapped, isTrue);
    });
  });

  group('CustomAppBar', () {
    testWidgets('should render app bar with title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'داشبورد',
            ),
          ),
        ),
      );

      expect(find.text('داشبورد'), findsOneWidget);
    });

    testWidgets('should show back button by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'صفحه',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('should hide back button when showBackButton is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'داشبورد',
              showBackButton: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsNothing);
    });
  });
}