class PlantModel {
  int id;
  String name;
  bool favorite;
  String imgpath;
  List<PlantReading> readings;

  PlantModel({this.id, this.name, this.favorite, this.readings});
  PlantModel.fromJson(Map<String, dynamic> json)  {
    id = int.parse(json['plantId']);
    name = json['plantName'];
    favorite = false;
    imgpath = '';
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
    time = DateTime.parse(json['theTime'] + 'Z').toLocal();
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