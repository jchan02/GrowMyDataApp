import 'package:flutter/material.dart';
import 'package:gmd_project/model/globals.dart' as globals;
import 'package:gmd_project/model/plant_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final loginKey = GlobalKey<FormState>();
final signupKey = GlobalKey<FormState>();
final passchangeKey = GlobalKey<FormState>();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();

class Userpage extends StatefulWidget {
  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return globals.email == '' ? 
    Container(
      padding: EdgeInsets.only(left: 56.0),
      child: ListView(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        children: <Widget> [
          Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Theme.of(context).hintColor),
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                    prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                  ),
                  validator: (value) {
                   if (value.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: Theme.of(context).hintColor),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                    prefixIcon: Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                  ),
                  validator: (value) {
                   if (value.isEmpty) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
                        ),
                        onPressed: () {
                          if (loginKey.currentState.validate()) {
                            setState(() => globals.loading.value = true);
                            login(emailController.text, passwordController.text).then((String result){
                              setState((){
                                if (result == 'Login Sucess') {
                                  globals.email = emailController.text;
                                  passwordController.text = '';
                                  getUsers(emailController.text).then((String result){
                                    Map<String, dynamic> loginMap = jsonDecode(result)[0];
                                    globals.notifEnable = int.parse(loginMap['notifEnable']) == 1 ? true : false;
                                    globals.notifThreshold = double.parse(loginMap['notifThreshold']) * 100;
                                  });
                                  getUserPlants(emailController.text).then((String result){
                                    if(result.contains('[{')) plantProbes = (jsonDecode(result) as List).map((i) => PlantModel.fromJson(i)).toList();
                                    plantProbes.forEach((item){
                                      getPlantTraits(item.id).then((String result){
                                        if(result.contains('[{')) item.readings = (jsonDecode(result) as List).map((i) => PlantReading.fromJson(i)).toList();
                                      });
                                    });
                                  });
                                }
                                globals.loading.value = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: (result == 'Login Sucess') ? Theme.of(context).primaryColor : Colors.red,
                                    content: Container(
                                      child: (result == 'Login Sucess') ? 
                                        Text('Successfully signed in', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                      : Text('Incorrect email address or password', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                    )
                                  )
                                );
                              });
                            });
                          }
                        },
                        child: Text('Sign In', style: TextStyle(color: Theme.of(context).secondaryHeaderColor)),
                      )
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).backgroundColor),
                          overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => Scaffold(backgroundColor: Colors.transparent,body: Builder(builder: (_) => AlertDialog(
                              title: Text('Sign Up', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).hintColor),),
                              titlePadding: EdgeInsets.only(top: 8, bottom: 0),
                              buttonPadding: EdgeInsets.only(top: 0),
                              elevation: 0,
                              backgroundColor: Theme.of(context).backgroundColor,
                              content: SingleChildScrollView(
                                child: Form(
                                  key: signupKey,
                                  child: SizedBox(
                                    child: Column(
                                      children: <Widget> [
                                        TextFormField(
                                          controller: usernameController,
                                          style: TextStyle(color: Theme.of(context).hintColor),
                                          decoration: InputDecoration(
                                            hintText: 'Username',
                                            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                                            prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a valid username';
                                            }
                                            else if (value.length > 254) {
                                              return 'Username is too long';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: emailController,
                                          style: TextStyle(color: Theme.of(context).hintColor),
                                          decoration: InputDecoration(
                                            hintText: 'Email Address',
                                            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                                            prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty || (!value.contains('@')) || (!value.contains('.'))) {
                                              return 'Please enter a valid email address';
                                            }
                                            else if (value.length > 254) {
                                              return 'Email address is too long';
                                            }
                                            else if (value.contains(' ')) {
                                              return 'Email address cannot contain any spaces';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          style: TextStyle(color: Theme.of(context).hintColor),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                                            prefixIcon: Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a valid password';
                                            }
                                            else if (value.length < 6) {
                                              return 'Passwords must have at least 6 characters';
                                            }
                                            else if (value.length > 254) {
                                              return 'Password is too long';
                                            }
                                            else if (value.contains(' ')) {
                                              return 'Password cannot contain any spaces';
                                            }
                                            return null;
                                          },
                                        ),
                                      ]
                                    )
                                  )
                                )
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop();
                                  }
                                ),
                                TextButton(
                                  child: Text('Confirm', style: TextStyle(color: Theme.of(context).primaryColor)),
                                  onPressed: () {
                                    if(signupKey.currentState.validate()){
                                      getUsers(emailController.text).then((String result){
                                        setState((){
                                          if (result.contains('[{"emailAddress')) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.red,
                                                content: Container(
                                                  child: Text('Email already in use', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                                )
                                              )
                                            );
                                          }
                                          else {
                                            globals.loading.value = true;
                                            signup(emailController.text, passwordController.text, usernameController.text).then((String result) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  content: Container(
                                                    child: Text('Registration complete', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                                  )
                                                )
                                              );
                                              signupMail(emailController.text, usernameController.text).then((String result){
                                                globals.email = emailController.text;
                                                globals.notifEnable = true;
                                                globals.notifThreshold = 0.3;
                                                plantProbes = [];
                                                passwordController.text = '';
                                                Navigator.of(context, rootNavigator: true).pop();
                                                setState(()=> globals.loading.value = false);
                                              });
                                            });
                                          }
                                        });
                                      });
                                    }
                                  }
                                ) ,
                              ],
                            )
                          )));
                        },
                        child: Text('Create New Account', style: TextStyle(color: Theme.of(context).hintColor)),
                      )
                    )
                  ),
                )
              ]
            )   
          ),
        ]
      )
    )
    : Container(
      padding: EdgeInsets.only(left: 56.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          Text('Signed in under: ' + globals.email, style: TextStyle(color: Theme.of(context).hintColor)),
          SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {setState((){
              globals.email = '';
              passwordController.text = '';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                   backgroundColor: Theme.of(context).primaryColor,
                   content: Container(
                    child: Text('Successfully signed out', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                  )
                )
              );
            });},
            child: Text('Sign out', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Scaffold(backgroundColor: Colors.transparent,body: Builder(builder: (_) => AlertDialog(
                  title: Text('Change Password', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).hintColor),),
                  titlePadding: EdgeInsets.only(top: 8, bottom: 0),
                  buttonPadding: EdgeInsets.only(top: 0),
                  elevation: 0,
                  backgroundColor: Theme.of(context).backgroundColor,
                  content: SingleChildScrollView(
                    child: Form(
                      key: passchangeKey,
                      child: SizedBox(
                        child: Column(
                          children: <Widget> [
                            TextFormField(
                              controller: passwordController,
                              style: TextStyle(color: Theme.of(context).hintColor),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Old password',
                                hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                                prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                else if (value.length > 254) {
                                  return 'Password is too long';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: newPasswordController,
                              style: TextStyle(color: Theme.of(context).hintColor),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).cardColor),
                                prefixIcon: Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                else if (value == passwordController.text) {
                                  return 'New password must be different';
                                }
                                else if (value.length < 6) {
                                  return 'Passwords must have at least 6 characters';
                                }
                                else if (value.length > 254) {
                                  return 'Password is too long';
                                }
                                else if (value.contains(' ')) {
                                  return 'Password cannot contain any spaces';
                                }
                                return null;
                              },
                            ),
                          ]
                        )
                      )
                    )
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    ),
                    TextButton(
                      child: Text('Confirm', style: TextStyle(color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        if(passchangeKey.currentState.validate()){
                          getUsers(emailController.text).then((String result){
                            List data;
                            data = jsonDecode(result);
                            setState((){
                              if (data[0]['loginPassword'] == passwordController.text) {
                                globals.loading.value = true;
                                updatePassword(emailController.text, passwordController.text, newPasswordController.text).then((String result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Theme.of(context).primaryColor,
                                      content: Container(
                                        child: Text(result, style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                      )
                                    )
                                  );
                                  newPasswordController.text = '';
                                  Navigator.of(context, rootNavigator: true).pop();
                                  setState(()=> globals.loading.value = false);
                                });
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                    content: Container(
                                      child: Text('Incorrect old password', style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
                                    )
                                  )
                                );
                              }
                            });
                          });
                        }
                      }
                    ) ,
                  ],
                )
              )));
            },
            child: Text('Change password', style: TextStyle(color: Theme.of(context).primaryColor)),
          )
        ],
      )
    );
  }
}

