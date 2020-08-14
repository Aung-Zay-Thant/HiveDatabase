import 'package:db_testing/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddNewCategopry extends StatefulWidget {
  @override
  _AddNewCategopryState createState() => _AddNewCategopryState();
}

class _AddNewCategopryState extends State<AddNewCategopry> {
  _addCategory() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var category = Category()
        ..name = nameController.text
        ..code = codeController.text
        ..created = DateTime.now();
      Hive.box<Category>("category").add(category);
      Navigator.of(context).pop();
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Category"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (input) =>
                    input.trim().isEmpty ? "Please enter name." : null,
                autofocus: true,
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (input) =>
                    input.trim().isEmpty ? "Please enter code." : null,
                keyboardType: TextInputType.number,
                controller: codeController,
                decoration: InputDecoration(hintText: "Code"),
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancle",
              style: TextStyle(color: Colors.blue),
            )),
        FlatButton(
            onPressed: () => _addCategory(),
            child: Text("Add", style: TextStyle(color: Colors.blue)))
      ],
    );
  }
}
