part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

class FetchStudents extends StudentEvent {}

class AddStudent extends StudentEvent {
  final Student student;
  AddStudent(this.student);
}

class PickImage extends StudentEvent {}

class ClearImage extends StudentEvent {}

class DeleteStudent extends StudentEvent {
  final int studentId;
  DeleteStudent(this.studentId);
}
class PatchStudent extends StudentEvent{
  final Student student;
  final int studentId;
  PatchStudent( this.student, this.studentId, );
}
class SearchStudents extends StudentEvent{
  final String query;

  SearchStudents( this.query);
}
