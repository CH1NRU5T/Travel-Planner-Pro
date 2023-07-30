import 'dart:convert';

class Itinerary {
  String planName;
  String id;
  String destination;
  DateTime travelStartDate;
  DateTime travelEndDate;
  String travelMode;
  List<DateAndDetail> items;
  int estimatedCost;
  Itinerary({
    required this.id,
    required this.planName,
    required this.destination,
    required this.travelStartDate,
    required this.travelEndDate,
    required this.travelMode,
    required this.items,
    required this.estimatedCost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planName': planName,
      'destination': destination,
      'travelStartDate': travelStartDate.millisecondsSinceEpoch,
      'travelEndDate': travelEndDate.millisecondsSinceEpoch,
      'travelMode': travelMode,
      'id': id,
      'details': items.map((e) => e.toMap()).toList(),
      'estimatedCost': estimatedCost,
    };
  }

  factory Itinerary.fromMap(Map<String, dynamic> map) {
    return Itinerary(
      id: map['id'] as String,
      planName: map['planName'] as String,
      destination: map['destination'] as String,
      travelStartDate: DateTime.parse(map['travelStartDate'] as String),
      travelEndDate: DateTime.parse(map['travelEndDate'] as String),
      travelMode: map['travelMode'] as String,
      items: (map['details'] as List<dynamic>)
          .map((e) => DateAndDetail.fromMap(e as Map<String, dynamic>))
          .toList(),
      estimatedCost: map['estimatedCost'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Itinerary.fromJson(String source) =>
      Itinerary.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DateAndDetail {
  DateTime date;
  String dayDetail;
  DateAndDetail({
    required this.date,
    required this.dayDetail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'dayDetail': dayDetail,
    };
  }

  factory DateAndDetail.fromMap(Map<String, dynamic> map) {
    return DateAndDetail(
      date: DateTime.parse(map['date'] as String),
      dayDetail: map['dayDetail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DateAndDetail.fromJson(String source) =>
      DateAndDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
