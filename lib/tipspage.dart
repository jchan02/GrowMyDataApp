import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class Tipspage extends StatefulWidget {
  @override
  _TipspageState createState() => _TipspageState();
}

class _TipspageState extends State<Tipspage> {
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0),
      child: ListView(
        children: <Widget>[
          Text('\u2022 Do not water on a schedule; water when your plants need it! It is much easier to overwater than underwater a plant.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 When watering, add water to the soil rather than the leaves or the stem - plants get their water from the roots.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Increased sunlight triggers faster growth, and therefore requires more water. Of course, having not enough light may prevent any growth at all.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Make sure to use soil appropriate for your plant: a plant that likes water would want soil that retains it!\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 As potted plants grow, you may need to move them to a larger pot to accommodate their larger root structures.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Repotting by pulling the plant out of the pot can damage it. Instead, turn the pot over your hand and let the plant fall out gently.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 If you own a pet, make sure to check if a plant is toxic to them before buying it.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 It is easier and cheaper to buy plants that can thrive in your environment, instead of adjusting your environment to fit the plants.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Long-term gardeners should occasionally change the type of vegetable they grow in a certain area or planter so as to not exhaust all of a certain type of nutrient.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Dying parts of a plant should be removed so that the plant does not dedicate some of its nutrients to it.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Plants prefer stable conditions. A fluctuating environment can shock the plant and impair its growth, so keep them away from radiators and air conditioners.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          Text('\u2022 Indoor plants may accumulate dust that inhibits their ability to receive light.\n', style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
        ]
      )
    );
  }
}

Future<String> getInfo(String email) async{
  var url = 'https://71142021.000webhostapp.com/getUsers.php';
  String queryString = Uri(queryParameters: {'email':email}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> addPlantTraits() async{
  String theUrl = "https://71142021.000webhostapp.com/setPlantTraits.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'plantId': '30' , 'temperature': '65' , 'moisture' : '80' , 'humidity' : '40' , 'sunlight' : '20000'});
  var respBody = res.body;
  return respBody;
}

Future<String> add4PlantTraits() async{
  var rng = new Random();
  String theUrl = "https://71142021.000webhostapp.com/uploadReadings.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'plantId1':'30','plantId2':'31','plantId3':'33','plantId4':'34','temperature':(73 + 0.5* rng.nextDouble()).toString(),
      'moisture1':'0','moisture2':(33 + 0.2 * rng.nextDouble()).toString(),'moisture3':(4.8 + 0.01 * rng.nextDouble()).toString(),'moisture4':'100','humidity':(41 + rng.nextInt(3)).toString(),'sunlight':(2200 + 500 * rng.nextDouble()).toString()});
  var respBody = res.body;
  return respBody;
}

Future<String> addUser() async{
  String theUrl = "https://71142021.000webhostapp.com/setUser.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': 'hello' , 'loginPassword': 'world' , 'theName' : 'goodbye'});
  var respBody = res.body;
  return respBody;
}

Future<String> getUserPlants() async{
  var url = 'https://71142021.000webhostapp.com/getUserPlants.php';
  String queryString = Uri(queryParameters: {'emailAddress':'abc123@gmail.com'}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}
Future<String> getPlantTraits() async{
  var url = 'https://71142021.000webhostapp.com/getPlantTraits.php';
  String queryString = Uri(queryParameters: {'plantID':'26'}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> addPlant() async{
  String theUrl = "https://71142021.000webhostapp.com/setUserPlant.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': 'abc123@gmail.com','plantName': 'New Plant',});
  var respBody = res.body;
  return respBody;
}

Future sendMail(String email) async{
  var url = 'https://71142021.000webhostapp.com/mailUser.php';
  String queryString = Uri(queryParameters: {'email':'vgonnella01@manhattan.edu'}).query;
  var requestUrl = url + '?' + queryString;
  await http.get(requestUrl);
}

Future sendMailData() async{
  var url = 'https://71142021.000webhostapp.com/mailUser.php';
  String queryString = Uri(queryParameters: {'email':'jchan02@manhattan.edu', 'theName':'Jason'}).query;
  var requestUrl = url + '?' + queryString;
  await http.get(requestUrl);
}