class PlantModel {
  String id;
  String name;
  bool favorite;
  List<PlantReading> readings;

  PlantModel({this.id, this.name, this.favorite, this.readings});
}

class PlantReading {
  int id;
  String time;
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
}

List<PlantModel> plantProbes = [
  PlantModel(
    id: "1",
    name: "Test Plant 1",
    favorite: true,
    readings: [
    PlantReading(
      time: "2 Days Ago", light: 20.0, lightQuality: 0.3, moisture: 16.7, moistureQuality: 0.2,
      humidity: 56.3, humidityQuality: 0.8, temperature: 75, temperatureQuality: 0.97
      )
    ]
  ),
  PlantModel(
    id: "2",
    name: "Test Plant 2",
    favorite: false,
    readings: [
      PlantReading(
        time: "1:00 AM", light: 35.0, lightQuality: 0.48, moisture: 78.2, moistureQuality: 0.623,
        humidity: 11.111111, humidityQuality: 0.143, temperature: 55, temperatureQuality: 0.79
      )
    ]
  ),
   PlantModel(
    id: "3",
    name: "Test Plant 3",
    favorite: false,
    readings: [
      PlantReading(
        time: "2:35 PM", light: 35.0, lightQuality: 0.48, moisture: 78.2, moistureQuality: 0.623,
        humidity: 11.111111, humidityQuality: 0.143, temperature: 55, temperatureQuality: 0.79
      )
    ]
  ),
   PlantModel(
    id: "4",
    name: "Test Plant 4",
    favorite: false,
    readings: [
      PlantReading(
        time: "6:09 AM", light: 35.0, lightQuality: 0.48, moisture: 78.2, moistureQuality: 0.623,
        humidity: 11.111111, humidityQuality: 0.143, temperature: 55, temperatureQuality: 0.79
      )
    ]
  ),
   PlantModel(
    id: "5",
    name: "Test Plant 5",
    favorite: false,
    readings: [
      PlantReading(
        time: "12:00 AM", light: 35.0, lightQuality: 0.48, moisture: 78.2, moistureQuality: 0.623,
        humidity: 11.111111, humidityQuality: 0.143, temperature: 55, temperatureQuality: 0.79
      )
    ]
  ),
];