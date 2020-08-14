import 'package:db_testing/category.dart';
import 'package:db_testing/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: FutureBuilder(
            future: Future.wait([
              Hive.openBox('settings'),
              Hive.openBox<Category>("category"),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text('Something went wrong :/'),
                    ),
                  );
                } else {
                  return CategoryScreen();
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: Text("Opening Hive..."),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
