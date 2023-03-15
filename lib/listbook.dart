import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'editbook.dart';

class ListBook extends StatefulWidget {
  const ListBook({super.key});

  @override
  State<ListBook> createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  CollectionReference _bookCollection = FirebaseFirestore.instance.collection('DBbook');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายการหนังสือ')),
      body: StreamBuilder(
        stream: _bookCollection.snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length, //นับจำนวนข้อมูลทั้งหมด
            itemBuilder: ((context, index) {
              var bookIndex = snapshot.data!.docs[index];
              return ListTile(
                  title: Row(
                children: [
                  Text(bookIndex['bookname']), 
                  Spacer(),
                  GestureDetector(
                      child: Container(
                        child: Icon(Icons.edit),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) {
                                return EditForm();
                              }),
                              settings: RouteSettings(
                                  arguments: bookIndex.reference.id)),
                        );
                      }),
                  GestureDetector(
                    child: Container(
                      child: Icon(Icons.delete),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: Text('ยืนยัน'),
                              content: Text('คุณต้องการลบข้อมูลหรือไม่'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('ยกเลิก')),
                                TextButton(
                                    onPressed: () async {
                                      await _bookCollection
                                          .doc(bookIndex.reference.id)
                                          .delete();
                                      Navigator.pop(context);
                                    },
                                    child: Text('ลบข้อมูล')),
                              ],
                            )),
                      );
                    },
                  ),
                ],
              ));
            }),
          );
        }),
      ),
    );
  }
}
