import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/controller/controller.dart';

class Addemployee extends StatefulWidget {
  String? name;
  int? id;

  Addemployee({Key? key, this.name, this.id}) : super(key: key);

  @override
  _AddemployeeState createState() => _AddemployeeState();
}

class _AddemployeeState extends State<Addemployee> {
  final _employee = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AppController());

  @override
  void initState() {
    // TODO: implement initState
    init_calls();
    super.initState();
  }

  init_calls() {
    if (widget.name != null) {
      _employee.text = widget.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name == null ? "Add Employee" : "Edit Employee",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _employee,
                validator: (value) {
                  if (value == null) {
                    return "Enter employee name";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Here"),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.name != null) {
                      bool? result = await controller.editEmployee(
                          widget.id!, _employee.text);

                      if (result!) {
                        // Get.snackbar("Success", "Edited Successfully");
                        Get.back();
                      }
                    } else {
                      bool? result =
                          await controller.addEmployee(_employee.text);

                      if (result!) {
                        Get.back();
                      }
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: Get.width,
                  color: Colors.teal,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
