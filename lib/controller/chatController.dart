import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatAppController extends GetxController {
  RxList chatdata = [].obs;

  Future<List<String>>? getChats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> data = await prefs.getStringList("ChatData") ?? [];

    chatdata.value = data;

    return data;
  }

  Future<bool>? addChat(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> data = await prefs.getStringList("ChatData") ?? [];

    data.add(name);

    await prefs.setStringList("ChatData", data);

    getChats();

    return true;
  }
}
