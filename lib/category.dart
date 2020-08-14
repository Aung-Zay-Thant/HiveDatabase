import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String code;

  @HiveField(2)
  DateTime created;

  @HiveField(3)
  bool synced = false;
}
