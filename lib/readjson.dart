import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<Map<String,Instructors>> loadJsonData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/instructors.json');
      Map<String,Instructors> AllInstructor = {};
      Map <String, dynamic> temp = json.decode(jsonString)["Instructors"];
      print(temp);
      temp.forEach((key, value) {
        print(key);
        AllInstructor[key] = (Instructors(key, value["Max-Weight"], value["Min-Weight"]));
      });

      return AllInstructor;
    } catch (e) {
      print('Error loading JSON data: $e');
      return {}; // Return an empty map in case of an error
    }
  }
}


class Instructors{
  String name;
  int maxWeight;
  int minWeight;

  Instructors(this.name, this.maxWeight, this.minWeight);
}