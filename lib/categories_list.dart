import 'package:db_testing/category.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categoriesList;
  CategoriesList(this.categoriesList);
  @override
  Widget build(BuildContext context) {
    if (categoriesList.isEmpty) {
      return Center(
        child: Text('No Categories....'),
      );
    } else {
      return ListView.builder(
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext context, int indext) {
          var category = categoriesList[indext];
          return _buildCategory(category);
        },
      );
    }
  }

  Widget _buildCategory(Category category) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text("Code: " + category.code),
                    SizedBox(width: 20),
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: category.synced ? Colors.blue : Colors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${category.created.year}/${category.created.month}/${category.created.day}  ${category.created.hour}:${category.created.minute}:'
                  '${category.created.second}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              iconSize: 30,
              icon: Icon(category.synced ? Icons.clear : Icons.check),
              onPressed: () {
                category.synced = !category.synced;
                category.save();
              },
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.delete),
              onPressed: () {
                category.delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
