import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final formKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference _bookCollection = FirebaseFirestore.instance.collection('DBbook');
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบฟอร์มเพิ่มข้อมูล'),
      ),
      body: Form(
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
                  onPressed: () {
                    var bookname = bookNameController.text;
                    var price = priceController.text;
                    _bookCollection.add({'bookname': bookname,'price': price});
                  },
                  child: Text('เพิ่มข้อมูล'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
