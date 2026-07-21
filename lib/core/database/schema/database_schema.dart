// ============================================================
// COMPLETE DATABASE SCHEMA DEFINITION
// ============================================================
// This file contains the complete SQL schema for the Gym & Buffet
// Management system with all tables, relationships, indexes,
// and constraints for offline-first SQLite database.
// ============================================================

const String createMembersTable = '''
CREATE TABLE IF NOT EXISTS members (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Personal Information
  full_name TEXT NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE,
  gender TEXT CHECK(gender IN ('MALE', 'FEMALE', 'OTHER')),
  birth_date TEXT,
  
  -- Identity
  national_id TEXT UNIQUE,
  passport_number TEXT,
  
  -- Address
  province TEXT,
  city TEXT,
  address TEXT,
  postal_code TEXT,
  
  -- Emergency Contact
  emergency_contact TEXT,
  emergency_phone TEXT,
  
  -- Health Information
  height REAL,
  weight REAL,
  blood_type TEXT CHECK(blood_type IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
  allergies TEXT, -- JSON array stored as text
  medical_conditions TEXT, -- JSON array stored as text
  medications TEXT, -- JSON array stored as text
  
  -- Fitness Profile
  fitness_goal TEXT CHECK(fitness_goal IN ('WEIGHT_LOSS', 'MUSCLE_GAIN', 'ENDURANCE', 'STRENGTH', 'FLEXIBILITY', 'GENERAL')),
  fitness_level TEXT CHECK(fitness_level IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')),
  
  -- Membership Information
  join_date TEXT NOT NULL,
  membership_status TEXT CHECK(membership_status IN ('ACTIVE', 'EXPIRED', 'SUSPENDED', 'PENDING', 'CANCELLED')) DEFAULT 'ACTIVE',
  membership_expiry_date TEXT,
  membership_type TEXT CHECK(membership_type IN ('MONTHLY', 'QUARTERLY', 'ANNUAL', 'LIFETIME')),
  
  -- Financial Information
  outstanding_balance REAL DEFAULT 0,
  total_paid REAL DEFAULT 0,
  
  -- Profile
  photo_path TEXT,
  notes TEXT,
  
  -- Tracking
  last_visit_date TEXT,
  total_visits INTEGER DEFAULT 0,
  total_days_active INTEGER DEFAULT 0,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  is_blocked INTEGER DEFAULT 0,
  block_reason TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for members table
CREATE INDEX IF NOT EXISTS idx_members_phone ON members(phone);
CREATE INDEX IF NOT EXISTS idx_members_email ON members(email);
CREATE INDEX IF NOT EXISTS idx_members_full_name ON members(full_name);
CREATE INDEX IF NOT EXISTS idx_members_membership_status ON members(membership_status);
CREATE INDEX IF NOT EXISTS idx_members_membership_expiry ON members(membership_expiry_date);
CREATE INDEX IF NOT EXISTS idx_members_is_active ON members(is_active);
CREATE INDEX IF NOT EXISTS idx_members_national_id ON members(national_id);
CREATE INDEX IF NOT EXISTS idx_members_join_date ON members(join_date);

-- Composite indexes for common queries
CREATE INDEX IF NOT EXISTS idx_members_status_expiry ON members(membership_status, membership_expiry_date);
CREATE INDEX IF NOT EXISTS idx_members_active_status ON members(is_active, membership_status);
CREATE INDEX IF NOT EXISTS idx_members_gender_status ON members(gender, membership_status);
''';

