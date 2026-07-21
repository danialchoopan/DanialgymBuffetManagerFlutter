import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:floor/floor.dart';

// Core
import '../core/errors/error_handler.dart';
import '../core/database/database_manager.dart';
import '../core/security/biometric_helper.dart';
import '../core/security/encryption_helper.dart';
import '../core/services/notification_service.dart';
import '../core/services/backup_service.dart';
import '../core/services/print_service.dart';
import '../core/services/export_service.dart';
import '../core/routes/app_router.dart';
import '../core/routes/route_guards.dart';

// Data
import '../data/datasources/local/member_local_datasource.dart';
import '../data/repositories_impl/member_repository_impl.dart';

// Domain
import '../domain/repositories/member_repository.dart';

// Presentation
import '../presentation/blocs/auth/auth_bloc.dart';
import '../presentation/blocs/member/member_bloc.dart';
import '../presentation/cubits/theme_cubit.dart';
import '../presentation/cubits/session_cubit.dart';

final getIt = GetIt.instance;

class DependencyInjector {
  static final DependencyInjector _instance = DependencyInjector._();
  factory DependencyInjector() => _instance;
  DependencyInjector._();

  Future<void> initialize() async {
    await _initializeCore();
    await _initializeDatabase();
    await _initializeExternalServices();
    await _initializeDataSources();
    await _initializeRepositories();
    await _initializeUseCases();
    await _initializeBlocs();
  }

  Future<void> _initializeCore() async {
    // Error Handler
    getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler());

    // Security
    getIt.registerLazySingleton<BiometricHelper>(() => BiometricHelper());
    getIt.registerLazySingleton<EncryptionHelper>(() => EncryptionHelper());

    // Services
    getIt.registerLazySingleton<NotificationService>(() => NotificationService());
    getIt.registerLazySingleton<BackupService>(() => BackupService());
    getIt.registerLazySingleton<PrintService>(() => PrintService());
    getIt.registerLazySingleton<ExportService>(() => ExportService());

    // Router
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
    getIt.registerLazySingleton<RouteGuards>(() => RouteGuards());
  }

  Future<void> _initializeDatabase() async {
    // Hive initialization
    await Hive.initFlutter();
    await Hive.openBox('settings');
    await Hive.openBox('cache');
    await Hive.openBox('auth');

    // Floor database initialization
    final database = await $FloorAppDatabase.databaseBuilder('gym_buffet_database.db').build();
    getIt.registerSingleton<AppDatabase>(database);
  }

  Future<void> _initializeExternalServices() async {
    // Initialize notification service
    await getIt<NotificationService>().initialize();
  }

  Future<void> _initializeDataSources() async {
    final database = getIt<AppDatabase>();

    getIt.registerLazySingleton<MemberLocalDatasource>(
      () => MemberLocalDatasource(database),
    );

    // TODO: Register other datasources
    // getIt.registerLazySingleton<WorkoutLocalDatasource>(
    //   () => WorkoutLocalDatasource(database),
    // );
    // getIt.registerLazySingleton<BuffetLocalDatasource>(
    //   () => BuffetLocalDatasource(database),
    // );
    // getIt.registerLazySingleton<AccountingLocalDatasource>(
    //   () => AccountingLocalDatasource(database),
    // );
    // getIt.registerLazySingleton<AttendanceLocalDatasource>(
    //   () => AttendanceLocalDatasource(database),
    // );
  }

  Future<void> _initializeRepositories() async {
    getIt.registerLazySingleton<MemberRepository>(
      () => MemberRepositoryImpl(
        localDatasource: getIt<MemberLocalDatasource>(),
        errorHandler: getIt<ErrorHandler>(),
      ),
    );

    // TODO: Register other repositories
    // getIt.registerLazySingleton<WorkoutRepository>(
    //   () => WorkoutRepositoryImpl(
    //     localDatasource: getIt<WorkoutLocalDatasource>(),
    //     errorHandler: getIt<ErrorHandler>(),
    //   ),
    // );
    // getIt.registerLazySingleton<BuffetRepository>(
    //   () => BuffetRepositoryImpl(
    //     localDatasource: getIt<BuffetLocalDatasource>(),
    //     errorHandler: getIt<ErrorHandler>(),
    //   ),
    // );
    // getIt.registerLazySingleton<AccountingRepository>(
    //   () => AccountingRepositoryImpl(
    //     localDatasource: getIt<AccountingLocalDatasource>(),
    //     errorHandler: getIt<ErrorHandler>(),
    //   ),
    // );
    // getIt.registerLazySingleton<AttendanceRepository>(
    //   () => AttendanceRepositoryImpl(
    //     localDatasource: getIt<AttendanceLocalDatasource>(),
    //     errorHandler: getIt<ErrorHandler>(),
    //   ),
    // );
  }

  Future<void> _initializeUseCases() async {
    // TODO: Register use cases
    // getIt.registerLazySingleton<AddMemberUseCase>(
    //   () => AddMemberUseCase(getIt<MemberRepository>()),
    // );
  }

  Future<void> _initializeBlocs() async {
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(),
    );

    getIt.registerFactory<MemberBloc>(
      () => MemberBloc(memberRepository: getIt<MemberRepository>()),
    );

    // Cubits
    getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
    getIt.registerFactory<SessionCubit>(() => SessionCubit());

    // TODO: Register other blocs
    // getIt.registerFactory<WorkoutBloc>(
    //   () => WorkoutBloc(workoutRepository: getIt<WorkoutRepository>()),
    // );
    // getIt.registerFactory<BuffetBloc>(
    //   () => BuffetBloc(buffetRepository: getIt<BuffetRepository>()),
    // );
    // getIt.registerFactory<AccountingBloc>(
    //   () => AccountingBloc(accountingRepository: getIt<AccountingRepository>()),
    // );
    // getIt.registerFactory<AttendanceBloc>(
    //   () => AttendanceBloc(attendanceRepository: getIt<AttendanceRepository>()),
    // );
    // getIt.registerFactory<TrainerBloc>(
    //   () => TrainerBloc(trainerRepository: getIt<TrainerRepository>()),
    // );
    // getIt.registerFactory<DashboardBloc>(
    //   () => DashboardBloc(reportRepository: getIt<ReportRepository>()),
    // );
  }
}