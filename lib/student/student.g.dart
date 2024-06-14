// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      name: json['name'] as String?,
      rollNo: json['roll_no'] as String?,
      age: json['age'] as String?,
      department: json['department'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roll_no': instance.rollNo,
      'age': instance.age,
      'department': instance.department,
      'phone': instance.phone,
      'image': instance.image,
    };
