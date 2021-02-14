class Kategori {
  int kategoriID;
  String kategoriBaslik;

  // Kategori eklerken kullanılır.
  Kategori(this.kategoriBaslik);

  // Databaseden veri çekilirken kullanılır.
  Kategori.withID(this.kategoriID, this.kategoriBaslik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kategoriID'] = kategoriID;
    map['kategoriBaslik'] = kategoriBaslik;
    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    this.kategoriID = map['kategoriID'];
    this.kategoriBaslik = map['kategoriBaslik'];
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $kategoriID, kategoriBaslik: $kategoriBaslik}';
  }
}
