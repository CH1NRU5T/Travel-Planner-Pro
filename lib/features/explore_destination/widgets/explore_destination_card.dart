import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';

class ExploreDestinationCard extends StatelessWidget {
  const ExploreDestinationCard(
      {super.key,
      required this.src,
      required this.name,
      required this.avgTravelExpenses});
  final String src;
  final String name;
  final String avgTravelExpenses;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(src),
                fit: BoxFit.cover,
              ),
            ),
          ),
          10.height,
          FittedBox(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          10.height,
          FittedBox(
            child: Text(
              avgTravelExpenses,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