const String createMemberPaymentsTable = '''
CREATE TABLE IF NOT EXISTS member_payments (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  member_id TEXT NOT NULL,
  
  -- Payment Information
  amount REAL NOT NULL,
  payment_date TEXT NOT NULL,
  
  -- Payment Type
  payment_type TEXT CHECK(payment_type IN ('MEMBERSHIP', 'SERVICE', 'PRODUCT', 'PENALTY', 'OTHER')) NOT NULL,
  payment_method TEXT CHECK(payment_method IN ('CASH', 'CARD', 'TRANSFER', 'INSTALLMENT', 'FREE')) NOT NULL,
  payment_status TEXT CHECK(payment_status IN ('PAID', 'PARTIAL', 'PENDING', 'OVERDUE', 'CANCELLED')) NOT NULL,
  
  -- Reference Information
  invoice_id TEXT,
  membership_id TEXT,
  
  -- Details
  description TEXT,
  receipt_number TEXT,
  
  -- Period Coverage (for membership payments)
  period_start_date TEXT,
  period_end_date TEXT,
  
  -- Remaining Amount (for partial payments)
  remaining_amount REAL DEFAULT 0,
  
  -- Tracking
  recorded_at TEXT NOT NULL,
  recorded_by TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

-- Indexes for member_payments table
CREATE INDEX IF NOT EXISTS idx_member_payments_member_id ON member_payments(member_id);
CREATE INDEX IF NOT EXISTS idx_member_payments_payment_date ON member_payments(payment_date);
CREATE INDEX IF NOT EXISTS idx_member_payments_payment_status ON member_payments(payment_status);
CREATE INDEX IF NOT EXISTS idx_member_payments_payment_type ON member_payments(payment_type);
CREATE INDEX IF NOT EXISTS idx_member_payments_invoice_id ON member_payments(invoice_id);
CREATE INDEX IF NOT EXISTS idx_member_payments_membership_id ON member_payments(membership_id);

-- Composite indexes
CREATE INDEX IF NOT EXISTS idx_member_payments_member_date ON member_payments(member_id, payment_date);
CREATE INDEX IF NOT EXISTS idx_member_payments_member_status ON member_payments(member_id, payment_status);
CREATE INDEX IF NOT EXISTS idx_member_payments_status_date ON member_payments(payment_status, payment_date);
''';

const String createMemberHealthTable = '''
CREATE TABLE IF NOT EXISTS member_health (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  member_id TEXT NOT NULL,
  
  -- Record Date
  record_date TEXT NOT NULL,
  
  -- Basic Measurements
  weight REAL NOT NULL,
  height REAL NOT NULL,
  body_fat_percentage REAL,
  muscle_mass REAL,
  bone_mass REAL,
  
  -- Calculated Metrics
  bmi REAL,
  bmr REAL,
  body_age INTEGER,
  
  -- Body Measurements (in cm)
  waist_circumference REAL,
  hip_circumference REAL,
  chest_circumference REAL,
  left_arm REAL,
  right_arm REAL,
  left_thigh REAL,
  right_thigh REAL,
  
  -- Progress Tracking
  progress_notes TEXT,
  motivation_level INTEGER CHECK(motivation_level BETWEEN 1 AND 10),
  
  -- Progress Photo
  progress_photo_path TEXT,
  photo_type TEXT CHECK(photo_type IN ('BEFORE', 'PROGRESS', 'AFTER')),
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

-- Indexes for member_health table
CREATE INDEX IF NOT EXISTS idx_member_health_member_id ON member_health(member_id);
CREATE INDEX IF NOT EXISTS idx_member_health_record_date ON member_health(record_date);
CREATE INDEX IF NOT EXISTS idx_member_health_member_date ON member_health(member_id, record_date);
''';

const String createWorkoutProgramsTable = '''
CREATE TABLE IF NOT EXISTS workout_programs (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Program Information
  name TEXT NOT NULL,
  description TEXT,
  
  -- Program Type
  program_type TEXT CHECK(program_type IN ('STRENGTH', 'CARDIO', 'HIIT', 'YOGA', 'CROSSFIT', 'FLEXIBILITY', 'GENERAL')) NOT NULL,
  difficulty_level TEXT CHECK(difficulty_level IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')) NOT NULL,
  
  -- Duration
  weeks INTEGER NOT NULL,
  sessions_per_week INTEGER NOT NULL,
  estimated_minutes_per_session INTEGER DEFAULT 45,
  
  -- Target
  target_muscle_groups TEXT, -- JSON array: ['CHEST', 'BACK', 'LEGS']
  fitness_goal TEXT CHECK(fitness_goal IN ('WEIGHT_LOSS', 'MUSCLE_GAIN', 'ENDURANCE', 'STRENGTH', 'FLEXIBILITY', 'GENERAL')),
  
  -- Status
  is_active INTEGER DEFAULT 1,
  is_template INTEGER DEFAULT 0,
  created_by TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (created_by) REFERENCES staff(id) ON DELETE SET NULL
);

-- Indexes for workout_programs table
CREATE INDEX IF NOT EXISTS idx_workout_programs_program_type ON workout_programs(program_type);
CREATE INDEX IF NOT EXISTS idx_workout_programs_difficulty ON workout_programs(difficulty_level);
CREATE INDEX IF NOT EXISTS idx_workout_programs_fitness_goal ON workout_programs(fitness_goal);
CREATE INDEX IF NOT EXISTS idx_workout_programs_is_active ON workout_programs(is_active);
CREATE INDEX IF NOT EXISTS idx_workout_programs_is_template ON workout_programs(is_template);
''';

