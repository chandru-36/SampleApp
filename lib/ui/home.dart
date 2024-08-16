import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/UI/addemployee.dart';
import 'package:sample/UI/chatApp.dart';
import 'package:sample/controller/controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool Loading = true;

  final controller = Get.put(AppController());

  @override
  void initState() {
    // TODO: implement initState
    initcalls();
    super.initState();
  }

  initcalls() async {
    await controller.getEmployees();
    setState(() {
      Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Addemployee());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Employees",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(ChatApp());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.teal),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                "Chat App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(25),
        child: Loading
            ? const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              )
            : Obx(
                () => controller.employeeData.value.length > 0
                    ? ListView.builder(
                        itemCount: controller.employeeData.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: Get.width,
                            color: Colors.teal[50],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  controller.employeeData.value[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Get.to(Addemployee(
                                        name: controller
                                            .employeeData.value[index],
                                        id: index,
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      bool? result = await controller
                                          .deleteEmployee(index);
                                      if (result!) {
                                        Get.snackbar(
                                            "Success", "Deleted Successfully");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          );
                        })
                    : const Center(
                        child: Text(
                        "No Data",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      )),
              ),
      ),
    );
  }
}
