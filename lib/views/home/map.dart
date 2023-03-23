import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qaptive_ranjithmenon/firebase/to_firebase.dart';
import 'package:qaptive_ranjithmenon/functions/location.dart';

import '../../api/api.dart';
import '../widgets/map_widget.dart';
import 'weather_details.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? long;
  double? lat;
  bool isLoaded = false;
  var weatherData;

  getLocation() {
    Future<Position> data = UserLocation().determinePosition();
    data.then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
        isLoaded = true;
      });
    });
  }

  LatLng? currentPosition;
  getData() async {
    weatherData = await ApiConnection().getData();
    if (weatherData != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      setState(() {
        isLoaded = false;
      });
    }
  }

  @override
  void initState() {
    getLocation();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //adds the user location to firebase and gets updated everytime the app loads.
    ToFirebase().addLocation(lat, long);
    currentPosition = LatLng(lat!, long!);
    var marker = {
      Marker(
          markerId: const MarkerId('Current Loction'),
          position: LatLng(lat!, long!))
    };
    var polyline = {
      Polyline(polylineId: const PolylineId('route'), points: [
        LatLng(lat!, long!),
        LatLng(lat!, long!),
      ])
    };
    if (isLoaded) {
      return Stack(
        children: [
          googleMapWidget(currentPosition, currentPosition, marker, polyline),
          Positioned(
              right: 20,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherDetails()));
                },
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.cloud),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${toCelcius(weatherData['main']['temp']).toString()} \u2103",
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            weatherData['weather'][0]['main'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  toCelcius(k) {
    return (k - 273.15).toInt();
  }
}