const String createExercisesTable = '''
CREATE TABLE IF NOT EXISTS exercises (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Exercise Information
  name TEXT NOT NULL,
  description TEXT,
  
  -- Classification
  exercise_category TEXT CHECK(exercise_category IN ('CHEST', 'BACK', 'LEGS', 'SHOULDERS', 'ARMS', 'CORE', 'CARDIO', 'FULL_BODY')) NOT NULL,
  exercise_type TEXT CHECK(exercise_type IN ('STRENGTH', 'CARDIO', 'FLEXIBILITY', 'PLYOMETRIC', 'CALISTHENICS')) NOT NULL,
  difficulty TEXT CHECK(difficulty IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED')) NOT NULL,
  
  -- Equipment
  required_equipment TEXT, -- JSON array: ['DUMBBELL', 'BARBELL', 'BENCH']
  
  -- Muscle Groups
  primary_muscle TEXT CHECK(primary_muscle IN ('CHEST', 'BACK', 'LEGS', 'SHOULDERS', 'ARMS', 'CORE', 'FULL_BODY')) NOT NULL,
  secondary_muscles TEXT, -- JSON array
  
  -- Instructions
  steps TEXT, -- JSON array of step descriptions
  tips TEXT, -- JSON array of tips
  
  -- Media
  demo_video_path TEXT,
  demo_image_path TEXT,
  
  -- Defaults
  default_sets INTEGER DEFAULT 3,
  default_reps INTEGER DEFAULT 12,
  default_rest_seconds INTEGER DEFAULT 60,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for exercises table
CREATE INDEX IF NOT EXISTS idx_exercises_name ON exercises(name);
CREATE INDEX IF NOT EXISTS idx_exercises_category ON exercises(exercise_category);
CREATE INDEX IF NOT EXISTS idx_exercises_type ON exercises(exercise_type);
CREATE INDEX IF NOT EXISTS idx_exercises_difficulty ON exercises(difficulty);
CREATE INDEX IF NOT EXISTS idx_exercises_primary_muscle ON exercises(primary_muscle);
CREATE INDEX IF NOT EXISTS idx_exercises_is_active ON exercises(is_active);

-- Full-text search index for exercises
CREATE INDEX IF NOT EXISTS idx_exercises_name_search ON exercises(name COLLATE NOCASE);
''';

const String createWorkoutsTable = '''
CREATE TABLE IF NOT EXISTS workouts (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  program_id TEXT NOT NULL,
  
  -- Workout Information
  day TEXT NOT NULL,
  name TEXT NOT NULL,
  workout_order INTEGER NOT NULL,
  
  -- Timing
  estimated_duration INTEGER DEFAULT 45,
  warmup_minutes INTEGER DEFAULT 5,
  cooldown_minutes INTEGER DEFAULT 5,
  
  -- Focus
  focus TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (program_id) REFERENCES workout_programs(id) ON DELETE CASCADE
);

-- Indexes for workouts table
CREATE INDEX IF NOT EXISTS idx_workouts_program_id ON workouts(program_id);
CREATE INDEX IF NOT EXISTS idx_workouts_day ON workouts(day);
CREATE INDEX IF NOT EXISTS idx_workouts_order ON workouts(workout_order);
''';

const String createWorkoutExercisesTable = '''
CREATE TABLE IF NOT EXISTS workout_exercises (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Keys
  workout_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  
  -- Order
  exercise_order INTEGER NOT NULL,
  
  -- Configuration
  sets INTEGER NOT NULL,
  reps INTEGER NOT NULL,
  weight REAL,
  
  -- Intensity
  rest_seconds INTEGER DEFAULT 60,
  intensity TEXT CHECK(intensity IN ('LOW', 'MEDIUM', 'HIGH')) DEFAULT 'MEDIUM',
  
  -- Superset
  superset_id TEXT,
  
  -- Notes
  notes TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  
  -- Foreign Key Constraints
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE
);

-- Indexes for workout_exercises table
CREATE INDEX IF NOT EXISTS idx_workout_exercises_workout_id ON workout_exercises(workout_id);
CREATE INDEX IF NOT EXISTS idx_workout_exercises_exercise_id ON workout_exercises(exercise_id);
CREATE INDEX IF NOT EXISTS idx_workout_exercises_order ON workout_exercises(exercise_order);
''';

