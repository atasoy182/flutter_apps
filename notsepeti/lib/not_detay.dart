import 'package:crud_app/models/kategori.dart';
import 'package:crud_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'models/notlar.dart';

class NotDetay extends StatefulWidget {
  String baslik;
  Not duzenlenecekNot;

  NotDetay({this.baslik, this.duzenlenecekNot});

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  List<Kategori> tumKategoriler = [];
  DatabaseHelper databaseHelper;
  int kategoriID;
  int secilenOncelik;
  String notBaslik, notIcerik;

  static var _oncelik = ["Düşük", "Orta", "Yüksek"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((kategoriMapListesi) {
      if (kategoriMapListesi != null) {
        for (Map map in kategoriMapListesi) {
          tumKategoriler.add(Kategori.fromMap(map));
        }
      }

      if (widget.duzenlenecekNot == null) {
        kategoriID = 1;
        secilenOncelik = 0;
      } else {
        kategoriID = widget.duzenlenecekNot.kategoriID;
        secilenOncelik = widget.duzenlenecekNot.notOncelik;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(title: Text(widget.baslik)),
        body: tumKategoriler.length <= 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Kategori:",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 24),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              items: kategoriItemOlustur(),
                              value: kategoriID,
                              onChanged: (secilenKategoriID) {
                                setState(() {
                                  kategoriID = secilenKategoriID;
                                });
                              },
                            )),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            initialValue: widget.duzenlenecekNot != null
                                ? widget.duzenlenecekNot.notBaslik
                                : "",
                            validator: (text) {
                              if (text.length < 3) {
                                return "En az 3 Karakter giriniz!";
                              }
                            },
                            onSaved: (text) => notBaslik = text,
                            decoration: InputDecoration(
                              hintText: "Not Başlığını Giriniz:",
                              labelText: "Başlık",
                              border: OutlineInputBorder(),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            initialValue: widget.duzenlenecekNot != null
                                ? widget.duzenlenecekNot.notIcerik
                                : "",
                            maxLines: 4,
                            onSaved: (text) => notIcerik = text,
                            decoration: InputDecoration(
                              hintText: "Not İçeriğini Giriniz:",
                              labelText: "İçerik",
                              border: OutlineInputBorder(),
                            )),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Öncelik:",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 24),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                              items: _oncelik.map((oncelik) {
                                return DropdownMenuItem<int>(
                                  child: Text(
                                    oncelik,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  value: _oncelik.indexOf(oncelik),
                                );
                              }).toList(),
                              value: secilenOncelik,
                              onChanged: (secilenOncelikID) {
                                setState(() {
                                  secilenOncelik = secilenOncelikID;
                                });
                              },
                            )),
                          )
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Vazgeç"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                var suan = DateTime.now();
                                print("111111111111111111");
                                if (widget.duzenlenecekNot == null) {
                                  print("222222222222222222222222");

                                  databaseHelper
                                      .notEkle(Not(
                                          kategoriID,
                                          notBaslik,
                                          notIcerik,
                                          suan.toString(),
                                          secilenOncelik))
                                      .then((kaydedilenNotID) {
                                    if (kaydedilenNotID != 0) {
                                      Navigator.pop(context);
                                    }
                                  });
                                } else {
                                  print("333333333333333333333333");

                                  databaseHelper
                                      .notGuncelle(Not.withID(
                                          widget.duzenlenecekNot.notID,
                                          kategoriID,
                                          notBaslik,
                                          notIcerik,
                                          suan.toString(),
                                          secilenOncelik))
                                      .then((value) {
                                    print("val:" + value.toString());
                                    if (value != 0) {
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              }
                            },
                            child: Text("Kaydet"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }

  List<DropdownMenuItem<int>> kategoriItemOlustur() {
    if (tumKategoriler.length > 0) {
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
}
