import 'package:flutter/material.dart';

class DestinationContainer extends StatelessWidget {
  const DestinationContainer(
      {super.key,
      required this.src,
      required this.placeName,
      required this.averageTravelExpenses,
      required this.onTap,
      required this.index});
  final String src;
  final Function(int) onTap;
  final int index;
  final String placeName;
  final String averageTravelExpenses;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(src),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      child: Text(
                    placeName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 21),
                  )),
                  const Divider(),
                  FittedBox(
                      child: Text(
                    averageTravelExpenses,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  )),
                ],
              ),
            ),
          ),
        ),

        // Stack(children: [
        //   Image.network(widget.src),

        //   // TODO: change to cached network image
        //   Container(
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(14),
        //           bottomRight: Radius.circular(14)),
        //     ),
        //     height: MediaQuery.sizeOf(context).height * 0.7,
        //     width: MediaQuery.sizeOf(context).width * 1,
        //     child: Column(
        //       children: [
        //         Text(widget.placeName),
        //         Text(widget.averageTravelExpenses),
        //       ],
        //     ),
        //   ),

        //   // Column(
        //   //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   //   children: [
        //   //     const Expanded(
        //   //       child: SizedBox(),
        //   //     ),
        //   //     Expanded(
        //   //       flex: 2,
        //   //       child: Container(
        //   //         decoration: const BoxDecoration(
        //   //           color: Colors.white,
        //   //           borderRadius: BorderRadius.only(
        //   //             bottomLeft: Radius.circular(14),
        //   //             bottomRight: Radius.circular(14),
        //   //           ),
        //   //         ),
        //   //         child: Column(
        //   //           children: [
        //   //             Text(widget.placeName),
        //   //             const Divider(),
        //   //             Text(widget.averageTravelExpenses),
        //   //           ],
        //   //         ),
        //   //       ),
        //   //     ),
        //   //   ],
        //   // )
        // ]),
      ),
    );
  }
}
