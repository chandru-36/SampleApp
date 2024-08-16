
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController{

  RxList employeeData=[].obs;

Future<List<String>>? getEmployees() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
 List<String> data= await prefs.getStringList("EmployeeData") ?? [];

 employeeData.value=data;

 return data;

}

Future<bool>? addEmployee(String name) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

 List<String> data= await prefs.getStringList("EmployeeData") ?? [];

 data.add(name);

 await prefs.setStringList("EmployeeData", data);

 getEmployees();
  
return true;
}


Future<bool>? deleteEmployee(int index) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

 List<String> data= await prefs.getStringList("EmployeeData") ?? [];

 data.removeAt(index);
 print(data);

 await prefs.setStringList("EmployeeData", data);
 getEmployees();
  
return true;
}


Future<bool>? editEmployee(int index,String name) async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();

 List<String> data= await prefs.getStringList("EmployeeData") ?? [];


data[index]=name;

 await prefs.setStringList("EmployeeData", data);

 getEmployees();
  
return true;
}

}