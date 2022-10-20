import 'package:flutter/material.dart';
import 'package:hive_crud/Boxes.dart';
import 'package:hive_crud/Comm/getTextFormField.dart';
import 'package:hive_crud/Model/userModel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDBPage extends StatefulWidget {
  const HiveDBPage({Key? key}) : super(key: key);

  @override
  State<HiveDBPage> createState() => _HiveDBPageState();
}

class _HiveDBPageState extends State<HiveDBPage> {
  final _formKey = GlobalKey<FormState>(); // global formkey

  // text controler for database field
  final conId = TextEditingController();
  final conName = TextEditingController();
  final conAge = TextEditingController();
  final conAddress = TextEditingController();
  final conDiagnose = TextEditingController();
  final conBloodType = TextEditingController();

  @override
  void dispose() {
    Hive.close(); // Closing All Boxes

    //Hive.box('users').close();// Closing Selected Box

    super.dispose();
  }

  // add user function
  Future<void> addUser(String uId, String uName, String uAge, String uAddress,
      uBloodType, uDiagnose) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = PatientModel()
        ..patient_id = uId
        ..patient_name = uName
        ..patient_age = uAge
        ..patient_address = uAddress
        ..patient_bloodType = uBloodType
        ..patient_diagnose = uDiagnose;

      final box = Boxes.getUsers();
      //Key Auto Increment
      box.add(user).then((value) => clearPage());
    }
  }

  // function to edit user
  Future<void> editUser(PatientModel patietnModel) async {
    conId.text = patietnModel.patient_id;
    conName.text = patietnModel.patient_name;
    conAge.text = patietnModel.patient_age;
    conAddress.text = patietnModel.patient_address;
    conBloodType.text = patietnModel.patient_bloodType;
    conDiagnose.text = patietnModel.patient_diagnose;

    // deleter the privous object
    deleteUser(patietnModel);
  }

  // delete function
  Future<void> deleteUser(PatientModel patientModel) async {
    patientModel.delete();
  }

  // delete form controler, make form empty
  clearPage() {
    conId.text = '';
    conName.text = '';
    conAge.text = '';
    conAddress.text = '';
    conBloodType.text = '';
    conDiagnose.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final controler = ScrollController();

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.list_rounded),
          backgroundColor: Colors.black,
          elevation: 0,
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.person),
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Container(
                child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
                  child: const Text(
                    "HELLO ADMIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 40),
                  child: const Text(
                    "Add Patient Data TO This Form",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            )),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  generateTextFormField(
                    controller: conName,
                    hintName: "Patient Name",
                  ),
                  const SizedBox(height: 10),
                  generateTextFormField(controller: conAge, hintName: "Age"),
                  const SizedBox(height: 10),
                  generateTextFormField(
                    controller: conAddress,
                    hintName: "Patient Addresss",
                  ),
                  const SizedBox(height: 10),
                  generateTextFormField(
                    controller: conBloodType,
                    hintName: "Patient BloodType",
                  ),
                  const SizedBox(height: 10),
                  generateTextFormField(
                    controller: conDiagnose,
                    hintName: "Patient Diagnosis",
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () => addUser(
                                conId.text,
                                conName.text,
                                conAge.text,
                                conAddress.text,
                                conBloodType.text,
                                conDiagnose.text),
                            child: const Text(
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                            // color: Colors.black26,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: clearPage,
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.white),
                            ),
                            // color: Colors.black26,
                          ),
                        )
                      ],
                    ),
                  ),
                  // box for list view
                  SizedBox(
                      height: 500,
                      child: ValueListenableBuilder(
                        valueListenable: Boxes.getUsers().listenable(),
                        builder:
                            (BuildContext context, Box box, Widget? child) {
                          final users =
                              box.values.toList().cast<PatientModel>();

                          return genContent(users);
                        },
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // generate list view
  Widget genContent(List<PatientModel> patient) {
    if (patient.isEmpty) {
      return const Center(
        child: Text(
          "No Patient Found",
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: patient.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text(
                    patient[index].patient_name.toUpperCase(),
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Age : ${patient[index].patient_age}"),
                          SizedBox(height: 10),
                          Text("Addres : ${patient[index].patient_address}"),
                          SizedBox(height: 10),
                          Text(
                              "Blood Type : ${patient[index].patient_bloodType}"),
                          SizedBox(height: 10),
                          Text("Diagnos : ${patient[index].patient_diagnose}"),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () => editUser(patient[index]),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => deleteUser(patient[index]),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }
  }
}
