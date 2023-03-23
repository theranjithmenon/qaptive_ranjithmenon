class Weather {
  double? temp;
  String? description;
  double? humidity;
  String? name;
  Weather({
    this.temp,
    this.description,
    this.humidity,
    this.name,
  });
  weatherfromJson(Map<String, dynamic> json) {
    return {
      temp = json['main'][0]['temp'],
      description = json['weather'][0]['description'],
      humidity = json['main']['humidity'],
      name = json['name']
    };
  }
}
