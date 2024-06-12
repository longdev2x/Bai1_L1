import 'package:exercies1/models/student.dart';
import 'package:exercies1/widgets/row_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Student> students = [
    const Student(id: 1, name: "Nhật Long", school: "FPT Polytechnic"),
    const Student(id: 2, name: "Long Hoàng", school: "Polytecnic FPT"),
    const Student(id: 3, name: "Hoàng Long", school: "Poly"),
    const Student(id: 4, name: "Nhật Hoàng", school: "Thái Nguyên HighSchool"),
    const Student(id: 5, name: "Long Nhật", school: "Sa Lung School"),
    const Student(id: 6, name: "Hoàng Nhật", school: "FPT Polytechnic"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Sinh Viên",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return _alertDialog(context: context);
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(students[index].id),
                onDismissed: (direction) {
                  setState(() {
                    students.remove(students[index]);
                  });
                },
                background: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: RowList(
                  student: students[index],
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) =>
                            _alertDialog(context: context, position: index));
                  },
                ),
              );
            }),
      ),
    );
  }

  Widget _alertDialog({required BuildContext context, int? position}) {
    String name = '';
    String school = '';
    int id = 0;
    final GlobalKey<FormState> key = GlobalKey();
    return AlertDialog(
      title: position != null
          ? const Text("Add Student")
          : const Text("Update Student"),
      titleTextStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black),
      contentTextStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      content: SizedBox(
        width: double.infinity,
        height: position != null ? 170 : 220,
        child: Form(
          key: key,
          child: Column(children: [
            position != null
                ? Text("ID: ${students[position].id}")
                : TextFormField(
                    decoration: const InputDecoration(hintText: "Nhập id"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập số từ ký tự";
                      }
                      try {
                        id = int.parse(value);
                      } on FormatException catch (e) {
                        return e.message;
                      }
                      return null;
                    },
                  ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Họ và Tên"),
              initialValue: position != null ? students[position].name : null,
              validator: (value) {
                if (value == null || value.length <= 5) {
                  return "Vui lòng nhập lớn hơn 5 ký tự";
                }
                return null;
              },
              onSaved: (newValue) {
                name = newValue!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Trường"),
              initialValue: position != null ? students[position].school : null,
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Vui lòng nhập lớn hơn 4 ký tự";
                }
                return null;
              },
              onSaved: (newValue) {
                school = newValue!;
              },
            ),
          ]),
        ),
      ),
      actions: [
        ElevatedButton.icon(
            onPressed: () {
              if (!key.currentState!.validate()) return;
              key.currentState!.save();
              if (position != null) {
                setState(() {
                  students[position].copyWith(name: name, school: school);
                });
                Navigator.of(context).pop();
                return;
              }
              setState(() {
                students = [
                  ...students,
                  Student(id: id, name: name, school: school)
                ];
              });
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.add),
            label: const Text("Submit")),
        ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cancel),
            label: const Text("Cancle")),
      ],
    );
  }
}
