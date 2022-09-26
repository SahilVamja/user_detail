import 'package:flutter/material.dart';
import 'package:user_detail/Common_Widgets/common_textfield.dart';
import 'package:user_detail/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DataBaseHelper.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void insertData() async {
    Map<String, dynamic> row = {
      DataBaseHelper.colFirstName: _firstNameController.text,
      DataBaseHelper.colLastName: _lastNameController.text,
      DataBaseHelper.colPhoneNumber: _phoneNumberController.text,
      DataBaseHelper.colEmail: _emailController.text,
      DataBaseHelper.colAddress: _addressController.text,
    };
    final id = await dbHelper.insert(row);
    print("User Table === $id");
    Fluttertoast.showToast(msg: id.toString());
  }

  void delete() async {
    var id = await dbHelper.delete(1);
    print(id);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() {
    if (formKey.currentState!.validate()) {
      insertData;
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  // autovalidateMode: AutovalidateMode.always,
                  key: formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                        labelText: "FirstName",
                        controller: _firstNameController,
                        type: TextInputType.name,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "FirstName Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CommonTextField(
                        controller: _lastNameController,
                        type: TextInputType.name,
                        labelText: "LastName",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "LastName Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CommonTextField(
                        controller: _phoneNumberController,
                        type: TextInputType.number,
                        labelText: "PhoneNumber",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "PhoneNumber Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CommonTextField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        labelText: "Email",
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "Email Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CommonTextField(
                        controller: _addressController,
                        labelText: "Address",
                        type: TextInputType.name,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "Address Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  validate();
                },
                child: Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.red,
                  child: const Center(
                      child: Text(
                    "INSERT",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  delete;
                },
                child: Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
