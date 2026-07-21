import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkoutPrograms extends WorkoutEvent {
  const LoadWorkoutPrograms();
}

class LoadExercises extends WorkoutEvent {
  const LoadExercises();
}

class CreateWorkoutProgram extends WorkoutEvent {
  final Map<String, dynamic> program;

  const CreateWorkoutProgram({required this.program});

  @override
  List<Object?> get props => [program];
}

// States
abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {
  const WorkoutInitial();
}

class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();
}

class WorkoutLoaded extends WorkoutState {
  final List<Map<String, dynamic>> programs;
  final List<Map<String, dynamic>> exercises;

  const WorkoutLoaded({
    required this.programs,
    required this.exercises,
  });

  @override
  List<Object?> get props => [programs, exercises];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(const WorkoutInitial()) {
    on<LoadWorkoutPrograms>(_onLoadPrograms);
    on<LoadExercises>(_onLoadExercises);
    on<CreateWorkoutProgram>(_onCreateProgram);
  }

  Future<void> _onLoadPrograms(
    LoadWorkoutPrograms event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    // TODO: Implement loading programs
    emit(const WorkoutLoaded(programs: [], exercises: []));
  }

  Future<void> _onLoadExercises(
    LoadExercises event,
    Emitter<WorkoutState> emit,
  ) async {
    // TODO: Implement loading exercises
  }

  Future<void> _onCreateProgram(
    CreateWorkoutProgram event,
    Emitter<WorkoutState> emit,
  ) async {
    // TODO: Implement creating program
  }
}