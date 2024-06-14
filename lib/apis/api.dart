import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:studentmanagementbloc/student/student.dart';

class Api {
  static const String url = "http://studentapp.ashkar.tech";

  Future<List<Student>> fetchStudents() async {
    final response = await http
        .get(Uri.parse(url), headers: {'x-api-key': 'apikey@studentapp'});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['after exicution'];
      List<Student> students =
          data.map((json) => Student.fromJson(json)).toList();
      return students;
    } else {
      throw Exception('failed to fetch students');
    }
  }

  Future<void> addStudents(Student student) async {
    final headers = {
      "x-api-key": "apikey@studentapp",
    };

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      request.fields['name'] = student.name ?? '';
      request.fields['roll_no'] = student.rollNo ?? '';
      request.fields['age'] = student.age ?? '';
      request.fields['department'] = student.department ?? '';
      request.fields['phone'] = student.phone ?? '';
      if (student.image != null && student.image!.isNotEmpty) {
        File imageFile = File(student.image!);
        if (imageFile.existsSync()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'image',
              imageFile.path,
            ),
          );
        } else {
          throw Exception('image file doesnot exist at path:${student.image}');
        }
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Student added successfully');
      } else {
        throw Exception(
            'Failed to add student. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding student: $e');
      throw Exception('Failed to add student: $e');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    final headers = {
      "x-api-key": "apikey@studentapp",
      "Content-Type": "application/json"
    };
    try {
      final response = await http.delete(Uri.parse(url),
          headers: headers, body: jsonEncode({"id": studentId}));
      if (response.statusCode == 200) {
        print('student deleted successfully');
      } else {
        throw Exception(
            'failed to delete student.Status code:${response.statusCode}');
      }
    } catch (e) {
      print('error deleting student:$e');
    }
  }

  Future<void> updateStudent(int studentId, Student student) async {
    final headers = {
      "x-api-key": "apikey@studentapp",
      "Content-Type": "application/json"
    };

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "id": studentId,
          "name": student.name,
          "roll_no": int.parse(student.rollNo!),
          "age": int.parse(student.age!),
          "department": student.department,
          "phone": student.phone
        }),
      );

      if (response.statusCode == 200) {
        print('Student updated successfully');
      } else {
        throw Exception(
            'Failed to update student. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating student: $e');
      throw Exception('Failed to update student: $e');
    }
  }

  Future<List<Student>> searchStudent(String query) async {
    final response = await http.get(Uri.parse('$url/search?q=$query'),
        headers: {'x-api-key': 'apikey@studentapp'});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['after exicution'];
      List<Student> students =
          data.map((json) => Student.fromJson(json)).toList();
      return students;
    } else {
      throw Exception('failed to fetch students');
    }
  }
}
