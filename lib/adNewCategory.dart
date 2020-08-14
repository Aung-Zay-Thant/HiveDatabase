import 'package:db_testing/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddNewCategopry extends StatefulWidget {
  @override
  _AddNewCategopryState createState() => _AddNewCategopryState();
}

class _AddNewCategopryState extends State<AddNewCategopry> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: codeController,
              decoration: InputDecoration(hintText: "Code"),
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "cancle",
              style: TextStyle(color: Colors.blue),
            )),
        FlatButton(
            onPressed: () {
              var category = Category()
                ..name = nameController.text
                ..code = codeController.text
                ..created = DateTime.now();
              Hive.box<Category>("category").add(category);
              Navigator.of(context).pop();
            },
            child: Text("add", style: TextStyle(color: Colors.blue)))
      ],
    );
  }
}
