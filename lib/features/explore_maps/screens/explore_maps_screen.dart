import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/explore_maps/widgets/destination_container.dart';

import '../../../models/destination_model.dart';
import '../../../providers/map_provider.dart';

class ExploreMapsScreen extends StatefulWidget {
  const ExploreMapsScreen({super.key});

  @override
  State<ExploreMapsScreen> createState() => _ExploreMapsScreenState();
}

class _ExploreMapsScreenState extends State<ExploreMapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  (String?, List<Destination>?)? locationList;
  @override
  void initState() {
    super.initState();
    fetchLocationList();
  }

  void onTap(int index) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(double.parse(locationList!.$2![index].latitude),
                double.parse(locationList!.$2![index].longitude)),
            zoom: 14.4746),
      ),
    );
  }

  void fetchLocationList() {
    context.read<MapProvider>().fetchLocationList(context).then((value) {
      locationList = value;
      if (value.$1 == null) {
        makeMarkers(value.$2);
      }
      setState(() {});
    });
  }

  (List<Marker>?, List<CameraPosition>?) makeMarkers(
      List<Destination>? destinations) {
    List<Marker> markers = [];
    List<CameraPosition> cameraPositions = [];
    for (var element in destinations!) {
      markers.add(Marker(
        markerId: MarkerId(element.destinationName),
        position: LatLng(
          double.parse(element.latitude),
          double.parse(element.longitude),
        ),
        infoWindow: InfoWindow(
          title: element.destinationName,
          snippet: element.cityName,
        ),
      ));
      cameraPositions.add(CameraPosition(
        target: LatLng(
          double.parse(element.latitude),
          double.parse(element.longitude),
        ),
        zoom: 14.4746,
      ));
    }
    return (markers, cameraPositions);
  }

  @override
  Widget build(BuildContext context) {
    return locationList == null
        ? const Loader()
        : locationList!.$1 == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers:
                          Set<Marker>.of(makeMarkers(locationList!.$2!).$1!),
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(locationList!.$2!.first.latitude),
                          double.parse(
                            locationList!.$2!.first.longitude,
                          ),
                        ),
                        zoom: 14.4746,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: CarouselSlider.builder(
                          itemCount: locationList!.$2!.length,
                          itemBuilder: (context, index, realIndex) {
                            return DestinationContainer(
                                index: index,
                                onTap: (int val) {
                                  onTap(val);
                                },
                                src: locationList!.$2![index].images.first,
                                placeName:
                                    locationList!.$2![index].destinationName,
                                averageTravelExpenses:
                                    locationList!.$2![index].avgTravelExpenses);
                          },
                          options: CarouselOptions(
                            viewportFraction: 1 / 4,
                            scrollPhysics: const BouncingScrollPhysics(),
                            enableInfiniteScroll: false,
                          ))
                      // FlutterCarousel.builder(
                      //   itemCount: locationList!.$2!.length,
                      //   itemBuilder: (context, index, realIndex) {
                      // return DestinationContainer(
                      //     src: locationList!.$2![index].images.first,
                      //     placeName: locationList!.$2![index].destinationName,
                      //     averageTravelExpenses:
                      //         locationList!.$2![index].avgTravelExpenses);
                      //   },
                      //   options: CarouselOptions(
                      //     disableCenter: true,
                      //     physics: const BouncingScrollPhysics(),
                      //     viewportFraction: 0.3,
                      //     scrollDirection: Axis.horizontal,
                      //   ),
                      // ),
                      )
                ],
              )
            : Text(locationList!.$1!);
  }
}
