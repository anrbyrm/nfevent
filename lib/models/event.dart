class Event {
  final String? name;
  final String? image;
  final String? description;
  final String? eventType;
  final String? blurHash;
  final String? date;
  final int? participants;
  final double? rating;
  final double? price;

  const Event({
    this.name,
    this.image,
    this.description,
    this.eventType,
    this.blurHash,
    this.date,
    this.participants,
    this.rating,
    this.price,
  });

  @override
  String toString() =>
      '''Event (name: $name, image: $image, description: $description, eventType: $eventType, blurHash: $blurHash, date: $date, participants: $participants, rating: $rating, price: $price''';
}

class EventModel extends Event {
  const EventModel({
    String? name,
    String? image,
    String? description,
    String? eventType,
    String? blurHash,
    String? date,
    int? participants,
    double? rating,
    double? price,
  }) : super(
          name: name,
          image: image,
          description: description,
          eventType: eventType,
          blurHash: blurHash,
          date: date,
          participants: participants,
          rating: rating,
          price: price,
        );

  factory EventModel.fromJson(Map<dynamic, dynamic> json) => EventModel(
        name: json['name'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
        eventType: json['event_type'] as String,
        participants: json['participants'] as int,
        rating: json['rating'] as double,
        price: json['price'] as double,
        blurHash: json['blur_hash'] as String,
        date: json['date'] as String,
      );
}
