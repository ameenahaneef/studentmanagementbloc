import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagementbloc/bloc/student_bloc.dart';
import 'package:studentmanagementbloc/screens/addstudent.dart';
import 'package:studentmanagementbloc/screens/dialog.dart';
import 'package:studentmanagementbloc/screens/editscreen.dart';
import 'package:studentmanagementbloc/student/student.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<StudentBloc>().add(FetchStudents());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Student List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddStudents();
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                context.read<StudentBloc>().add(SearchStudents(value));
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33)),
                  hintText: 'Search Here'),
            ),
            Expanded(
              child: BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StudentEmpty) {
                    return const Center(
                      child: Text(
                        'No students',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is StudentError) {
                    return const Center(
                      child: Text('No Students Found'),
                    );
                  } else if (state is StudentLoaded) {
                    List<Student> students = state.students;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.5 / 0.9,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        var student = students[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 3,
                            color: const Color.fromARGB(255, 203, 153, 119),
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(student.image!),
                                      ),
                                    ),
                                    Text('Id: ${student.id}'),
                                    Text('Name: ${student.name}'),
                                    Text('Rollno: ${student.rollNo}'),
                                    Text('Age: ${student.age}'),
                                    Text('Department: ${student.department}'),
                                    Text('Phone: ${student.phone}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EditScreen(
                                                    student: student);
                                              }));
                                            },
                                            icon: Icon(Icons.edit)),
                                        IconButton(
                                          onPressed: () {
                                            dialog(context, student);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
