import 'package:crud_app/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'models/kategori.dart';

class Kategoriler extends StatefulWidget {
  @override
  _KategorilerState createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (tumKategoriler == null) {
      tumKategoriler = List<Kategori>();
      kategorileriGuncelle();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler"),
      ),
      body: ListView.builder(
          itemCount: tumKategoriler.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tumKategoriler[index].kategoriBaslik),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () => _kategoriSil(tumKategoriler[index].kategoriID),
              ),
              leading: Icon(Icons.category),
              onTap: () => _kategoriGuncelle(tumKategoriler[index], context),
            );
          }),
    );
  }

  void kategorileriGuncelle() {
    databaseHelper.kategoriListesiniGetir().then((kategoriIcerenList) {
      setState(() {
        tumKategoriler = kategoriIcerenList;
      });
    });
  }

  _kategoriSil(int kategoriID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Kategori Sil"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Kategoriyi Sildiğinizde Tüm Notlar Silinecektir, Emin Misiniz ?"),
                ButtonBar(
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Vazgeç")),
                    FlatButton(
                        onPressed: () {
                          databaseHelper.kategoriSil(kategoriID).then((value) {
                            if (value != 0) {
                              setState(() {
                                kategorileriGuncelle();
                                Navigator.of(context).pop();
                              });
                            }
                          });
                        },
                        child: Text(
                          "Kategoriyi Sil",
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }

  _kategoriGuncelle(Kategori guncellencekKategori, BuildContext c) {
    kategoriGuncelle(c, guncellencekKategori);
  }

  Future kategoriGuncelle(
      BuildContext myContext, Kategori guncellencekKategori) {
    var formKey = GlobalKey<FormState>();
    String guncellenecekKategoriAdi;
    return showDialog(
        context: myContext,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Güncelle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: guncellencekKategori.kategoriBaslik,
                    onSaved: (girilendeger) {
                      guncellenecekKategoriAdi = girilendeger;
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
                      Navigator.pop(myContext);
                    },
                    color: Colors.orangeAccent,
                    child: Text(
                      "Vazgeç",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        databaseHelper
                            .kategoriGuncelle(Kategori.withID(
                                guncellencekKategori.kategoriID,
                                guncellenecekKategoriAdi))
                            .then((value) {
                          if (value >= 0) {
                            Scaffold.of(myContext).showSnackBar(SnackBar(
                              content: Text("Kategori Güncellendi"),
                              duration: Duration(seconds: 1),
                            ));
                            kategorileriGuncelle();
                            Navigator.pop(myContext);
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
}
