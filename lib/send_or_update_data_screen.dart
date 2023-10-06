import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/resep_page.dart';
import 'package:flutter/material.dart';

class SendOrUpdateData extends StatefulWidget {
  final String nama;
  final String bahan;
  final String langkah;
  final String id;
  const SendOrUpdateData(
      {this.nama = '', this.bahan = '', this.langkah = '', this.id = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController namaController = TextEditingController();
  TextEditingController bahanController = TextEditingController();
  TextEditingController langkahController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    namaController.text = widget.nama;
    bahanController.text = widget.bahan;
    langkahController.text = widget.langkah;
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
    bahanController.dispose();
    langkahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Resep',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Masakan',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(hintText: 'Ayam Kecap'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Bahan',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: bahanController,
              decoration: InputDecoration(hintText: 'Ayam'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Langkah-langkah',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: langkahController,
              decoration: InputDecoration(
                  hintText:
                      'Siapkan Bahan terlebih dahulu, Masak dengan benar'),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (namaController.text.isEmpty ||
                    bahanController.text.isEmpty ||
                    langkahController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fill in all fields')),
                  );
                } else {
                  // Reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('resep')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'nama': namaController.text,
                    'bahan': bahanController.text,
                    'langkah': langkahController.text,
                    'id': docID,
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                    await dUser.set(jsonData).then((value) {
                      namaController.text = '';
                      bahanController.text = '';
                      langkahController.text = '';
                      showProgressIndicator = false;
                      setState(() {});

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResepPage()),
                      );
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      namaController.text = '';
                      bahanController.text = '';
                      langkahController.text = '';
                      showProgressIndicator = false;
                      setState(() {});

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResepPage()),
                      );
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.blue.shade400,
              child: showProgressIndicator
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