const String createWorkoutLogsTable = '''
CREATE TABLE IF NOT EXISTS workout_logs (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Keys
  member_id TEXT NOT NULL,
  workout_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  
  -- Log Date
  log_date TEXT NOT NULL,
  
  -- Performance
  actual_weight REAL NOT NULL,
  actual_reps INTEGER NOT NULL,
  actual_sets INTEGER NOT NULL,
  
  -- Metrics
  time_taken INTEGER,
  perceived_exertion INTEGER CHECK(perceived_exertion BETWEEN 1 AND 10),
  
  -- Notes
  notes TEXT,
  feeling TEXT CHECK(feeling IN ('GREAT', 'GOOD', 'OK', 'TIRED', 'SORE')),
  
  -- Timestamps
  logged_at TEXT NOT NULL,
  created_at TEXT NOT NULL,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id) ON DELETE CASCADE
);

-- Indexes for workout_logs table
CREATE INDEX IF NOT EXISTS idx_workout_logs_member_id ON workout_logs(member_id);
CREATE INDEX IF NOT EXISTS idx_workout_logs_workout_id ON workout_logs(workout_id);
CREATE INDEX IF NOT EXISTS idx_workout_logs_exercise_id ON workout_logs(exercise_id);
CREATE INDEX IF NOT EXISTS idx_workout_logs_log_date ON workout_logs(log_date);
CREATE INDEX IF NOT EXISTS idx_workout_logs_member_date ON workout_logs(member_id, log_date);
CREATE INDEX IF NOT EXISTS idx_workout_logs_member_exercise ON workout_logs(member_id, exercise_id);
''';

const String createMemberProgressTable = '''
CREATE TABLE IF NOT EXISTS member_progress (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  member_id TEXT NOT NULL,
  
  -- Progress Date
  progress_date TEXT NOT NULL,
  
  -- Measurements
  weight REAL NOT NULL,
  body_fat REAL,
  muscle_mass REAL,
  waist REAL,
  chest REAL,
  arms REAL,
  thighs REAL,
  
  -- Performance
  best_bench REAL,
  best_squat REAL,
  best_deadlift REAL,
  best_pullups INTEGER,
  
  -- Goals
  goal_achievement REAL DEFAULT 0,
  
  -- Notes
  progress_notes TEXT,
  achievements TEXT,
  
  -- Photos
  before_photo_path TEXT,
  current_photo_path TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

-- Indexes for member_progress table
CREATE INDEX IF NOT EXISTS idx_member_progress_member_id ON member_progress(member_id);
CREATE INDEX IF NOT EXISTS idx_member_progress_date ON member_progress(progress_date);
CREATE INDEX IF NOT EXISTS idx_member_progress_member_date ON member_progress(member_id, progress_date);
''';

const String createTrainersTable = '''
CREATE TABLE IF NOT EXISTS trainers (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Personal Information
  full_name TEXT NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  email TEXT,
  
  -- Professional Information
  specializations TEXT NOT NULL, -- JSON array
  experience_years INTEGER NOT NULL,
  certifications TEXT, -- JSON array
  hourly_rate REAL NOT NULL,
  
  -- Availability
  working_days TEXT NOT NULL, -- JSON array: ['MONDAY', 'TUESDAY']
  working_hours TEXT NOT NULL, -- Format: "09:00-17:00"
  
  -- Performance
  total_sessions INTEGER DEFAULT 0,
  member_satisfaction REAL DEFAULT 5.0,
  
  -- Profile
  photo_path TEXT,
  bio TEXT,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for trainers table
CREATE INDEX IF NOT EXISTS idx_trainers_full_name ON trainers(full_name);
CREATE INDEX IF NOT EXISTS idx_trainers_phone ON trainers(phone);
CREATE INDEX IF NOT EXISTS idx_trainers_is_active ON trainers(is_active);
CREATE INDEX IF NOT EXISTS idx_trainers_experience ON trainers(experience_years);
''';

const String createTrainerSchedulesTable = '''
CREATE TABLE IF NOT EXISTS trainer_schedules (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  trainer_id TEXT NOT NULL,
  
  -- Schedule Information
  day_of_week TEXT NOT NULL CHECK(day_of_week IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY')),
  start_time TEXT NOT NULL,
  end_time TEXT NOT NULL,
  
  -- Availability
  is_available INTEGER DEFAULT 1,
  max_sessions INTEGER DEFAULT 8,
  booked_slots TEXT, -- JSON array of booked time slots
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE CASCADE
);

-- Indexes for trainer_schedules table
CREATE INDEX IF NOT EXISTS idx_trainer_schedules_trainer_id ON trainer_schedules(trainer_id);
CREATE INDEX IF NOT EXISTS idx_trainer_schedules_day ON trainer_schedules(day_of_week);
CREATE INDEX IF NOT EXISTS idx_trainer_schedules_trainer_day ON trainer_schedules(trainer_id, day_of_week);
''';

