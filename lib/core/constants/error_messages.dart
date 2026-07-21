class ErrorMessages {
  ErrorMessages._();

  // ============================================================
  // GENERAL ERRORS
  // ============================================================
  static const String unexpectedError = 'خطای غیرمنتظره‌ای رخ داد. لطفاً دوباره تلاش کنید.';
  static const String networkError = 'خطا در اتصال به شبکه. لطفاً اتصال اینترنت خود را بررسی کنید.';
  static const String timeoutError = 'زمان درخواست به پایان رسید. لطفاً دوباره تلاش کنید.';
  static const String cancelledError = 'درخواست لغو شد.';

  // ============================================================
  // DATABASE ERRORS
  // ============================================================
  static const String databaseError = 'خطا در ارتباط با پایگاه داده. لطفاً برنامه را مجدداً راه‌اندازی کنید.';
  static const String databaseInitError = 'خطا در راه‌اندازی پایگاه داده.';
  static const String databaseInsertError = 'خطا در ذخیره اطلاعات.';
  static const String databaseUpdateError = 'خطا در بروزرسانی اطلاعات.';
  static const String databaseDeleteError = 'خطا در حذف اطلاعات.';
  static const String databaseQueryError = 'خطا در بازیابی اطلاعات.';

  // ============================================================
  // AUTHENTICATION ERRORS
  // ============================================================
  static const String authenticationError = 'خطا در احراز هویت.';
  static const String invalidCredentials = 'نام کاربری یا رمز عبور اشتباه است.';
  static const String accountLocked = 'حساب کاربری قفل شده است. لطفاً با مدیر سیستم تماس بگیرید.';
  static const String biometricError = 'خطا در تشخیص اثر انگشت.';
  static const String biometricNotAvailable = 'تشخیص اثر انگشت در این دستگاه در دسترس نیست.';
  static const String pinRequired = 'لطفاً رمز عبور خود را وارد کنید.';
  static const String invalidPin = 'رمز عبور اشتباه است. لطفاً دوباره تلاش کنید.';
  static const String maxAttemptsExceeded = 'تعداد تلاش‌های ناموفق بیش از حد مجاز است. حساب شما قفل شد.';
  static const String sessionExpired = 'نشست شما منقضی شده است. لطفاً مجدداً وارد شوید.';
  static const String unauthorizedAccess = 'شما دسترسی لازم را ندارید.';
  static const String passwordTooWeak = 'رمز عبور باید حداقل 8 کاراکتر باشد.';
  static const String passwordsNotMatch = 'رمز عبور و تکرار آن مطابقت ندارند.';
  static const String currentPasswordIncorrect = 'رمز عبور فعلی اشتباه است.';

  // ============================================================
  // VALIDATION ERRORS
  // ============================================================
  static const String requiredField = 'لطفاً اطلاعات را به درستی وارد کنید.';
  static const String invalidEmail = 'لطفاً یک آدرس ایمیل معتبر وارد کنید.';
  static const String invalidPhone = 'لطفاً یک شماره تلفن معتبر وارد کنید.';
  static const String invalidPassword = 'رمز عبور باید حداقل 8 کاراکتر باشد.';
  static const String passwordMismatch = 'رمز عبور و تکرار آن مطابقت ندارند.';
  static const String invalidDate = 'لطفاً یک تاریخ معتبر وارد کنید.';
  static const String invalidAmount = 'لطفاً یک مبلغ معتبر وارد کنید.';
  static const String invalidNumber = 'لطفاً یک عدد معتبر وارد کنید.';
  static const String invalidDateFormat = 'فرمت تاریخ نامعتبر است.';
  static const String minimumAgeRequired = 'حداقل سن عضویت 12 سال است.';
  static const String maximumLengthExceeded = 'تعداد کاراکترها بیش از حد مجاز است.';
  static const String minimumLengthRequired = 'تعداد کاراکترها کمتر از حداقل مجاز است.';

  // ============================================================
  // MEMBER ERRORS
  // ============================================================
  static const String memberNotFound = 'عضو مورد نظر یافت نشد.';
  static const String memberAlreadyExists = 'عضوی با این شماره تلفن قبلاً ثبت شده است.';
  static const String membershipExpired = 'عضویت منقضی شده است.';
  static const String membershipInactive = 'عضویت فعال نیست.';
  static const String membershipSuspended = 'عضویت به حالت تعلیق درآمده است.';
  static const String paymentOverdue = 'عضو پرداخت معوق دارد.';
  static const String memberBlocked = 'عضو مسدود شده است.';
  static const String duplicatePhone = 'عضوی با این شماره تلفن قبلاً ثبت شده است.';
  static const String duplicateEmail = 'عضوی با این آدرس ایمیل قبلاً ثبت شده است.';
  static const String invalidMemberData = 'اطلاعات عضو نامعتبر است.';
  static const String cannotDeleteMemberWithDebt = 'عضو دارای بدهی است. لطفاً ابتدا بدهی را تسویه کنید.';
  static const String membershipRenewalFailed = 'خطا در تمدید عضویت.';

  // ============================================================
  // WORKOUT ERRORS
  // ============================================================
  static const String workoutNotFound = 'برنامه تمرینی یافت نشد.';
  static const String exerciseNotFound = 'تمرین یافت نشد.';
  static const String programAlreadyAssigned = 'این برنامه قبلاً به عضو اختصاص داده شده است.';
  static const String invalidWorkoutData = 'اطلاعات تمرین نامعتبر است.';
  static const String workoutLogFailed = 'خطا در ثبت تمرین.';
  static const String progressUpdateFailed = 'خطا در بروزرسانی پیشرفت.';

  // ============================================================
  // BUFFET ERRORS
  // ============================================================
  static const String productNotFound = 'محصول یافت نشد.';
  static const String productOutOfStock = 'موجودی محصول تمام شده است.';
  static const String insufficientStock = 'موجودی کافی نیست.';
  static const String categoryNotFound = 'دسته‌بندی یافت نشد.';
  static const String orderNotFound = 'سفارش یافت نشد.';
  static const String invalidOrderData = 'اطلاعات سفارش نامعتبر است.';
  static const String orderAlreadyCancelled = 'سفارش قبلاً لغو شده است.';
  static const String emptyOrder = 'سفارش باید حداقل یک آیتم داشته باشد.';
  static const String invalidBarcode = 'بارکد نامعتبر است.';
  static const String duplicateBarcode = 'بارکد تکراری است.';
  static const String stockUpdateFailed = 'خطا در بروزرسانی موجودی.';
  static const String orderCreationFailed = 'خطا در ایجاد سفارش.';
  static const String lowStockAlert = 'موجودی محصول زیر حداقل است.';

  // ============================================================
  // ACCOUNTING ERRORS
  // ============================================================
  static const String paymentFailed = 'خطا در پردازش پرداخت.';
  static const String transactionNotFound = 'تراکنش یافت نشد.';
  static const String insufficientFunds = 'موجودی کافی نیست.';
  static const String reportGenerationFailed = 'خطا در تولید گزارش.';
  static const String invalidTransactionData = 'اطلاعات تراکنش نامعتبر است.';
  static const String duplicateTransaction = 'تراکنش تکراری است.';
  static const String invoiceNotFound = 'فاکتور یافت نشد.';
  static const String invoiceAlreadyPaid = 'فاکتور قبلاً پرداخت شده است.';
  static const String invoiceOverdue = 'فاکتور سررسید گذشته است.';
  static const String amountExceedsBalance = 'مبلغ پرداختی بیشتر از مانده فاکتور است.';
  static const String paymentReminderFailed = 'خطا در ارسال یادآوری پرداخت.';
  static const String exportFailed = 'خطا در خروجی گرفتن.';
  static const String invalidAmount = 'مبلغ باید بیشتر از صفر باشد.';
  static const String expenseCategoryRequired = 'دسته‌بندی هزینه الزامی است.';
  static const String incomeCategoryRequired = 'دسته‌بندی درآمد الزامی است.';

  // ============================================================
  // TRAINER ERRORS
  // ============================================================
  static const String trainerNotFound = 'مربی یافت نشد.';
  static const String trainerNotAvailable = 'مربی در این زمان در دسترس نیست.';
  static const String trainerFullyBooked = 'مربی کاملاً رزرو شده است.';
  static const String memberAlreadyAssigned = 'عضو قبلاً به این مربی اختصاص داده شده است.';
  static const String invalidScheduleData = 'اطلاعات برنامه زمانی نامعتبر است.';
  static const String scheduleConflictConflict = 'تداخل در برنامه زمانی وجود دارد.';

  // ============================================================
  // ATTENDANCE ERRORS
  // ============================================================
  static const String alreadyCheckedIn = 'عضو قبلاً ورود زده است.';
  static const String notCheckedIn = 'عضو ورود نزده است.';
  static const String attendanceNotFound = 'رکورد حضور یافت نشد.';
  static const String gymFull = 'ظرفیت سالن تکمیل است.';
  static const String invalidQRCode = 'کد QR نامعتبر است.';
  static const String checkInFailed = 'خطا در ثبت ورود.';
  static const String checkOutFailed = 'خطا در ثبت خروج.';
  static const String autoCheckOutFailed = 'خطا در خروج خودکار.';

  // ============================================================
  // STAFF ERRORS
  // ============================================================
  static const String staffNotFound = 'کارمند یافت نشد.';
  static const String staffAlreadyExists = 'کاربری با این نام کاربری قبلاً ثبت شده است.';
  static const String invalidRole = 'نقش نامعتبر است.';
  static const String roleChangeFailed = 'خطا در تغییر نقش کاربر.';
  static const String passwordChangeFailed = 'خطا در تغییر رمز عبور.';

  // ============================================================
  // FILE ERRORS
  // ============================================================
  static const String fileNotFound = 'فایل یافت نشد.';
  static const String fileAccessError = 'امکان دسترسی به فایل وجود ندارد.';
  static const String fileSaveError = 'خطا در ذخیره فایل.';
  static const String imagePickError = 'خطا در انتخاب تصویر.';
  static const String invalidImageFormat = 'فرمت تصویر نامعتبر است.';
  static const String imageTooLarge = 'حجم تصویر بیش از حد مجاز است.';

  // ============================================================
  // BACKUP ERRORS
  // ============================================================
  static const String backupFailed = 'خطا در پشتیبان‌گیری.';
  static const String restoreFailed = 'خطا در بازیابی اطلاعات.';
  static const String backupCorrupted = 'فایل پشتیبان خراب است.';
  static const String backupNotFound = 'فایل پشتیبان یافت نشد.';
  static const String restoreConfirmation = 'آیا از بازیابی اطلاعات اطمینان دارید؟ تمام اطلاعات فعلی جایگزین خواهد شد.';

  // ============================================================
  // PRINT ERRORS
  // ============================================================
  static const String printFailed = 'خطا در چاپ.';
  static const String printerNotFound = 'چاپگر یافت نشد.';
  static const String printerConnectionError = 'خطا در اتصال به چاپگر.';
  static const String noDataToPrint = 'داده‌ای برای چاپ وجود ندارد.';

  // ============================================================
  // EXPORT ERRORS
  // ============================================================
  static const String exportFailed = 'خطا در خروجی گرفتن.';
  static const String invalidExportFormat = 'فرمت خروجی نامعتبر است.';
  static const String noDataToExport = 'داده‌ای برای خروجی وجود ندارد.';
  static const String exportSuccess = 'خروجی با موفقیت ایجاد شد.';

  // ============================================================
  // SETTINGS ERRORS
  // ============================================================
  static const String settingsLoadFailed = 'خطا در بارگذاری تنظیمات.';
  static const String settingsSaveFailed = 'خطا در ذخیره تنظیمات.';
  static const String invalidSettingValue = 'مقدار تنظیمات نامعتبر است.';
  static const String resetSettingsFailed = 'خطا در بازنشانی تنظیمات.';

  // ============================================================
  // SUCCESS MESSAGES
  // ============================================================
  static const String saveSuccess = 'اطلاعات با موفقیت ذخیره شد.';
  static const String updateSuccess = 'اطلاعات با موفقیت بروزرسانی شد.';
  static const String deleteSuccess = 'اطلاعات با موفقیت حذف شد.';
  static const String loginSuccess = 'ورود با موفقیت انجام شد.';
  static const String logoutSuccess = 'خروج با موفقیت انجام شد.';
  static const String backupSuccess = 'پشتیبان با موفقیت ایجاد شد.';
  static const String restoreSuccess = 'اطلاعات با موفقیت بازیابی شد.';
  static const String exportSuccessMessage = 'خروجی با موفقیت ایجاد شد.';
  static const String paymentSuccess = 'پرداخت با موفقیت پردازش شد.';
  static const String checkInSuccess = 'ورود با موفقیت ثبت شد.';
  static const String checkOutSuccess = 'خروج با موفقیت ثبت شد.';
  static const String orderSuccess = 'سفارش با موفقیت ثبت شد.';
  static const String memberAddedSuccess = 'عضو جدید با موفقیت ثبت شد.';
  static const String memberUpdatedSuccess = 'اطلاعات عضو با موفقیت بروزرسانی شد.';
  static const String memberDeletedSuccess = 'عضو با موفقیت حذف شد.';
  static const String paymentRecordedSuccess = 'پرداخت با موفقیت ثبت شد.';
  static const String invoiceGeneratedSuccess = 'فاکتور با موفقیت تولید شد.';
  static const String reportGeneratedSuccess = 'گزارش با موفقیت تولید شد.';
  static const String passwordChangedSuccess = 'رمز عبور با موفقیت تغییر کرد.';
  static const String membershipRenewedSuccess = 'عضویت با موفقیت تمدید شد.';
  static const String memberBlockedSuccess = 'عضو با موفقیت مسدود شد.';
  static const String memberUnblockedSuccess = 'عضو از مسدودیت خارج شد.';
  static const String notificationSentSuccess = 'یادآوری با موفقیت ارسال شد.';

  // ============================================================
  // CONFIRMATION MESSAGES
  // ============================================================
  static const String deleteConfirmation = 'آیا از حذف این مورد اطمینان دارید؟';
  static const String cancelOrderConfirmation = 'آیا از لغو سفارش اطمینان دارید؟';
  static const String blockMemberConfirmation = 'آیا از مسدود کردن این عضو اطمینان دارید؟';
  static const String unblockMemberConfirmation = 'آیا از رفع مسدودیت این عضو اطمینان دارید؟';
  static const String logoutConfirmation = 'آیا از خروج اطمینان دارید؟';
  static const String clearDataConfirmation = 'آیا از پاک کردن تمام اطلاعات اطمینان دارید؟ این عمل قابل بازگشت نیست.';
  static const String renewMembershipConfirmation = 'آیا از تمدید عضویت اطمینان دارید?';

  // ============================================================
  // LOADING MESSAGES
  // ============================================================
  static const String loading = 'در حال بارگذاری...';
  static const String saving = 'در حال ذخیره...';
  static const String updating = 'در حال بروزرسانی...';
  static const String deleting = 'در حال حذف...';
  static const String processing = 'در حال پردازش...';
  static const String generating = 'در حال تولید...';
  static const String exporting = 'در حال خروجی گرفتن...';
  static const String printing = 'در حال چاپ...';
  static const String backingUp = 'در حال پشتیبان‌گیری...';
  static const String restoring = 'در حال بازیابی...';
  static const String searching = 'در حال جستجو...';
  static const String authenticating = 'در حال احراز هویت...';
  static const String loggingIn = 'در حال ورود...';
  static const String loggingOut = 'در حال خروج...';
  static const String checkingIn = 'در حال ثبت ورود...';
  static const String checkingOut = 'در حال ثبت خروج...';
}