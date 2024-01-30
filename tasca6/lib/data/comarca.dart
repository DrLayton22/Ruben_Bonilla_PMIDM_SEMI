class Comarca {
  String comarca;
  String? capital;
  String? poblacio;
  String? img;
  String? desc;
  double? latitud;
  double? longitud;
  Future<Comarca>? future;

  Comarca({
    required this.comarca,
    this.capital,
    this.poblacio,
    this.img,
    this.desc,
    this.latitud,
    this.longitud,
    this.future,
  });

  Comarca.fromJSON(Map<String, dynamic> json)
      : comarca = json['nom'] ?? '', // Use an empty string if 'nom' is null
        img = json['img'] == 'null' ? null : json['img'], // Check for "null"
        capital = json['capital'] == 'null'
            ? null
            : json['capital'], // Check for "null"
        desc = json['desc'] == 'null' ? null : json['desc'], // Check for "null"
        poblacio = json['poblacio'] == 'null'
            ? null
            : json['poblacio'], // Check for "null"
        latitud = json['latitud']?.toDouble(),
        longitud = json['longitud']?.toDouble();

  Comarca.nom(String nom) : comarca = nom;

  @override
  String toString() {
    return '''
{
  "comarca": "$comarca",
  "capital": "$capital",
  "poblacio": "$poblacio",
  "img": "$img",
  "desc": "$desc",
  "latitud": $latitud,
  "longitud": $longitud
}
''';
  }
}
