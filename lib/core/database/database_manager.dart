import 'package:floor/floor.dart';

import 'entities/member/member_entity.dart';
import 'entities/member/member_profile_entity.dart';
import 'entities/member/member_health_entity.dart';
import 'entities/workout/workout_program_entity.dart';
import 'entities/workout/exercise_entity.dart';
import 'entities/workout/workout_session_entity.dart';
import 'entities/workout/exercise_log_entity.dart';
import 'entities/trainer/trainer_entity.dart';
import 'entities/trainer/trainer_schedule_entity.dart';
import 'entities/buffet/product_entity.dart';
import 'entities/buffet/category_entity.dart';
import 'entities/buffet/order_entity.dart';
import 'entities/buffet/order_item_entity.dart';
import 'entities/buffet/inventory_entity.dart';
import 'entities/accounting/payment_entity.dart';
import 'entities/accounting/transaction_entity.dart';
import 'entities/accounting/expense_entity.dart';
import 'entities/accounting/invoice_entity.dart';
import 'entities/attendance/attendance_entity.dart';
import 'entities/staff/staff_entity.dart';

part 'database_manager.g.dart';

@Database(
  version: 1,
  entities: [
    MemberEntity,
    MemberProfileEntity,
    MemberHealthEntity,
    WorkoutProgramEntity,
    ExerciseEntity,
    WorkoutSessionEntity,
    ExerciseLogEntity,
    TrainerEntity,
    TrainerScheduleEntity,
    ProductEntity,
    CategoryEntity,
    OrderEntity,
    OrderItemEntity,
    InventoryEntity,
    PaymentEntity,
    TransactionEntity,
    ExpenseEntity,
    InvoiceEntity,
    AttendanceEntity,
    StaffEntity,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  // Member DAOs
  MemberDao get memberDao;
  MemberProfileDao get memberProfileDao;
  MemberHealthDao get memberHealthDao;

  // Workout DAOs
  WorkoutProgramDao get workoutProgramDao;
  ExerciseDao get exerciseDao;
  WorkoutSessionDao get workoutSessionDao;
  ExerciseLogDao get exerciseLogDao;

  // Trainer DAOs
  TrainerDao get trainerDao;
  TrainerScheduleDao get trainerScheduleDao;

  // Buffet DAOs
  ProductDao get productDao;
  CategoryDao get categoryDao;
  OrderDao get orderDao;
  OrderItemDao get orderItemDao;
  InventoryDao get inventoryDao;

  // Accounting DAOs
  PaymentDao get paymentDao;
  TransactionDao get transactionDao;
  ExpenseDao get expenseDao;
  InvoiceDao get invoiceDao;

  // Attendance DAOs
  AttendanceDao get attendanceDao;

  // Staff DAOs
  StaffDao get staffDao;
}

// Member DAO
@dao
abstract class MemberDao {
  @Query('SELECT * FROM members WHERE is_active = 1 ORDER BY created_at DESC')
  Future<List<MemberEntity>> getAllMembers();

  @Query('SELECT * FROM members WHERE id = :id')
  Future<MemberEntity?> getMemberById(String id);

  @Query('SELECT * FROM members WHERE email = :email')
  Future<MemberEntity?> getMemberByEmail(String email);

  @Query('SELECT * FROM members WHERE phone = :phone')
  Future<MemberEntity?> getMemberByPhone(String phone);

  @Query('SELECT * FROM members WHERE membership_status = :status')
  Future<List<MemberEntity>> getMembersByStatus(String status);

  @Query('SELECT * FROM members WHERE first_name LIKE :query OR last_name LIKE :query OR email LIKE :query OR phone LIKE :query')
  Future<List<MemberEntity>> searchMembers(String query);

  @insert
  Future<void> insertMember(MemberEntity member);

  @update
  Future<void> updateMember(MemberEntity member);

  @delete
  Future<void> deleteMember(MemberEntity member);

  @Query('UPDATE members SET is_active = 0 WHERE id = :id')
  Future<void> softDeleteMember(String id);
}

// Member Profile DAO
@dao
abstract class MemberProfileDao {
  @Query('SELECT * FROM member_profiles WHERE member_id = :memberId')
  Future<MemberProfileEntity?> getProfileByMemberId(String memberId);

  @insert
  Future<void> insertProfile(MemberProfileEntity profile);

  @update
  Future<void> updateProfile(MemberProfileEntity profile);
}

// Member Health DAO
@dao
abstract class MemberHealthDao {
  @Query('SELECT * FROM member_health WHERE member_id = :memberId ORDER BY recorded_date DESC')
  Future<List<MemberHealthEntity>> getHealthByMemberId(String memberId);

  @insert
  Future<void> insertHealth(MemberHealthEntity health);

  @update
  Future<void> updateHealth(MemberHealthEntity health);
}

// Workout Program DAO
@dao
abstract class WorkoutProgramDao {
  @Query('SELECT * FROM workout_programs WHERE is_active = 1 ORDER BY created_at DESC')
  Future<List<WorkoutProgramEntity>> getAllPrograms();

  @Query('SELECT * FROM workout_programs WHERE id = :id')
  Future<WorkoutProgramEntity?> getProgramById(String id);

  @Query('SELECT * FROM workout_programs WHERE type = :type')
  Future<List<WorkoutProgramEntity>> getProgramsByType(String type);

  @Query('SELECT * FROM workout_programs WHERE difficulty_level = :level')
  Future<List<WorkoutProgramEntity>> getProgramsByDifficulty(String level);

  @insert
  Future<void> insertProgram(WorkoutProgramEntity program);

  @update
  Future<void> updateProgram(WorkoutProgramEntity program);

  @delete
  Future<void> deleteProgram(WorkoutProgramEntity program);
}

// Exercise DAO
@dao
abstract class ExerciseDao {
  @Query('SELECT * FROM exercises WHERE is_active = 1 ORDER BY name ASC')
  Future<List<ExerciseEntity>> getAllExercises();

  @Query('SELECT * FROM exercises WHERE id = :id')
  Future<ExerciseEntity?> getExerciseById(String id);

  @Query('SELECT * FROM exercises WHERE muscle_group = :muscleGroup')
  Future<List<ExerciseEntity>> getExercisesByMuscleGroup(String muscleGroup);

  @Query('SELECT * FROM exercises WHERE equipment = :equipment')
  Future<List<ExerciseEntity>> getExercisesByEquipment(String equipment);

  @Query('SELECT * FROM exercises WHERE name LIKE :query')
  Future<List<ExerciseEntity>> searchExercises(String query);

  @insert
  Future<void> insertExercise(ExerciseEntity exercise);

  @update
  Future<void> updateExercise(ExerciseEntity exercise);

  @delete
  Future<void> deleteExercise(ExerciseEntity exercise);
}

// Workout Session DAO
@dao
abstract class WorkoutSessionDao {
  @Query('SELECT * FROM workout_sessions WHERE member_id = :memberId ORDER BY scheduled_date DESC')
  Future<List<WorkoutSessionEntity>> getSessionsByMemberId(String memberId);

  @Query('SELECT * FROM workout_sessions WHERE trainer_id = :trainerId ORDER BY scheduled_date DESC')
  Future<List<WorkoutSessionEntity>> getSessionsByTrainerId(String trainerId);

  @Query('SELECT * FROM workout_sessions WHERE id = :id')
  Future<WorkoutSessionEntity?> getSessionById(String id);

  @insert
  Future<void> insertSession(WorkoutSessionEntity session);

  @update
  Future<void> updateSession(WorkoutSessionEntity session);

  @delete
  Future<void> deleteSession(WorkoutSessionEntity session);
}

// Exercise Log DAO
@dao
abstract class ExerciseLogDao {
  @Query('SELECT * FROM exercise_logs WHERE member_id = :memberId ORDER BY performed_date DESC')
  Future<List<ExerciseLogEntity>> getLogsByMemberId(String memberId);

  @Query('SELECT * FROM exercise_logs WHERE exercise_id = :exerciseId ORDER BY performed_date DESC')
  Future<List<ExerciseLogEntity>> getLogsByExerciseId(String exerciseId);

  @Query('SELECT * FROM exercise_logs WHERE session_id = :sessionId')
  Future<List<ExerciseLogEntity>> getLogsBySessionId(String sessionId);

  @insert
  Future<void> insertLog(ExerciseLogEntity log);

  @update
  Future<void> updateLog(ExerciseLogEntity log);
}

// Trainer DAO
@dao
abstract class TrainerDao {
  @Query('SELECT * FROM trainers WHERE is_active = 1 ORDER BY created_at DESC')
  Future<List<TrainerEntity>> getAllTrainers();

  @Query('SELECT * FROM trainers WHERE id = :id')
  Future<TrainerEntity?> getTrainerById(String id);

  @Query('SELECT * FROM trainers WHERE specialization = :specialization')
  Future<List<TrainerEntity>> getTrainersBySpecialization(String specialization);

  @insert
  Future<void> insertTrainer(TrainerEntity trainer);

  @update
  Future<void> updateTrainer(TrainerEntity trainer);

  @delete
  Future<void> deleteTrainer(TrainerEntity trainer);
}

// Trainer Schedule DAO
@dao
abstract class TrainerScheduleDao {
  @Query('SELECT * FROM trainer_schedules WHERE trainer_id = :trainerId ORDER BY day_of_week, start_time')
  Future<List<TrainerScheduleEntity>> getSchedulesByTrainerId(String trainerId);

  @Query('SELECT * FROM trainer_schedules WHERE day_of_week = :dayOfWeek')
  Future<List<TrainerScheduleEntity>> getSchedulesByDay(String dayOfWeek);

  @insert
  Future<void> insertSchedule(TrainerScheduleEntity schedule);

  @update
  Future<void> updateSchedule(TrainerScheduleEntity schedule);

  @delete
  Future<void> deleteSchedule(TrainerScheduleEntity schedule);
}

// Product DAO
@dao
abstract class ProductDao {
  @Query('SELECT * FROM products WHERE is_active = 1 ORDER BY name ASC')
  Future<List<ProductEntity>> getAllProducts();

  @Query('SELECT * FROM products WHERE id = :id')
  Future<ProductEntity?> getProductById(String id);

  @Query('SELECT * FROM products WHERE category_id = :categoryId')
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  @Query('SELECT * FROM products WHERE name LIKE :query')
  Future<List<ProductEntity>> searchProducts(String query);

  @insert
  Future<void> insertProduct(ProductEntity product);

  @update
  Future<void> updateProduct(ProductEntity product);

  @delete
  Future<void> deleteProduct(ProductEntity product);
}

// Category DAO
@dao
abstract class CategoryDao {
  @Query('SELECT * FROM categories WHERE is_active = 1 ORDER BY name ASC')
  Future<List<CategoryEntity>> getAllCategories();

  @Query('SELECT * FROM categories WHERE id = :id')
  Future<CategoryEntity?> getCategoryById(String id);

  @insert
  Future<void> insertCategory(CategoryEntity category);

  @update
  Future<void> updateCategory(CategoryEntity category);

  @delete
  Future<void> deleteCategory(CategoryEntity category);
}

// Order DAO
@dao
abstract class OrderDao {
  @Query('SELECT * FROM orders ORDER BY created_at DESC')
  Future<List<OrderEntity>> getAllOrders();

  @Query('SELECT * FROM orders WHERE id = :id')
  Future<OrderEntity?> getOrderById(String id);

  @Query('SELECT * FROM orders WHERE member_id = :memberId ORDER BY created_at DESC')
  Future<List<OrderEntity>> getOrdersByMemberId(String memberId);

  @Query('SELECT * FROM orders WHERE status = :status ORDER BY created_at DESC')
  Future<List<OrderEntity>> getOrdersByStatus(String status);

  @Query('SELECT * FROM orders WHERE DATE(created_at) = :date ORDER BY created_at DESC')
  Future<List<OrderEntity>> getOrdersByDate(String date);

  @insert
  Future<void> insertOrder(OrderEntity order);

  @update
  Future<void> updateOrder(OrderEntity order);
}

// Order Item DAO
@dao
abstract class OrderItemDao {
  @Query('SELECT * FROM order_items WHERE order_id = :orderId')
  Future<List<OrderItemEntity>> getOrderItemsByOrderId(String orderId);

  @insert
  Future<void> insertOrderItem(OrderItemEntity orderItem);

  @insert
  Future<void> insertOrderItems(List<OrderItemEntity> orderItems);
}

// Inventory DAO
@dao
abstract class InventoryDao {
  @Query('SELECT * FROM inventory ORDER BY product_name ASC')
  Future<List<InventoryEntity>> getAllInventory();

  @Query('SELECT * FROM inventory WHERE product_id = :productId')
  Future<InventoryEntity?> getInventoryByProductId(String productId);

  @Query('SELECT * FROM inventory WHERE current_stock <= minimum_stock')
  Future<List<InventoryEntity>> getLowStockItems();

  @insert
  Future<void> insertInventory(InventoryEntity inventory);

  @update
  Future<void> updateInventory(InventoryEntity inventory);
}

// Payment DAO
@dao
abstract class PaymentDao {
  @Query('SELECT * FROM payments ORDER BY payment_date DESC')
  Future<List<PaymentEntity>> getAllPayments();

  @Query('SELECT * FROM payments WHERE id = :id')
  Future<PaymentEntity?> getPaymentById(String id);

  @Query('SELECT * FROM payments WHERE member_id = :memberId ORDER BY payment_date DESC')
  Future<List<PaymentEntity>> getPaymentsByMemberId(String memberId);

  @Query('SELECT * FROM payments WHERE status = :status ORDER BY payment_date DESC')
  Future<List<PaymentEntity>> getPaymentsByStatus(String status);

  @Query('SELECT * FROM payments WHERE DATE(payment_date) = :date ORDER BY payment_date DESC')
  Future<List<PaymentEntity>> getPaymentsByDate(String date);

  @Query('SELECT SUM(amount) FROM payments WHERE status = :status AND DATE(payment_date) = :date')
  Future<double?> getTotalPaymentsByDate(String status, String date);

  @insert
  Future<void> insertPayment(PaymentEntity payment);

  @update
  Future<void> updatePayment(PaymentEntity payment);
}

// Transaction DAO
@dao
abstract class TransactionDao {
  @Query('SELECT * FROM transactions ORDER BY created_at DESC')
  Future<List<TransactionEntity>> getAllTransactions();

  @Query('SELECT * FROM transactions WHERE id = :id')
  Future<TransactionEntity?> getTransactionById(String id);

  @Query('SELECT * FROM transactions WHERE type = :type ORDER BY created_at DESC')
  Future<List<TransactionEntity>> getTransactionsByType(String type);

  @Query('SELECT * FROM transactions WHERE category = :category ORDER BY created_at DESC')
  Future<List<TransactionEntity>> getTransactionsByCategory(String category);

  @Query('SELECT * FROM transactions WHERE DATE(created_at) = :date ORDER BY created_at DESC')
  Future<List<TransactionEntity>> getTransactionsByDate(String date);

  @insert
  Future<void> insertTransaction(TransactionEntity transaction);

  @update
  Future<void> updateTransaction(TransactionEntity transaction);
}

// Expense DAO
@dao
abstract class ExpenseDao {
  @Query('SELECT * FROM expenses ORDER BY expense_date DESC')
  Future<List<ExpenseEntity>> getAllExpenses();

  @Query('SELECT * FROM expenses WHERE id = :id')
  Future<ExpenseEntity?> getExpenseById(String id);

  @Query('SELECT * FROM expenses WHERE category = :category ORDER BY expense_date DESC')
  Future<List<ExpenseEntity>> getExpensesByCategory(String category);

  @Query('SELECT * FROM expenses WHERE DATE(expense_date) = :date ORDER BY expense_date DESC')
  Future<List<ExpenseEntity>> getExpensesByDate(String date);

  @Query('SELECT SUM(amount) FROM expenses WHERE category = :category AND DATE(expense_date) = :date')
  Future<double?> getTotalExpensesByCategoryAndDate(String category, String date);

  @insert
  Future<void> insertExpense(ExpenseEntity expense);

  @update
  Future<void> updateExpense(ExpenseEntity expense);

  @delete
  Future<void> deleteExpense(ExpenseEntity expense);
}

// Invoice DAO
@dao
abstract class InvoiceDao {
  @Query('SELECT * FROM invoices ORDER BY created_at DESC')
  Future<List<InvoiceEntity>> getAllInvoices();

  @Query('SELECT * FROM invoices WHERE id = :id')
  Future<InvoiceEntity?> getInvoiceById(String id);

  @Query('SELECT * FROM invoices WHERE member_id = :memberId ORDER BY created_at DESC')
  Future<List<InvoiceEntity>> getInvoicesByMemberId(String memberId);

  @insert
  Future<void> insertInvoice(InvoiceEntity invoice);

  @update
  Future<void> updateInvoice(InvoiceEntity invoice);
}

// Attendance DAO
@dao
abstract class AttendanceDao {
  @Query('SELECT * FROM attendance ORDER BY check_in_time DESC')
  Future<List<AttendanceEntity>> getAllAttendance();

  @Query('SELECT * FROM attendance WHERE id = :id')
  Future<AttendanceEntity?> getAttendanceById(String id);

  @Query('SELECT * FROM attendance WHERE member_id = :memberId ORDER BY check_in_time DESC')
  Future<List<AttendanceEntity>> getAttendanceByMemberId(String memberId);

  @Query('SELECT * FROM attendance WHERE DATE(check_in_time) = :date ORDER BY check_in_time DESC')
  Future<List<AttendanceEntity>> getAttendanceByDate(String date);

  @Query('SELECT * FROM attendance WHERE member_id = :memberId AND DATE(check_in_time) = :date LIMIT 1')
  Future<AttendanceEntity?> getTodayAttendance(String memberId, String date);

  @insert
  Future<void> insertAttendance(AttendanceEntity attendance);

  @update
  Future<void> updateAttendance(AttendanceEntity attendance);
}

// Staff DAO
@dao
abstract class StaffDao {
  @Query('SELECT * FROM staff WHERE is_active = 1 ORDER BY created_at DESC')
  Future<List<StaffEntity>> getAllStaff();

  @Query('SELECT * FROM staff WHERE id = :id')
  Future<StaffEntity?> getStaffById(String id);

  @Query('SELECT * FROM staff WHERE username = :username')
  Future<StaffEntity?> getStaffByUsername(String username);

  @Query('SELECT * FROM staff WHERE role = :role')
  Future<List<StaffEntity>> getStaffByRole(String role);

  @insert
  Future<void> insertStaff(StaffEntity staff);

  @update
  Future<void> updateStaff(StaffEntity staff);

  @delete
  Future<void> deleteStaff(StaffEntity staff);
}