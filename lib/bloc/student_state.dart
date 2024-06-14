part of 'student_bloc.dart';

class StudentState {}

final class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final List<Student> students;
  StudentLoaded({required this.students});
}

class StudentError extends StudentState {
  final String error;
  StudentError({required this.error});
}

class ImagePicked extends StudentState {
  final String imagePath;
  ImagePicked({required this.imagePath});
}

class StudentSearchLoading extends StudentState{}

class StudentEmpty extends StudentState{}
