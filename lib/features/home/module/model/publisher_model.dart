class PublisherModel {
  String? id;
  int? viewCount;
  int? wishCount;
  String? continent;
  String? country;
  String? imageUrl;
  String? knownFor;
  String? name;
  String? ref;
  List<String>? tags;

  PublisherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    viewCount = json['viewCount'];
    wishCount = json['wishCount'];
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
    return 'DestinationModel(name: ${name ?? null})';
  }
}
