class DestinationModel {
  String? continent;
  String? country;
  String? imageUrl;
  String? knownFor;
  String? name;
  String? ref;
  List<String>? tags;

  DestinationModel({
    this.continent,
    this.country,
    this.knownFor,
    this.imageUrl,
    this.name,
    this.ref,
    this.tags,
  });

  DestinationModel.fromJson(Map<String, dynamic> json) {
    continent = json['continent'];
    country = json['country'];
    knownFor = json['knownFor'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    ref = json['ref'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['continent'] = this.continent;
    data['country'] = this.country;
    data['knownFor'] = this.knownFor;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['ref'] = this.ref;
    data['tags'] = this.tags;
    return data;
  }
}
