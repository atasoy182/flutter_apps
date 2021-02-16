import 'package:crud_app/models/kategori.dart';
import 'package:crud_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

class NotDetay extends StatefulWidget {
  String baslik;

  NotDetay({this.baslik});

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  List<Kategori> tumKategoriler = [];
  DatabaseHelper databaseHelper;
  int kategoriID = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((kategoriMapListesi) {
      for (Map map in kategoriMapListesi) {
        tumKategoriler.add(Kategori.fromMap(map));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.baslik)),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Center(
              child: tumKategoriler.length <= 0
                  ? CircularProgressIndicator()
                  : DropdownButton<int>(
                      value: kategoriID,
                      items: kategoriItemOlustur(),
                      onChanged: (secilenKategoriID) {
                        setState(() {
                          kategoriID = secilenKategoriID;
                        });
                      }),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
              value: kategori.kategoriID,
              child: Text(
                kategori.kategoriBaslik,
                style: TextStyle(fontSize: 32),
              ),
            ))
        .toList();
  }
}
