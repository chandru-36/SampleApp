import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sample/controller/chatController.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  bool Loading = true;

  final controller = Get.put(ChatAppController());

  @override
  void initState() {
    // TODO: implement initState
    initcalls();
    super.initState();
  }

  initcalls() async {
    await controller.getChats();
    setState(() {
      Loading = false;
    });
  }

  final _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Messages",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        height: Get.height,
        width: Get.width,
        color: Colors.lightGreen[50],
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.chatdata.value.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: controller.chatdata.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                            alignment: index.isEven
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: Container(
                              //width: 200,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: index.isEven
                                      ? Colors.white
                                      : Colors.cyan),
                              child: Text(
                                controller.chatdata.value[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: Get.width,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _message,
                      decoration: InputDecoration(
                          hintText: "Enter Message",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_message.text.isNotEmpty) {
                        await controller.addChat(_message.text);
                        _message.text = "";
                      }
                    },
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.teal,
                      size: 35,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
