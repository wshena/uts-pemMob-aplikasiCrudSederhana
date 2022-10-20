import 'package:hive/hive.dart';

part 'userModel.g.dart';

// Generate fields for hive
@HiveType(typeId: 0)
class PatientModel extends HiveObject {
  @HiveField(0)
  late String patient_id;

  @HiveField(1)
  late String patient_name;

  @HiveField(2)
  late String patient_age;

  @HiveField(3)
  late String patient_address;

  @HiveField(4)
  late String patient_bloodType;

  @HiveField(5)
  late String patient_diagnose;
}
