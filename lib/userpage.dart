import 'package:flutter/material.dart';

final formKey = GlobalKey<FormState>();

class Userpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 56.0),
      child: ListView(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        children: <Widget> [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                   if (value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                   if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF007F0E))
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                      }
                    },
                    child: Text('Save Changes'),
                  ),
                ),
              ]
            )   
          )
        ]
      )
    );
  }
}