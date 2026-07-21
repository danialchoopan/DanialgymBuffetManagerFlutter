import '../entities/trainer/trainer_entity.dart';
import '../entities/trainer/trainer_schedule_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class TrainerRepository {
  ResultFuture<List<TrainerEntity>> getAllTrainers();
  ResultFuture<TrainerEntity?> getTrainerById(String id);
  ResultFuture<List<TrainerEntity>> getTrainersBySpecialization(String specialization);
  ResultFuture<void> addTrainer(TrainerEntity trainer);
  ResultFuture<void> updateTrainer(TrainerEntity trainer);
  ResultFuture<void> deleteTrainer(String id);

  ResultFuture<List<TrainerScheduleEntity>> getSchedulesByTrainerId(String trainerId);
  ResultFuture<List<TrainerScheduleEntity>> getSchedulesByDay(String dayOfWeek);
  ResultFuture<void> addSchedule(TrainerScheduleEntity schedule);
  ResultFuture<void> updateSchedule(TrainerScheduleEntity schedule);
  ResultFuture<void> deleteSchedule(String id);

  ResultFuture<List<TrainerEntity>> getAvailableTrainers(DateTime date, String time);
}