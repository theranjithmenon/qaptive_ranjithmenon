import 'package:flutter/material.dart';
import 'package:qaptive_ranjithmenon/firebase/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('TrackOne'),
      ),
      body: _body(),
    );
  }

  _body() {
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
                  'Sign Up',
                  style: TextStyle(fontSize: 25),
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
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(label: Text('Password')),
              ),
              TextField(
                controller: cpassword,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration:
                    const InputDecoration(label: Text('Confirm Password')),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              const Text('I agree with TERMS & CONDITIONS')
            ],
          ),
          MaterialButton(
            minWidth: 250,
            height: 45,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: Colors.brown,
            textColor: Colors.white,
            onPressed: () {
              if (password.text != cpassword.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords Don\'t Match')));
              } else if (!isChecked) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Agree the Terms & Conditions')));
              } else {
                FirebaseUser().signUp(email.text, password.text, context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
