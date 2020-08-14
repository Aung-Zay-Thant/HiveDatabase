import 'package:db_testing/adNewCategory.dart';
import 'package:db_testing/categories_list.dart';
import 'package:db_testing/category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddNewCategopry();
            },
          );
        },
      ),
    );
  }
}

Widget _buildWithBox(BuildContext context, Box settings, Widget child) {
  var reversed = settings.get('reversed', defaultValue: true) as bool;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Category", style: TextStyle(fontSize: 20)),
          IconButton(
            icon: Icon(reversed ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              settings.put("reversed", !reversed);
            },
          ),
        ],
      ),
      Expanded(
        child: ValueListenableBuilder(
            valueListenable: Hive.box<Category>("category").listenable(),
            builder: (context, box, _) {
              var category = box.values.toList().cast<Category>();
              if (reversed) {
                category = category.reversed.toList();
              }
              return CategoriesList(category);
            }),
      )
    ],
  );
}
