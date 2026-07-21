class RoleConstants {
  RoleConstants._();

  // Staff Roles
  static const String admin = 'admin';
  static const String trainer = 'trainer';
  static const String accountant = 'accountant';
  static const String receptionist = 'receptionist';
  static const String staff = 'staff';

  // Role Display Names
  static const Map<String, String> roleDisplayNames = {
    admin: 'Administrator',
    trainer: 'Trainer',
    accountant: 'Accountant',
    receptionist: 'Receptionist',
    staff: 'Staff',
  };

  // Role Permissions
  static const Map<String, List<String>> rolePermissions = {
    admin: [
      'manage_members',
      'manage_trainers',
      'manage_staff',
      'manage_workouts',
      'manage_buffet',
      'manage_accounting',
      'view_reports',
      'manage_settings',
      'manage_backup',
    ],
    trainer: [
      'view_members',
      'manage_workouts',
      'track_progress',
      'view_schedule',
    ],
    accountant: [
      'view_members',
      'manage_accounting',
      'view_reports',
      'manage_transactions',
    ],
    receptionist: [
      'manage_members',
      'manage_attendance',
      'manage_payments',
      'view_members',
    ],
    staff: [
      'view_members',
      'manage_buffet',
      'manage_inventory',
    ],
  };

  // Membership Types
  static const String monthlyMembership = 'monthly';
  static const String quarterlyMembership = 'quarterly';
  static const String annualMembership = 'annual';
  static const String lifetimeMembership = 'lifetime';

  // Membership Status
  static const String activeMembership = 'active';
  static const String expiredMembership = 'expired';
  static const String suspendedMembership = 'suspended';
  static const String cancelledMembership = 'cancelled';

  static const Map<String, String> membershipTypeDisplayNames = {
    monthlyMembership: 'Monthly',
    quarterlyMembership: 'Quarterly',
    annualMembership: 'Annual',
    lifetimeMembership: 'Lifetime',
  };

  static const Map<String, String> membershipStatusDisplayNames = {
    activeMembership: 'Active',
    expiredMembership: 'Expired',
    suspendedMembership: 'Suspended',
    cancelledMembership: 'Cancelled',
  };
}