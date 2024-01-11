import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseoperations/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/widgets.dart' as pw;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNUmberController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updatePhController = TextEditingController();
  Future<void> _downloadDataAsPdf(List<DocumentSnapshot> employees) async {
    final pdf = pw.Document();

    for (var employee in employees) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Name: ${employee['name']}'),
                pw.Text('Email: ${employee['email']}'),
                pw.Text('Phone Number: ${employee['ph']}'),
                pw.SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/employees.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the PDF file
    // You can use your preferred method to open the file, for example, share it or use a package like 'open_file'.
    // For simplicity, we just print the path here.
    print('PDF saved at: ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Firebase Operations"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneNUmberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Phone Number",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      HomeController().addEmployee(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          phoneNUmberController.text.trim());
                      nameController.clear();
                      emailController.clear();
                      phoneNUmberController.clear();
                    },
                    child: Text("Add Employee"),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      final snapshot =
                          await HomeController().employeeCollection.get();
                      final employees = snapshot.docs;
                      await _downloadDataAsPdf(employees);
                    },
                    child: Text("Download"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: HomeController().employeeCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot employee =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(employee['name']),
                                      subtitle: Text(employee['email']),
                                      trailing: Text(employee['ph'].toString()),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              DocumentSnapshot employee =
                                                  snapshot.data!.docs[index];
                                              HomeController().deleteEmployee(
                                                  id: employee.id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              updateNameController.text =
                                                  employee['name'];
                                              updateEmailController.text =
                                                  employee['email'];
                                              updatePhController.text =
                                                  employee['ph'].toString();
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Enter Text'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              updateNameController,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Update Name'),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              updateEmailController,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Update Email'),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              updatePhController,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Update Phone Number'),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          HomeController().updateEmployee(
                                                              id: employee.id,
                                                              updatename:
                                                                  updateNameController
                                                                      .text
                                                                      .trim(),
                                                              updateemail:
                                                                  updateEmailController
                                                                      .text
                                                                      .trim(),
                                                              updatephoneNumber:
                                                                  updatePhController
                                                                      .text
                                                                      .trim());
                                                          Navigator.of(context)
                                                              .pop();
                                                          updateNameController
                                                              .clear();
                                                        },
                                                        child: Text('Update'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
