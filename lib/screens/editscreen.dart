import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagementbloc/bloc/student_bloc.dart';
import 'package:studentmanagementbloc/constants/colors.dart';
import 'package:studentmanagementbloc/screens/widgets/formfield.dart';
import 'package:studentmanagementbloc/student/student.dart';

class EditScreen extends StatelessWidget {
  final Student student;

  EditScreen({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameController =
        TextEditingController(text: student.name);
    final TextEditingController rollNumberController =
        TextEditingController(text: student.rollNo);
    final TextEditingController ageController =
        TextEditingController(text: student.age);
    final TextEditingController departmentController =
        TextEditingController(text: student.department);
    final TextEditingController phoneController =
        TextEditingController(text: student.phone);
    String? imagePath = student.image;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text('Edit Screen'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                    child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Image cant be edited',
                        ),
                        backgroundColor: Colors.red,
                      ));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 70,
                      backgroundImage: NetworkImage(imagePath!),
                    ),
                  ),
                  kHeight,
                  textformfield('Name', nameController),
                  kHeight,
                  textformfield('Roll Number', rollNumberController),
                  kHeight,
                  textformfield('Age', ageController),
                  kHeight,
                  textformfield('Department', departmentController),
                  kHeight,
                  textformfield('Phone', phoneController),
                  kHeight,
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final updata = student.copyWith(
                                name: nameController.text,
                                rollNo: rollNumberController.text,
                                age: ageController.text,
                                department: departmentController.text,
                                phone: phoneController.text,
                              );
                              context.read<StudentBloc>().add(
                                  PatchStudent(updata, int.parse(student.id!)));
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Save Changes',
                          )))
                ])))));
  }
}
