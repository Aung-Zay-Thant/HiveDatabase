import 'package:db_testing/category.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  final List<Category> categoriesList;
  CategoriesList(this.categoriesList);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.categoriesList.isEmpty) {
      return Center(
        child: Text('No Categories....'),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columns: [
              DataColumn(label: Text("Code")),
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("UpdateTime")),
              DataColumn(label: Text("Syncesd")),
              DataColumn(label: Text("Delete"))
            ],
            rows: widget.categoriesList
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.code), onTap: () {
                        if (e.code != null) {
                          nameController.text = e.name;
                          codeController.text = e.code;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Update Code"),
                                  content: Form(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (input) =>
                                                input.trim().isEmpty
                                                    ? "Please enter name."
                                                    : null,
                                            keyboardType: TextInputType.number,
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                hintText: "Name"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (input) =>
                                                input.trim().isEmpty
                                                    ? "Please enter code."
                                                    : null,
                                            keyboardType: TextInputType.number,
                                            controller: codeController,
                                            decoration: InputDecoration(
                                                hintText: "Code"),
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
                                        onPressed: () {
                                          e.code = codeController.text;
                                          e.name = nameController.text;
                                          e.created = DateTime.now();
                                          e.save().then((value) {
                                            codeController.clear();
                                            nameController.clear();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Update",
                                            style:
                                                TextStyle(color: Colors.blue)))
                                  ],
                                );
                              });
                        }
                      }),
                      DataCell(
                        Text(e.name,
                            style: TextStyle(
                                color: e.synced ? Colors.green : Colors.black)),
                      ),
                      DataCell(Text(
                          "${e.created.year}.${e.created.month}.${e.created.day} ${e.created.hour}:${e.created.minute}:${e.created.second}")),
                      DataCell(IconButton(
                          icon: Icon(
                            e.synced ? Icons.clear : Icons.check,
                            color: e.synced ? Colors.green : Colors.red,
                          ),
                          onPressed: () {
                            e.synced = !e.synced;
                            e.save();
                          })),
                      DataCell(IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => e.delete()))
                    ]))
                .toList()),
      );
    }
  }
}
