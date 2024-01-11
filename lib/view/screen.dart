// ListTile(
//                                 title: Text(employee['name']),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           DocumentSnapshot employee =
//                                               snapshot.data!.docs[index];
//                                           HomeController()
//                                               .deleteEmployee(id: employee.id);
//                                         },
//                                         icon: Icon(
//                                           Icons.delete,
//                                           color: Colors.red,
//                                         )),
//                                     IconButton(
//                                         onPressed: () {
//                                           updateNameController.text =
//                                               employee['name'];
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                 title: Text('Enter Text'),
//                                                 content: TextField(
//                                                   controller:
//                                                       updateNameController,
//                                                   decoration: InputDecoration(
//                                                       border:
//                                                           OutlineInputBorder(),
//                                                       hintText: 'Update Name'),
//                                                 ),
//                                                 actions: [
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                     child: Text('Cancel'),
//                                                   ),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       HomeController()
//                                                           .updateEmployee(
//                                                               id: employee.id,
//                                                               name:
//                                                                   updateNameController
//                                                                       .text
//                                                                       .trim());
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                       updateNameController
//                                                           .clear();
//                                                     },
//                                                     child: Text('Update'),
//                                                   ),
//                                                 ],
//                                               );
//                                             },
//                                           );
//                                         },
//                                         icon: Icon(
//                                           Icons.edit,
//                                           color: Colors.black,
//                                         ))
//                                   ],
//                                 ),
//                               ),