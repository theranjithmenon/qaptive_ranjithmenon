import 'package:flutter/material.dart';
import 'package:qaptive_ranjithmenon/firebase/user.dart';

import 'signup.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackOne'),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'Sign in to continue',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Column(
            children: [
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(label: Text('Email')),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Password')),
              ),
            ],
          ),
          Column(
            children: [
              MaterialButton(
                minWidth: 250,
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.brown,
                textColor: Colors.white,
                onPressed: () {
                  FirebaseUser().logIn(email.text, password.text, context);
                },
                child: const Text('Login Now'),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account? '),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