const String createTrainerAssignmentsTable = '''
CREATE TABLE IF NOT EXISTS trainer_assignments (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Keys
  trainer_id TEXT NOT NULL,
  member_id TEXT NOT NULL,
  
  -- Assignment Details
  assigned_date TEXT NOT NULL,
  program_id TEXT,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Notes
  notes TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE CASCADE,
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
  FOREIGN KEY (program_id) REFERENCES workout_programs(id) ON DELETE SET NULL
);

-- Indexes for trainer_assignments table
CREATE INDEX IF NOT EXISTS idx_trainer_assignments_trainer_id ON trainer_assignments(trainer_id);
CREATE INDEX IF NOT EXISTS idx_trainer_assignments_member_id ON trainer_assignments(member_id);
CREATE INDEX IF NOT EXISTS idx_trainer_assignments_is_active ON trainer_assignments(is_active);
CREATE INDEX IF NOT EXISTS idx_trainer_assignments_trainer_member ON trainer_assignments(trainer_id, member_id);
''';

const String createCategoriesTable = '''
CREATE TABLE IF NOT EXISTS categories (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Category Information
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  
  -- Display
  icon TEXT,
  color TEXT,
  sort_order INTEGER DEFAULT 0,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for categories table
CREATE INDEX IF NOT EXISTS idx_categories_name ON categories(name);
CREATE INDEX IF NOT EXISTS idx_categories_sort_order ON categories(sort_order);
CREATE INDEX IF NOT EXISTS idx_categories_is_active ON categories(is_active);
''';

const String createProductsTable = '''
CREATE TABLE IF NOT EXISTS products (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Product Information
  product_name TEXT NOT NULL,
  barcode TEXT UNIQUE NOT NULL,
  
  -- Foreign Key
  category_id TEXT NOT NULL,
  
  -- Pricing
  selling_price REAL NOT NULL,
  cost_price REAL NOT NULL,
  
  -- Stock Information
  current_stock REAL DEFAULT 0,
  min_stock_level REAL DEFAULT 10,
  max_stock_level REAL DEFAULT 100,
  
  -- Unit
  unit TEXT CHECK(unit IN ('PIECE', 'KG', 'GRAM', 'LITER', 'BOTTLE', 'BOX')) NOT NULL,
  weight_per_unit REAL,
  
  -- Details
  description TEXT,
  supplier TEXT,
  
  -- Media
  image_path TEXT,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Tracking
  last_restocked TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Indexes for products table
CREATE INDEX IF NOT EXISTS idx_products_name ON products(product_name);
CREATE INDEX IF NOT EXISTS idx_products_barcode ON products(barcode);
CREATE INDEX IF NOT EXISTS idx_products_category_id ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_is_active ON products(is_active);
CREATE INDEX IF NOT EXISTS idx_products_current_stock ON products(current_stock);

-- Composite indexes
CREATE INDEX IF NOT EXISTS idx_products_category_active ON products(category_id, is_active);
CREATE INDEX IF NOT EXISTS idx_products_stock_status ON products(current_stock, min_stock_level);
''';

const String createInventoryTransactionsTable = '''
CREATE TABLE IF NOT EXISTS inventory_transactions (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  product_id TEXT NOT NULL,
  
  -- Transaction Information
  transaction_type TEXT CHECK(transaction_type IN ('ADDITION', 'REDUCTION', 'ADJUSTMENT')) NOT NULL,
  quantity REAL NOT NULL,
  
  -- Stock Changes
  previous_quantity REAL NOT NULL,
  new_quantity REAL NOT NULL,
  
  -- Reason
  reason TEXT CHECK(reason IN ('SALE', 'RESTOCK', 'RETURN', 'LOSS', 'ADJUSTMENT', 'DAMAGE')) NOT NULL,
  
  -- Reference
  reference_id TEXT,
  notes TEXT,
  
  -- Tracking
  transaction_date TEXT NOT NULL,
  performed_by TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  
  -- Foreign Key Constraints
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Indexes for inventory_transactions table
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_product_id ON inventory_transactions(product_id);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_type ON inventory_transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_date ON inventory_transactions(transaction_date);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_product_date ON inventory_transactions(product_id, transaction_date);
CREATE INDEX IF NOT EXISTS idx_inventory_transactions_reason ON inventory_transactions(reason);
''';

