import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'roll_no')
  String? rollNo;

  @JsonKey(name: 'age')
  String? age;

  @JsonKey(name: 'department')
  String? department;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'image')
  String? image;

  Student({
    this.id,
    this.name,
    this.rollNo,
    this.age,
    this.department,
    this.phone,
    this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rollNo: json['roll_no'] ?? '',
      age: json['age'] ?? '',
      department: json['department'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }

  get error => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roll_no": rollNo,
        "age": age,
        "department": department,
        "phone": phone,
        "image": image
      };

Student copyWith({
  String? name,
  String? rollNo,
  String? age,
  String? department,
  String? phone

}){
  return Student(
    name: name??this.name,
    rollNo: rollNo??this.rollNo,
    age:age??this.age,
    department: department??this.department,
    phone: phone??this.phone

  );
}
}