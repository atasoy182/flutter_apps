import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Not Sepeti"),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => {
              showDialog(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Kategori Adı",
                                border: OutlineInputBorder(),
                              ),
                              validator: (girilenKategoriAdi) {
                                if (girilenKategoriAdi.length < 3) {
                                  return "En az üç karekter giriniz !";
                                } else {
                                  return "";
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
                              onPressed: () {},
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
                  })
            },
            mini: true,
            tooltip: "Kategori Ekle",
            child: Icon(Icons.add_circle),
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: "Not Ekle",
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
