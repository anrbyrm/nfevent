class Creator {
  const Creator({this.name, this.image, this.description, this.blurHash});

  final String? name;
  final String? image;
  final String? description;
  final String? blurHash;

  @override
  String toString() =>
      '''Creator (name: $name, image: $image, description: $description, blurHash: $blurHash)''';
}

class CreatorModel extends Creator {
  CreatorModel({
    String? name,
    String? image,
    String? description,
    String? blurHash,
  }) : super(
          name: name,
          image: image,
          description: description,
          blurHash: blurHash,
        );

  factory CreatorModel.fromJson(Map<dynamic, dynamic> json) => CreatorModel(
        name: json['name'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
        blurHash: json['blur_hash'] as String,
      );
}
