class Drink{
  final int IdBoisson;
  final int idDistributeur;
  final String nomBoisson;
  final int tarif;

  Drink({required this.IdBoisson, required this.idDistributeur, required this.nomBoisson, required this.tarif});
  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      IdBoisson: json['idBoisson'] as int,
      idDistributeur: json['idDistributeur'] as int,
      tarif: json['tarif'] as int,
      nomBoisson: json['nomBoisson'] as String,
    );
  }
}