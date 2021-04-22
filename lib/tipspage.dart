import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gmd_project/model/globals.dart' as globals;

class Tipspage extends StatefulWidget {
  @override
  _TipspageState createState() => _TipspageState();
}

class _TipspageState extends State<Tipspage> {
  String test = '';
  String test2 = '';
  String test3 = '';
  String test4 = '';
  String test5 = '';
  String test6 = '';
  String test7 = '';
  final getKey = GlobalKey<FormState>();
  final getKey2 = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 55.0),
      child: ListView(
        children: <Widget>[
          Form(
            key: getKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Theme.of(context).hintColor),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  onSaved: (input) => {
                    getInfo(input).then((String result){setState((){test = result;});})
                  },
                  validator: (value) {
                   if (value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                    ),
                    onPressed: () {
                      if (getKey.currentState.validate()) {
                        getKey.currentState.save();
                      }
                    },
                    child: Text('Get User'),
                  ),
                ),
              ]
            )   
          ),
          Text(test, style: TextStyle(color: Theme.of(context).hintColor)),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              getInfo('email@email.com').then((String result){setState((){test2 = result;});});
            },
            child: Text('Get User 2'),
          ),
          Text(test2, style: TextStyle(color: Theme.of(context).hintColor)),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              setState(() => globals.loading.value = true);
              getInfo('email@email.com').then((var result){setState((){test3 = result.toString(); setState(() => globals.loading.value = false);});});
            },
            child: Text('Get User 3'),
          ),
          Text(test3, style: TextStyle(color: Theme.of(context).hintColor)),
          Form(
            key: getKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Theme.of(context).hintColor),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  onSaved: (input) => {
                    setState(() => globals.loading.value = true),
                    getInfo(input).then((String result){setState((){test6 = result; setState(() => globals.loading.value = false);});})
                  },
                  validator: (value) {
                   if (value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                    ),
                    onPressed: () {
                      if (getKey2.currentState.validate()) {
                        getKey2.currentState.save();
                      }
                    },
                    child: Text('Get User 4'),
                  ),
                ),
              ]
            )   
          ),
          Text(test6, style: TextStyle(color: Theme.of(context).hintColor)),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              getUserPlants().then((var result){setState((){test4 = result.toString();});});
            },
            child: Text('Get Plants'),
          ),
          Text(test4, style: TextStyle(color: Theme.of(context).hintColor)),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              getPlantTraits().then((var result){setState((){test5 = result.toString();});});
            },
            child: Text('Get Plant Readings'),
          ),
          Text(test5, style: TextStyle(color: Theme.of(context).hintColor)),
                    ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              addPlantTraits().then((var result){setState((){test7 = result.toString();});});
            },
            child: Text('Add Plant Traits'),
          ),
          Text(test7, style: TextStyle(color: Theme.of(context).hintColor)),
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
  String queryString = Uri(queryParameters: {'email':'jchan02@manhattan.edu'}).query;
  var requestUrl = url + '?' + queryString;
  await http.get(requestUrl);
}

Future sendMailData() async{
  var url = 'https://71142021.000webhostapp.com/mailUser.php';
  String queryString = Uri(queryParameters: {'email':'jchan02@manhattan.edu', 'theName':'Jason'}).query;
  var requestUrl = url + '?' + queryString;
  await http.get(requestUrl);
}