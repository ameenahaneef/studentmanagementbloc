import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagementbloc/bloc/student_bloc.dart';
import 'package:studentmanagementbloc/student/student.dart';

Future<dynamic> dialog(BuildContext context, Student student) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancel')),
            TextButton(
                onPressed: () {
                  context
                      .read<StudentBloc>()
                      .add(DeleteStudent(int.parse(student.id!)));
                  Navigator.of(context).pop();
                },
                child: const Text('delete'))
          ],
        );
      });
}
