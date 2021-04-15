class PlantModel {
  int id;
  String name;
  bool favorite;
  List<PlantReading> readings;

  PlantModel({this.id, this.name, this.favorite, this.readings});
  PlantModel.fromJson(Map<String, dynamic> json)  {
    id = int.parse(json['plantId']);
    name = json['plantName'];
    favorite = false;
    readings = [];
  }
}

class PlantReading {
  int id;
  DateTime time;
  double light;
  double lightQuality;
  double moisture;
  double moistureQuality;
  double humidity;
  double humidityQuality;
  double temperature;
  double temperatureQuality;

  PlantReading({this.time, this.light, this.lightQuality, this.moisture, this.moistureQuality, 
  this.humidity, this.humidityQuality, this.temperature, this.temperatureQuality});
  PlantReading.fromJson(Map<String, dynamic> json)  {
    id = int.parse(json['readingId']);
    time = DateTime.parse(json['theTime']);
    light = double.parse(json['sunlight']);
    moisture = double.parse(json['moisture']);
    humidity = double.parse(json['humidity']);
    temperature = double.parse(json['temperature']);
    lightQuality = double.parse(json['sunlightQuality']);
    moistureQuality = double.parse(json['moistureQuality']);
    humidityQuality = double.parse(json['humidityQuality']);
    temperatureQuality = double.parse(json['temperatureQuality']);
  }
}

List<PlantModel> plantProbes = [];

List<PlantModel> testProbes = [
  PlantModel(
    id: 1,
    name: "Test Plant 1",
    favorite: true,
    readings: [
    PlantReading(
      time: DateTime.parse("2021-03-20 18:07:06"), light: 20.0, lightQuality: 0.3, moisture: 16.7, moistureQuality: 0.2,
      humidity: 56.3, humidityQuality: 0.8, temperature: 75, temperatureQuality: 0.97
      )
    ]
  ),
  PlantModel(
    id: 26,
    name: "New Plant",
    favorite: false,
    readings: [
      PlantReading(
        time: DateTime.parse("2021-03-21 09:45:37"), light: 35.0, lightQuality: 0.48, moisture: 78.2, moistureQuality: 0.623,
        humidity: 11.111111, humidityQuality: 0.143, temperature: 55, temperatureQuality: 0.79
      )
    ]
  ),
];