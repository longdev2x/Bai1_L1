class Student {
  final int id;
  final String name;
  final String school;

  const Student({
    required this.id,
    required this.name,
    required this.school,
  });

  Student copyWith({int? id, String? name, String? school}) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      school: school ?? this.school,
    );
  }
}
