import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {
  CollectionReference employeeCollection =
      FirebaseFirestore.instance.collection('employees');

  void addEmployee(String name,String email,String phoneNumber) {
    employeeCollection
        .add({
          'name': name,
          'email':email,
          'ph':phoneNumber
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void deleteEmployee({required String id}) {
    
    employeeCollection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  void updateEmployee({required String id, required String updatename,required String updateemail,required String updatephoneNumber}) {
    employeeCollection
        .doc(id)
        .update(
          {
            'name': updatename,
            'email':updateemail,
          'ph':updatephoneNumber
          },
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
