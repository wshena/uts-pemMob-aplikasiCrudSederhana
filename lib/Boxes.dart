import 'package:hive/hive.dart';

import 'Model/userModel.dart';

// Generate boxes for hive
class Boxes {
  static Box<PatientModel> getUsers() => Hive.box('patients');
}
