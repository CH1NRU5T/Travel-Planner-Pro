// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Review {
  String id;
  String destination_id;
  String userId;
  String reviewerName;
  double rating;
  String review;
  DateTime date;
  Review({
    required this.id,
    required this.destination_id,
    required this.reviewerName,
    required this.userId,
    required this.rating,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'destination_id': destination_id,
      'userId': userId,
      'rating': rating,
      'review': review,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String,
      destination_id: map['destination_id'] as String,
      userId: map['userId'] as String,
      rating: map['rating'] as double,
      review: map['review'] as String,
      date: DateTime.parse(map['date'] as String),
      reviewerName: map['reviewerName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, destination_id: $destination_id, userId: $userId, rating: $rating, review: $review, date: $date, reviewerName: $reviewerName)';
  }
}
