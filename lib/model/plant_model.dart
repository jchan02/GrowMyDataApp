class PlantModel {
  String id;
  String name;
  List<PlantReading> readings;

  PlantModel({this.id, this.name, this.readings});
}

class PlantReading {
  String time;
  double light;
  double moisture;
  double humidity;
  double temperature;

  PlantReading({this.time, this.light, this.moisture, this.humidity, this.temperature});
}

List<PlantModel> plantProbes = [
  PlantModel(id: "1", name: "Test Plant 1", readings: [PlantReading(time: "0", light: 20.0, moisture: 16.7, humidity: 56.3, temperature: 75)]),
  PlantModel(id: "2", name: "Test Plant 2", readings: [PlantReading(time: "1", light: 35.0, moisture: 78.2, humidity: 11.111111, temperature: 55)]),
  PlantModel(id: "3", name: "Test Plant 3", readings: [PlantReading(time: "66", light: 56.7, moisture: 2.33, humidity: 98.9, temperature: 8.3)]),
  PlantModel(id: "4", name: "Test Plant 4", readings: [PlantReading(time: "162", light: 89.3, moisture: 7, humidity: 34, temperature: 49.15)]),
  PlantModel(id: "5", name: "Test Plant 5", readings: [PlantReading(time: "2412", light: 1.0, moisture: 78.2, humidity: 70.11, temperature: 21)]),
];