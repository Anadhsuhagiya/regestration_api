import 'package:shared_preferences/shared_preferences.dart';

class Model
{
  static SharedPreferences? prefs;

  static List<String> category = [
    "All",
    "Electronics",
    "Mobiles",
    "Men's Wear",
    "Ladies Wear",
    "Child's Wear",
    "Groceries",
    "Toys",
    "Books",
  ];

}