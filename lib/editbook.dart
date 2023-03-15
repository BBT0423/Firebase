import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final formKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final priceController = TextEditingController();

  CollectionReference _bookCollection =
      FirebaseFirestore.instance.collection('DBbook');

  @override
  Widget build(BuildContext context) {
    final bookIndex = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('ฟอร์มแก้ไขข้อมูล'),
      ),
      body: StreamBuilder(
        stream: _bookCollection.doc(bookIndex.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var bookDetail = snapshot.data;
          final bookNameController =
              TextEditingController(text: bookDetail!.get('bookname'));
          final priceController =
              TextEditingController(text: bookDetail.get('price'));
          return Form(
            key: formKey,
            child: Center(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: bookNameController,
                      decoration: InputDecoration(
                        label: Text('ชื่อหนังสือ'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        label: Text('ราคา'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //สร้างตัวแปรสำหรับเก็บข้อมูลจาก TextFormField
                        var bookName = bookNameController.text;
                        var price = priceController.text;

                        //แก้ไขข้อมูลใน DB
                        await _bookCollection.doc(bookIndex.toString()).set({
                          'bookName': bookName,
                          'price': price,
                        });

                        Navigator.pop(context);
                      },
                      child: Text('แก้ไขข้อมูล'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