const String createOrdersTable = '''
CREATE TABLE IF NOT EXISTS orders (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Order Information
  order_number TEXT UNIQUE NOT NULL,
  
  -- Foreign Keys
  member_id TEXT,
  
  -- Customer Information
  customer_name TEXT,
  table_number TEXT,
  
  -- Financial
  subtotal REAL NOT NULL,
  discount_amount REAL DEFAULT 0,
  tax_amount REAL DEFAULT 0,
  total_price REAL NOT NULL,
  
  -- Status
  order_status TEXT CHECK(order_status IN ('PENDING', 'PREPARING', 'READY', 'COMPLETED', 'CANCELLED')) DEFAULT 'PENDING',
  payment_status TEXT CHECK(payment_status IN ('UNPAID', 'PARTIAL', 'PAID')) DEFAULT 'UNPAID',
  payment_method TEXT CHECK(payment_method IN ('CASH', 'CARD', 'TRANSFER', 'MEMBER_ACCOUNT', 'FREE')),
  
  -- Notes
  notes TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  completed_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE SET NULL
);

-- Indexes for orders table
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON orders(order_number);
CREATE INDEX IF NOT EXISTS idx_orders_member_id ON orders(member_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_status ON orders(order_status);
CREATE INDEX IF NOT EXISTS idx_orders_payment_status ON orders(payment_status);
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at);
CREATE INDEX IF NOT EXISTS idx_orders_completed_at ON orders(completed_at);

-- Composite indexes
CREATE INDEX IF NOT EXISTS idx_orders_status_date ON orders(order_status, created_at);
CREATE INDEX IF NOT EXISTS idx_orders_payment_date ON orders(payment_status, created_at);
CREATE INDEX IF NOT EXISTS idx_orders_member_date ON orders(member_id, created_at);
''';

const String createOrderItemsTable = '''
CREATE TABLE IF NOT EXISTS order_items (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Keys
  order_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  
  -- Product Information (denormalized for performance)
  product_name TEXT NOT NULL,
  
  -- Quantity and Pricing
  quantity INTEGER NOT NULL,
  unit_price REAL NOT NULL,
  total_price REAL NOT NULL,
  
  -- Notes
  notes TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  
  -- Foreign Key Constraints
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Indexes for order_items table
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_order_items_product_id ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_product ON order_items(order_id, product_id);
''';

const String createTransactionsTable = '''
CREATE TABLE IF NOT EXISTS transactions (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Transaction Information
  transaction_number TEXT UNIQUE NOT NULL,
  
  -- Type
  transaction_type TEXT CHECK(transaction_type IN ('INCOME', 'EXPENSE')) NOT NULL,
  
  -- Category
  category TEXT NOT NULL,
  
  -- Financial
  amount REAL NOT NULL,
  tax_amount REAL DEFAULT 0,
  total_amount REAL NOT NULL,
  
  -- Details
  description TEXT,
  
  -- Reference
  reference_id TEXT,
  reference_type TEXT CHECK(reference_type IN ('MEMBERSHIP', 'PRODUCT', 'SERVICE', 'ORDER', 'INVOICE')),
  
  -- Verification
  is_verified INTEGER DEFAULT 0,
  verification_date TEXT,
  
  -- Tracking
  transaction_date TEXT NOT NULL,
  recorded_by TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for transactions table
CREATE INDEX IF NOT EXISTS idx_transactions_number ON transactions(transaction_number);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(transaction_type);
CREATE INDEX IF NOT EXISTS idx_transactions_category ON transactions(category);
CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(transaction_date);
CREATE INDEX IF NOT EXISTS idx_transactions_reference ON transactions(reference_id);
CREATE INDEX IF NOT EXISTS idx_transactions_is_verified ON transactions(is_verified);

-- Composite indexes
CREATE INDEX IF NOT EXISTS idx_transactions_type_date ON transactions(transaction_type, transaction_date);
CREATE INDEX IF NOT EXISTS idx_transactions_category_date ON transactions(category, transaction_date);
CREATE INDEX IF NOT EXISTS idx_transactions_type_category_date ON transactions(transaction_type, category, transaction_date);
''';

const String createInvoicesTable = '''
CREATE TABLE IF NOT EXISTS invoices (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Invoice Information
  invoice_number TEXT UNIQUE NOT NULL,
  
  -- Foreign Key
  member_id TEXT,
  
  -- Customer Information
  customer_name TEXT NOT NULL,
  customer_phone TEXT,
  
  -- Financial
  subtotal REAL NOT NULL,
  discount REAL DEFAULT 0,
  tax REAL DEFAULT 0,
  total REAL NOT NULL,
  
  -- Status
  invoice_status TEXT CHECK(invoice_status IN ('DRAFT', 'ISSUED', 'PAID', 'CANCELLED', 'OVERDUE')) DEFAULT 'DRAFT',
  
  -- Dates
  issued_date TEXT NOT NULL,
  due_date TEXT NOT NULL,
  paid_date TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE SET NULL
);

-- Indexes for invoices table
CREATE INDEX IF NOT EXISTS idx_invoices_number ON invoices(invoice_number);
CREATE INDEX IF NOT EXISTS idx_invoices_member_id ON invoices(member_id);
CREATE INDEX IF NOT EXISTS idx_invoices_status ON invoices(invoice_status);
CREATE INDEX IF NOT EXISTS idx_invoices_issued_date ON invoices(issued_date);
CREATE INDEX IF NOT EXISTS idx_invoices_due_date ON invoices(due_date);
CREATE INDEX IF NOT EXISTS idx_invoices_member_status ON invoices(member_id, invoice_status);
''';

