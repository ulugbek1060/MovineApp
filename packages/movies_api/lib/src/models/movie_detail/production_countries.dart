part of 'movie_detail_response.dart';

class ProductionCountries {
  late final String? iso31661;
  late final String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) :
    iso31661 = json['iso_3166_1'],
    name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}