Future<String> login(String email, String password) async{
  var url = 'https://71142021.000webhostapp.com/login.php';
  String queryString = Uri(queryParameters: {'email':email, 'loginPass':password}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> getUsers(String email) async{
  var url = 'https://71142021.000webhostapp.com/getUsers.php';
  String queryString = Uri(queryParameters: {'email':email}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> getUserPlants(String email) async{
  var url = 'https://71142021.000webhostapp.com/getUserPlants.php';
  String queryString = Uri(queryParameters: {'emailAddress':email}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> getPlantTraits(int id) async{
  var url = 'https://71142021.000webhostapp.com/getPlantTraits.php';
  String queryString = Uri(queryParameters: {'plantID':id.toString()}).query;
  var requestUrl = url + '?' + queryString;
  http.Response response = await http.get(requestUrl);
  var data = response.body;
  return data.toString();
}

Future<String> signup(String email, String password, String name) async{
  String theUrl = "https://71142021.000webhostapp.com/setUser.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': email, 'loginPassword': password, 'theName' : name});
  var respBody = res.body;
  return respBody;
}

Future<String> signupMail(String email, String name) async{
  String theUrl = "https://71142021.000webhostapp.com/sendingEmail.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': email, 'theName' : name});
  var respBody = res.body;
  return respBody;
}

Future<String> updatePassword(String email, String oldPass, String newPass) async{
  String theUrl = "https://71142021.000webhostapp.com/updatePassword.php";
  var res = await http.post(Uri.encodeFull(theUrl), headers: {"Accept":"application/json"},
    body: {'email': email, 'oldPassword': oldPass, 'password' : newPass});
  var respBody = res.body;
  return respBody;
}