const String createInvoiceItemsTable = '''
CREATE TABLE IF NOT EXISTS invoice_items (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  invoice_id TEXT NOT NULL,
  
  -- Item Information
  description TEXT NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price REAL NOT NULL,
  total REAL NOT NULL,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  
  -- Foreign Key Constraints
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
);

-- Indexes for invoice_items table
CREATE INDEX IF NOT EXISTS idx_invoice_items_invoice_id ON invoice_items(invoice_id);
''';

const String createInstallmentPlansTable = '''
CREATE TABLE IF NOT EXISTS installment_plans (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  invoice_id TEXT NOT NULL,
  
  -- Installment Information
  installment_number INTEGER NOT NULL,
  amount REAL NOT NULL,
  
  -- Dates
  due_date TEXT NOT NULL,
  paid_date TEXT,
  
  -- Status
  is_paid INTEGER DEFAULT 0,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
);

-- Indexes for installment_plans table
CREATE INDEX IF NOT EXISTS idx_installment_plans_invoice_id ON installment_plans(invoice_id);
CREATE INDEX IF NOT EXISTS idx_installment_plans_due_date ON installment_plans(due_date);
CREATE INDEX IF NOT EXISTS idx_installment_plans_is_paid ON installment_plans(is_paid);
CREATE INDEX IF NOT EXISTS idx_installment_plans_invoice_number ON installment_plans(invoice_id, installment_number);
''';

const String createAttendanceTable = '''
CREATE TABLE IF NOT EXISTS attendance (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Foreign Key
  member_id TEXT NOT NULL,
  
  -- Member Information (denormalized)
  member_name TEXT NOT NULL,
  
  -- Check-in/Check-out
  check_in_time TEXT NOT NULL,
  check_out_time TEXT,
  
  -- Duration
  duration_minutes INTEGER,
  
  -- Check-in Method
  check_in_method TEXT CHECK(check_in_method IN ('MANUAL', 'QR_CODE', 'FINGERPRINT', 'FACE_ID')) DEFAULT 'MANUAL',
  
  -- Notes
  notes TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT,
  
  -- Foreign Key Constraints
  FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

-- Indexes for attendance table
CREATE INDEX IF NOT EXISTS idx_attendance_member_id ON attendance(member_id);
CREATE INDEX IF NOT EXISTS idx_attendance_check_in_time ON attendance(check_in_time);
CREATE INDEX IF NOT EXISTS idx_attendance_check_out_time ON attendance(check_out_time);
CREATE INDEX IF NOT EXISTS idx_attendance_check_in_method ON attendance(check_in_method);
CREATE INDEX IF NOT EXISTS idx_attendance_member_date ON attendance(member_id, check_in_time);

-- Composite indexes for common queries
CREATE INDEX IF NOT EXISTS idx_attendance_date_hour ON attendance(check_in_time);
CREATE INDEX IF NOT EXISTS idx_attendance_member_month ON attendance(member_id, check_in_time);
''';

const String createStaffTable = '''
CREATE TABLE IF NOT EXISTS staff (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Personal Information
  full_name TEXT NOT NULL,
  phone TEXT UNIQUE NOT NULL,
  email TEXT,
  
  -- Role
  role TEXT CHECK(role IN ('ADMIN', 'TRAINER', 'ACCOUNTANT', 'RECEPTIONIST', 'STAFF')) NOT NULL,
  
  -- Authentication
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  
  -- Financial
  salary REAL,
  commission_rate REAL DEFAULT 0,
  
  -- Employment
  hire_date TEXT NOT NULL,
  
  -- Profile
  photo_path TEXT,
  
  -- Status
  is_active INTEGER DEFAULT 1,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for staff table
CREATE INDEX IF NOT EXISTS idx_staff_full_name ON staff(full_name);
CREATE INDEX IF NOT EXISTS idx_staff_phone ON staff(phone);
CREATE INDEX IF NOT EXISTS idx_staff_username ON staff(username);
CREATE INDEX IF NOT EXISTS idx_staff_role ON staff(role);
CREATE INDEX IF NOT EXISTS idx_staff_is_active ON staff(is_active);
''';

