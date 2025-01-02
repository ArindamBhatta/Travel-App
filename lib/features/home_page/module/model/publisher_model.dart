class PublisherModel {
  String? continent;
  String? country;
  String? imageUrl;
  String? knownFor;
  String? name;
  String? ref;
  List<String>? tags;

  PublisherModel({
    this.continent,
    this.country,
    this.knownFor,
    this.imageUrl,
    this.name,
    this.ref,
    this.tags,
  });

  PublisherModel.fromJsonNameConstructor(Map<String, dynamic> json) {
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
    return 'DestinationModel(name: ${name ?? 'null'})';
  }
}
