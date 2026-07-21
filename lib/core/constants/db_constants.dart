class DbConstants {
  DbConstants._();

  // Table Names
  static const String membersTable = 'members';
  static const String memberProfilesTable = 'member_profiles';
  static const String memberHealthTable = 'member_health';
  static const String workoutProgramsTable = 'workout_programs';
  static const String exercisesTable = 'exercises';
  static const String workoutSessionsTable = 'workout_sessions';
  static const String exerciseLogsTable = 'exercise_logs';
  static const String trainersTable = 'trainers';
  static const String trainerSchedulesTable = 'trainer_schedules';
  static const String productsTable = 'products';
  static const String categoriesTable = 'categories';
  static const String ordersTable = 'orders';
  static const String orderItemsTable = 'order_items';
  static const String inventoryTable = 'inventory';
  static const String paymentsTable = 'payments';
  static const String transactionsTable = 'transactions';
  static const String expensesTable = 'expenses';
  static const String invoicesTable = 'invoices';
  static const String attendanceTable = 'attendance';
  static const String staffTable = 'staff';

  // Common Columns
  static const String idColumn = 'id';
  static const String createdAtColumn = 'created_at';
  static const String updatedAtColumn = 'updated_at';
  static const String isActiveColumn = 'is_active';

  // Member Columns
  static const String firstNameColumn = 'first_name';
  static const String lastNameColumn = 'last_name';
  static const String emailColumn = 'email';
  static const String phoneColumn = 'phone';
  static const String dateOfBirthColumn = 'date_of_birth';
  static const String genderColumn = 'gender';
  static const String addressColumn = 'address';
  static const String emergencyContactColumn = 'emergency_contact';
  static const String photoPathColumn = 'photo_path';

  // Membership Columns
  static const String membershipTypeColumn = 'membership_type';
  static const String membershipStartDateColumn = 'membership_start_date';
  static const String membershipEndDateColumn = 'membership_end_date';
  static const String membershipStatusColumn = 'membership_status';

  // Payment Columns
  static const String amountColumn = 'amount';
  static const String paymentMethodColumn = 'payment_method';
  static const String paymentDateColumn = 'payment_date';
  static const String paymentStatusColumn = 'payment_status';
  static const String referenceColumn = 'reference';

  // Order Columns
  static const String orderNumberColumn = 'order_number';
  static const String totalAmountColumn = 'total_amount';
  static const String orderStatusColumn = 'order_status';

  // Attendance Columns
  static const String checkInTimeColumn = 'check_in_time';
  static const String checkOutTimeColumn = 'check_out_time';

  // Staff Columns
  static const String roleColumn = 'role';
  static const String salaryColumn = 'salary';
  static const String usernameColumn = 'username';
  static const String passwordHashColumn = 'password_hash';
}