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
      tarif: (json['tarif'] is int)?json['tarif'].toDouble():json['tarif'],
      nomBoisson: json['nomBoisson'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      eau: (json['eau'] is int)?json['eau'].toDouble():json['eau'],
      cafe: (json['cafe'] is int)?json['cafe'].toDouble():json['cafe'],
      lait: (json['lait'] is int)?json['lait'].toDouble():json['lait'],
      the: (json['the'] is int)?json['the'].toDouble():json['the'],
      sucre: (json['sucre'] is int)?json['sucre'].toDouble():json['sucre'],
      idDistributeur: json['isDistributeur'] as int,

    );
  }
}