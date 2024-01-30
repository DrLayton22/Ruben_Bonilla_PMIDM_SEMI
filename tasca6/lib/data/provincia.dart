class Provincia {
  final String nom;
  final String img;

  Provincia({required this.nom, required this.img});

  factory Provincia.fromJson(Map<String, dynamic> json) {
    return Provincia(
      nom: json['provincia'],
      img: json['img'],
    );
  }
}
