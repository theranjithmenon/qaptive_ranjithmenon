import 'package:flutter/material.dart';
import 'package:qaptive_ranjithmenon/api/api.dart';

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key});

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  var weatherData;
  bool isLoaded = false;
  @override
  void initState() {
    getData();
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('From API'),
        ),
        body: isLoaded
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temp : ${toCelcius(weatherData['main']['temp'])} \u2103',
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      'Place : ${weatherData['name']}',
                      style: const TextStyle(fontSize: 30),
                    )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  toCelcius(k) {
    return (k -  273.15).toInt();
  }
}
