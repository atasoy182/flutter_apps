import 'package:crud_app/not_detay.dart';
import 'package:crud_app/utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/kategori.dart';
import 'models/notlar.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: NotListesi(),
    );
  }
}

class NotListesi extends StatelessWidget {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Center(
            child: Text("Not Sepeti"),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => {kategoriEkle(context)},
              heroTag: "KategoriEkle",
              mini: true,
              tooltip: "Kategori Ekle",
              child: Icon(Icons.add_circle),
            ),
            FloatingActionButton(
              onPressed: () => _detaySayfasinaGit(context),
              heroTag: "NotEkle",
              tooltip: "Not Ekle",
              child: Icon(Icons.add),
            ),
          ],
        ),
        body: Notlar());
  }

  Future kategoriEkle(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String yeniKategoriAdi = "";
    return showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Ekle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (girilendeger) {
                      yeniKategoriAdi = girilendeger;
                    },
                    decoration: InputDecoration(
                      labelText: "Kategori Adı",
                      border: OutlineInputBorder(),
                    ),
                    validator: (girilenKategoriAdi) {
                      if (girilenKategoriAdi.length < 3) {
                        return "En az üç karekter giriniz !";
                      }
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.orangeAccent,
                    child: Text(
                      "Vazgeç",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      // save
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        databaseHelper
                            .kategoriEkle(Kategori(yeniKategoriAdi))
                            .then((eklenenKategoriID) {
                          if (eklenenKategoriID > 0) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Kategori eklendi"),
                              duration: Duration(seconds: 2),
                            ));
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    color: Colors.greenAccent,
                    child: Text(
                      "Kaydet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  _detaySayfasinaGit(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotDetay(baslik: "Yeni Not")));
  }
}

class Notlar extends StatefulWidget {
  @override
  _NotlarState createState() => _NotlarState();
}

class _NotlarState extends State<Notlar> {
  List<Not> tumNotlar;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumNotlar = List<Not>();
    databaseHelper = DatabaseHelper();
    // future builder kullanarak yapalım.
//    databaseHelper.notlariGetir().then((notlariicerenmaplistesi) {
//      for (Map map in notlariicerenmaplistesi) {
//        tumNotlar.add(Not.fromMap(map));
//      }
//      setState(() {});
//    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: databaseHelper.notListesiniGetir(),
      builder: (context, AsyncSnapshot<List<Not>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumNotlar = snapshot.data;

          return ListView.builder(
              itemCount: tumNotlar.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(tumNotlar[index].notBaslik),
                  leading: _oncelikIconuAta(tumNotlar[index].notOncelik),
                  //subtitle: Text(tumNotlar[index].kategoriBaslik),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Kategori:",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tumNotlar[index].kategoriBaslik,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Oluşturulma Tarihi:",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  databaseHelper.dateFormat(DateTime.parse(
                                      tumNotlar[index].notTarih)),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "İçerik:" + tumNotlar[index].notIcerik,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _oncelikIconuAta(int notOncelik) {
    switch (notOncelik) {
      case 0:
        return CircleAvatar(
          child: Text(
            "AZ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade100,
        );
        break;
      case 1:
        return CircleAvatar(
          child: Text("ORTA", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red.shade200,
        );

        break;
      case 2:
        return CircleAvatar(
          child: Text("ACİL", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red.shade700,
        );
        break;
    }
  }
}
