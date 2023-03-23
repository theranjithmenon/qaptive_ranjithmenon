import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qaptive_ranjithmenon/views/home/weather_details.dart';
import 'package:qaptive_ranjithmenon/views/widgets/map_widget.dart';
import '../../api/api.dart';
import '../../functions/location.dart';

class RouteToUser extends StatefulWidget {
  const RouteToUser(
      {super.key,
      required this.userLat,
      required this.userLong,
      required this.userEmail});
  final double userLat;
  final double userLong;
  final String userEmail;

  @override
  State<RouteToUser> createState() => _RouteToUserState();
}

class _RouteToUserState extends State<RouteToUser> {
  double? long;
  double? lat;
  var weatherData;
  bool isLoaded = false;

  getLocation() {
    Future<Position> data = UserLocation().determinePosition();
    data.then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
    });
  }

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
    var markers = {
      Marker(
          markerId: const MarkerId('Current Loction'),
          position: LatLng(lat!, long!)),
      Marker(
          markerId: const MarkerId('Destination Loction'),
          position: LatLng(widget.userLat, widget.userLong)),
    };
    var polyines = {
      Polyline(polylineId: const PolylineId('Route'), points: [
        LatLng(lat!, long!),
        LatLng(widget.userLat, widget.userLong)
      ])
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userEmail,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          googleMapWidget(LatLng(lat!, long!),
              LatLng(widget.userLat, widget.userLong), markers, polyines),
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
      ),
    );
  }

  toCelcius(k) {
    return (k - 273.15).toInt();
  }
}
