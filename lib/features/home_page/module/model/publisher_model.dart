class PublisherModel {
  String? id;
  String? continent;
  String? country;
  String? imageUrl;
  String? knownFor;
  String? name;
  String? ref;
  List<String>? tags;

  PublisherModel({
    this.id,
    this.continent,
    this.country,
    this.knownFor,
    this.imageUrl,
    this.name,
    this.ref,
    this.tags,
  });

  PublisherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    continent = json['continent'];
    country = json['country'];
    knownFor = json['knownFor'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    ref = json['ref'];
    tags = json['tags'].cast<String>();
  }

  @override
  String toString() {
    return 'DestinationModel(name: ${id ?? 'null'})';
  }
}
