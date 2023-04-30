class Drink{
  final int IdBoisson;
  final String nomBoisson;
  final double tarif;
  final String description;
  final String image;
  final double eau;
  final double cafe;
  final double lait;
  final double the;
  final double sucre;
  final int idDistributeur;


  Drink({
    required this.description,
    required this.image,
    required this.eau,
    required this.cafe,
    required this.lait,
    required this.the,
    required this.sucre,
    required this.idDistributeur,
    required this.IdBoisson, required this.nomBoisson, required this.tarif});
  factory Drink.fromJson(Map<String, dynamic> json) {
    print(json['tarif'].runtimeType);
    return Drink(
      IdBoisson: json['idBoisson'] as int,
      tarif: (json['tarif'] as int).toDouble() ,
      nomBoisson: json['nomBoisson'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      eau: (json['eau']as int).toDouble(),
      cafe: (json['cafe'] as int).toDouble(),
      lait: (json['lait'] as int).toDouble(),
      the: (json['the'] as int).toDouble(),
      sucre: (json['sucre'] as int).toDouble(),
      idDistributeur: json['isDistributeur'] as int,

    );
  }
}