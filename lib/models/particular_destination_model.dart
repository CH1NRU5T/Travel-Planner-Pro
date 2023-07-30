// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:travel_planner_pro/models/destination_model.dart';
import 'package:travel_planner_pro/models/review_model.dart';

class ParticularDestination {
  Destination? destination;
  String currentWeather;
  double currentTemperature;
  String weatherIcon;
  List<Review> reviews;
  ParticularDestination({
    this.destination,
    required this.reviews,
    required this.currentWeather,
    required this.currentTemperature,
    required this.weatherIcon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'destination': destination?.toMap(),
      'currentWeather': currentWeather,
      'currentTemperature': currentTemperature,
      'weatherIcon': weatherIcon,
      'reviews': reviews,
    };
  }

  factory ParticularDestination.fromMap(Map<String, dynamic> map) {
    return ParticularDestination(
      destination: map['destination'] != null
          ? Destination.fromMap(map['destination'] as Map<String, dynamic>)
          : null,
      currentWeather: map['currentWeather'] as String,
      currentTemperature: map['currentTemperature'] as double,
      weatherIcon: map['weatherIcon'] as String,
      reviews: map['reviews'] as List<Review>,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParticularDestination.fromJson(String source) =>
      ParticularDestination.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParticularDestination(destination: $destination, currentWeather: $currentWeather, currentTemperature: $currentTemperature, weatherIcon: $weatherIcon, reviews: $reviews)';
  }
}