const String createSettingsTable = '''
CREATE TABLE IF NOT EXISTS settings (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Setting Information
  setting_key TEXT UNIQUE NOT NULL,
  setting_value TEXT,
  setting_type TEXT CHECK(setting_type IN ('STRING', 'INTEGER', 'DOUBLE', 'BOOLEAN', 'JSON')) DEFAULT 'STRING',
  
  -- Description
  description TEXT,
  
  -- Timestamps
  created_at TEXT NOT NULL,
  updated_at TEXT
);

-- Indexes for settings table
CREATE INDEX IF NOT EXISTS idx_settings_key ON settings(setting_key);
''';

const String createAuditLogTable = '''
CREATE TABLE IF NOT EXISTS audit_log (
  -- Primary Key
  id TEXT PRIMARY KEY NOT NULL,
  
  -- Action
  action TEXT NOT NULL CHECK(action IN ('CREATE', 'UPDATE', 'DELETE', 'LOGIN', 'LOGOUT', 'EXPORT', 'BACKUP')),
  
  -- Entity
  entity_type TEXT NOT NULL,
  entity_id TEXT,
  
  -- Changes
  old_values TEXT, -- JSON
  new_values TEXT, -- JSON
  
  -- User
  user_id TEXT,
  user_name TEXT,
  
  -- IP Address
  ip_address TEXT,
  
  -- Timestamp
  created_at TEXT NOT NULL
);

-- Indexes for audit_log table
CREATE INDEX IF NOT EXISTS idx_audit_log_action ON audit_log(action);
CREATE INDEX IF NOT EXISTS idx_audit_log_entity ON audit_log(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_user ON audit_log(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_created_at ON audit_log(created_at);
CREATE INDEX IF NOT EXISTS idx_audit_log_entity_date ON audit_log(entity_type, created_at);
''';

// ============================================================
// SEED DATA
// ============================================================

const String seedCategories = '''
INSERT OR IGNORE INTO categories (id, name, description, icon, color, sort_order, is_active, created_at) VALUES
  ('cat_001', 'Beverages', 'Drinks and refreshments', 'local_drink', '#2196F3', 1, 1, datetime('now')),
  ('cat_002', 'Protein Supplements', 'Protein powders and bars', 'fitness_center', '#4CAF50', 2, 1, datetime('now')),
  ('cat_003', 'Snacks', 'Healthy snacks and energy bars', 'restaurant', '#FF9800', 3, 1, datetime('now')),
  ('cat_004', 'Fresh Food', 'Fresh meals and salads', 'eco', '#8BC34A', 4, 1, datetime('now')),
  ('cat_005', 'Supplements', 'Vitamins and minerals', 'medication', '#9C27B0', 5, 1, datetime('now'));
''';

const String seedDefaultAdmin = '''
INSERT OR IGNORE INTO staff (id, full_name, phone, role, username, password_hash, hire_date, is_active, created_at) VALUES
  ('staff_001', 'System Admin', '0000000000', 'ADMIN', 'admin', 'admin123', datetime('now'), 1, datetime('now'));
''';

const String seedDefaultSettings = '''
INSERT OR IGNORE INTO settings (id, setting_key, setting_value, setting_type, description, created_at) VALUES
  ('set_001', 'gym_name', 'Gym Buffet Manager', 'STRING', 'Gym business name', datetime('now')),
  ('set_002', 'gym_address', '', 'STRING', 'Gym address', datetime('now')),
  ('set_003', 'gym_phone', '', 'STRING', 'Gym contact phone', datetime('now')),
  ('set_004', 'currency', 'USD', 'STRING', 'Default currency', datetime('now')),
  ('set_005', 'tax_rate', '0.1', 'DOUBLE', 'Tax rate (10%)', datetime('now')),
  ('set_006', 'low_stock_threshold', '10', 'INTEGER', 'Low stock alert threshold', datetime('now')),
  ('set_007', 'membership_expiry_alert_days', '7', 'INTEGER', 'Days before expiry to alert', datetime('now')),
  ('set_008', 'auto_backup_enabled', 'true', 'BOOLEAN', 'Enable automatic backups', datetime('now')),
  ('set_009', 'backup_interval_hours', '24', 'INTEGER', 'Backup interval in hours', datetime('now')),
  ('set_010', 'receipt_header', 'Thank you for your purchase!', 'STRING', 'Receipt header text', datetime('now')),
  ('set_011', 'receipt_footer', 'See you next time!', 'STRING', 'Receipt footer text', datetime('now'));
''';