import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'send_or_update_data_screen.dart';

class ResepPage extends StatefulWidget {
  ResepPage({Key? key}) : super(key: key);
  @override
  State<ResepPage> createState() => _ResepPageState();
}

class _ResepPageState extends State<ResepPage> {
  void _showDetailedView(String nama, String bahan, String langkah) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nama),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bahan: \n$bahan\n'),
              Text('Langkah: \n$langkah'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SendOrUpdateData()),
          );
        },
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(
          'Resep Makanan',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      drawer: const Sidemenu(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('resep').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    final nama = streamSnapshot.data!.docs[index]['nama'];
                    final bahan =
                        streamSnapshot.data!.docs[index]['bahan'].toString();
                    final langkah = streamSnapshot.data!.docs[index]['langkah'];

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.food_bank,
                                size: 31,
                                color: Colors.blue.shade300,
                              ),
                              SizedBox(width: 11),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nama,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    // Call the method to show the detailed view in a modal
                                    _showDetailedView(nama, bahan, langkah);
                                  },
                                  child: const Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
                                    size: 21,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SendOrUpdateData(
                                        nama: nama,
                                        bahan: bahan,
                                        langkah: langkah,
                                        id: streamSnapshot.data!.docs[index]
                                            ['id'],
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 21,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 21,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Hapus Resep'),
                                          content: const Text(
                                              'Apakah Anda yakin mau menghapus resep?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResepPage(),
                                                  ),
                                                );
                                              },
                                              child: const Text('Tidak'),
                                            ),
                                            TextButton(
                                                child: const Text('Ya'),
                                                onPressed: () async {
                                                  final docData =
                                                      FirebaseFirestore.instance
                                                          .collection('resep')
                                                          .doc(streamSnapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['id']);
                                                  await docData.delete();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResepPage(),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                )
              : Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}
