import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:studentmanagementbloc/apis/api.dart';
import 'package:studentmanagementbloc/student/student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    final Api api = Api();

    on<FetchStudents>((event, emit) async {
      emit(StudentLoading());
      try{
      final List<Student> student = await api.fetchStudents();
      if(student.isNotEmpty){
      emit(StudentLoaded(students: student));
      }else{
        emit(StudentEmpty());
      }
      }catch(e){
        emit(StudentError(error: 'failed to fetch students'));
      }
    });

    on<AddStudent>((event, emit) async {
      emit(StudentLoading());
      await api.addStudents(event.student);
      final List<Student> updatedStudents = await api.fetchStudents();
      emit(StudentLoaded(students: updatedStudents));
    });

    on<PickImage>((event, emit) async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = pickedFile.path;
        emit(ImagePicked(imagePath: image));
      }
    });
    on<ClearImage>((event, emit) {
      emit(StudentInitial());
    });

    on<DeleteStudent>((event, emit) async {
      try {
        await api.deleteStudent(event.studentId);
        final List<Student> updatedStudents = await api.fetchStudents();
        emit(StudentLoaded(students: updatedStudents));
      } catch (e) {
        emit(StudentError(error: 'failed to delete'));
      }
    });
    on<PatchStudent>((event, emit) async {
      emit(StudentLoading());
      try {
        await api.updateStudent(event.studentId, event.student);
        final List<Student> updatedStudents = await api.fetchStudents();
        emit(StudentLoaded(students: updatedStudents));
      } catch (e) {
        emit(StudentError(error: 'Failed to update student: $e'));
      }
    });

    on<SearchStudents>((event, emit) async {
      emit(StudentLoading());
      try {
        if (event.query.isEmpty) {
          final List<Student> studen = await api.fetchStudents();
          emit(StudentLoaded(students: studen));
        } else {
          final List<Student> stud = await api.searchStudent(event.query);
          emit(StudentLoaded(students: stud));
        }
      } catch (e) {
        emit(StudentError(error: 'Failed to search students: $e'));
      }
    });
  }
}
