import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazirmatn/vazirmatn.dart';
import 'di/injection_container.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';
import 'presentation/cubits/theme_cubit.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/member/member_bloc.dart';
import 'presentation/blocs/attendance/attendance_bloc.dart';
import 'presentation/blocs/accounting/accounting_bloc.dart';
import 'presentation/blocs/dashboard/dashboard_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize dependency injection
  await DependencyInjector().initialize();

  runApp(const GymBuffetManagerApp());
}

class GymBuffetManagerApp extends StatelessWidget {
  const GymBuffetManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider<MemberBloc>(
          create: (context) => getIt<MemberBloc>(),
        ),
        BlocProvider<AttendanceBloc>(
          create: (context) => getIt<AttendanceBloc>(),
        ),
        BlocProvider<AccountingBloc>(
          create: (context) => getIt<AccountingBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => getIt<DashboardBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'مدیریت باشگاه و بوفه',
            debugShowCheckedModeBanner: false,
            
            // RTL Support
            locale: const Locale('fa', 'IR'),
            supportedLocales: const [
              Locale('fa', 'IR'),
              Locale('en', 'US'),
            ],
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            
            // Navigation
            routerConfig: getIt<AppRouter>().router,
          );
        },
      ),
    );
  }
}