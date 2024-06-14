import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagementbloc/apis/api.dart';
import 'package:studentmanagementbloc/bloc/student_bloc.dart';
import 'package:studentmanagementbloc/constants/colors.dart';
import 'package:studentmanagementbloc/screens/home.dart';
import 'package:studentmanagementbloc/screens/widgets/formfield.dart';
import 'package:studentmanagementbloc/student/student.dart';

class AddStudents extends StatelessWidget {
  final Api api = Api();
  AddStudents({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Add Student',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                icon: const Icon(
                  Icons.person,
                ))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      BlocBuilder<StudentBloc, StudentState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              context.read<StudentBloc>().add(PickImage());
                            },
                            child: state is ImagePicked
                                ? Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      radius: 70,
                                      backgroundImage:
                                          FileImage(File(state.imagePath)),
                                    ),
                                  )
                                : const Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      radius: 70,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: kWhite,
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                      kHeight,
                      textformfield('Name', nameController),
                      kHeight,
                      textformfield('Roll Number', rollNumberController,
                          keyBoardType: TextInputType.number),
                      kHeight,
                      textformfield('age', ageController,
                          keyBoardType: TextInputType.number),
                      kHeight,
                      textformfield(
                        'department',
                        departmentController,
                      ),
                      kHeight,
                      textformfield(
                        'phone',
                        phoneNumberController,
                        keyBoardType: TextInputType.phone
                      ),
                      kHeight,
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: BlocBuilder<StudentBloc, StudentState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()&&state is ImagePicked) {
                                      context.read<StudentBloc>().add(
                                          AddStudent(Student(
                                              id: '',
                                              name: nameController.text,
                                              rollNo: rollNumberController.text,
                                              age: ageController.text,
                                              department:
                                                  departmentController.text,
                                              phone: phoneNumberController.text,
                                              image: state.imagePath)));
                                    
                                    nameController.clear();
                                    rollNumberController.clear();
                                    ageController.clear();
                                    departmentController.clear();
                                    phoneNumberController.clear();
                                    context
                                        .read<StudentBloc>()
                                        .add(ClearImage());

                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('successfully added')));
                                                                       Navigator.of(context).pop();

                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'please fill everything')));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                ),
                                child: const Text(
                                  'Add Student',
                                ),
                              );
                            },
                          ))
                    ])))));
  }
}
