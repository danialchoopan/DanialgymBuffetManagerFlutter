import 'package:dartz/dartz.dart';
import '../entities/trainer/trainer_entities.dart';
import '../errors/failures.dart';

abstract class TrainerRepository {
  // Trainer CRUD Operations
  Future<Either<Failure, TrainerEntity>> addTrainer(TrainerEntity trainer);
  Future<Either<Failure, TrainerEntity>> updateTrainer(TrainerEntity trainer);
  Future<Either<Failure, void>> deleteTrainer(String id);
  Future<Either<Failure, TrainerEntity?>> getTrainerById(String id);
  Future<Either<Failure, List<TrainerEntity>>> getAllTrainers();
  Future<Either<Failure, List<TrainerEntity>>> getActiveTrainers();
  Future<Either<Failure, List<TrainerEntity>>> searchTrainers(String query);
  Future<Either<Failure, List<TrainerEntity>>> getTrainersBySpecialization(String specialization);
  
  // Schedule Operations
  Future<Either<Failure, List<TrainerScheduleEntity>>> getTrainerSchedule(String trainerId);
  Future<Either<Failure, List<TrainerScheduleEntity>>> getTrainerScheduleByDay(String trainerId, String day);
  Future<Either<Failure, TrainerScheduleEntity>> addSchedule(TrainerScheduleEntity schedule);
  Future<Either<Failure, TrainerScheduleEntity>> updateSchedule(TrainerScheduleEntity schedule);
  Future<Either<Failure, void>> deleteSchedule(String scheduleId);
  Future<Either<Failure, List<String>>> getAvailableTimeSlots(String trainerId, String day);
  Future<Either<Failure, bool>> isTrainerAvailable(String trainerId, String day, String time);
  
  // Member Assignment
  Future<Either<Failure, void>> assignMemberToTrainer(String memberId, String trainerId);
  Future<Either<Failure, void>> unassignMemberFromTrainer(String memberId, String trainerId);
  Future<Either<Failure, List<String>>> getTrainerAssignedMembers(String trainerId);
  Future<Either<Failure, String?>> getMemberTrainer(String memberId);
  Future<Either<Failure, bool>> isMemberAssignedToTrainer(String memberId, String trainerId);
  
  // Performance
  Future<Either<Failure, int>> getTrainerSessionCount(String trainerId, DateTime start, DateTime end);
  Future<Either<Failure, double>> getTrainerAverageRating(String trainerId);
  Future<Either<Failure, List<Map<String, dynamic>>>> getTrainerPerformanceMetrics(
    String trainerId,
    DateTime start,
    DateTime end,
  );
  Future<Either<Failure, Money>> getTrainerEarnings(String trainerId, DateTime start, DateTime end);
  Future<Either<Failure, Money>> getTrainerCommission(String trainerId, double commissionRate, DateTime start, DateTime end);
  
  // Statistics
  Future<Either<Failure, int>> getTrainerCount();
  Future<Either<Failure, int>> getActiveTrainerCount();
  Future<Either<Failure, Map<String, int>>> getTrainerCountBySpecialization();
  Future<Either<Failure, List<TrainerEntity>>> getTopRatedTrainers(int limit);
  Future<Either<Failure, List<TrainerEntity>>> getMostExperiencedTrainers(int limit);
}