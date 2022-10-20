import 'package:flutter/material.dart';
import 'package:hive_crud/Model/userModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Pages/HiveDBPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // inisialisasi hive
  Hive.registerAdapter(PatientModelAdapter()); // register adapter
  await Hive.openBox<PatientModel>('patients'); // openbox patient database
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PATIENTS DATA',
      home: HiveDBPage(),
    );
  }
}
