import 'dart:convert';

class Destination {
  String destinationName;
  String id;
  String cityName;
  String latitude;
  String longitude;
  bool isSaved;
  List<dynamic> landmarks;
  String state;
  String description;
  List<dynamic> images;
  String avgTravelExpenses;
  List<dynamic> attractions;
  String category;
  Destination({
    this.isSaved = false,
    required this.id,
    required this.destinationName,
    required this.cityName,
    required this.latitude,
    required this.longitude,
    required this.landmarks,
    required this.state,
    required this.description,
    required this.images,
    required this.avgTravelExpenses,
    required this.attractions,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isSaved': isSaved,
      'destinationName': destinationName,
      'cityName': cityName,
      'latitude': latitude,
      'longitude': longitude,
      'landmarks': landmarks,
      'state': state,
      'description': description,
      'images': images,
      'avgTravelExpenses': avgTravelExpenses,
      'attractions': attractions,
      'category': category,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'] as String,
      destinationName: map['destinationName'] as String,
      cityName: map['cityName'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      landmarks: map['landmarks'] as List<dynamic>,
      state: map['state'] as String,
      description: map['description'] as String,
      images: map['images'] as List<dynamic>,
      avgTravelExpenses: map['avgTravelExpenses'] as String,
      attractions: map['attractions'] as List<dynamic>,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Destination.fromJson(String source) =>
      Destination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Destination(destinationName: $destinationName, id:$id, cityName: $cityName, latitude: $latitude, longitude: $longitude, landmarks: $landmarks, state: $state, description: $description, images: $images, avgTravelExpenses: $avgTravelExpenses, attractions: $attractions, category: $category, isSaved: $isSaved)';
  }
}
