import 'package:car_rental_admin/Home_screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthenticationscreenState();
  }
}

final _firebase = FirebaseAuth.instance;

class _AuthenticationscreenState extends State<AuthScreen> {
  final formkey = GlobalKey<FormState>();
  var _email = '';
  var pass = '';
  var _username = '';

  var _islogin = true;
  var _isUploading = false;
  void saved() async {
    final valid = formkey.currentState!.validate();

    if (!valid) {
      return;
    }
    // if (!_islogin) {
    //   return;
    // }

    formkey.currentState!.save();
    try {
      setState(() {
        _isUploading = true;
      });
      if (_islogin) {
        final adminCredentials = await _firebase.signInWithEmailAndPassword(
            email: _email, password: pass);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()));
      } else {
        final adminCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _email, password: pass);

        // Sending and creating the collection on firebase fireStore that is the remote ot cloud database
        await FirebaseFirestore.instance
            .collection('Admin_Credentials')
            .doc(adminCredentials.user!.uid)
            .set({
          'username': _username,
          'email': _email,
          'password': pass,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
    }
    setState(() {
      _isUploading = false;
      _islogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isDarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 19),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(30),
                  topEnd: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 19.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.black),

                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.email),
                                labelText: 'Email Adrress',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              //cursorColor: Colors.black,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please Enter the valid Email Address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.visibility_off),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              cursorColor: Colors.black,
                              textCapitalization: TextCapitalization.none,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'password must be aleast 8 character long:';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                pass = value!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!_islogin)
                              TextFormField(
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.verified_user),
                                  labelText: "Username",
                                  labelStyle: TextStyle(color: Colors.black),
                                ),
                                enableSuggestions: false,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 2) {
                                    return 'username should not be empty and at least two characters long';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _username = value;
                                },
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Forgot Password ?'),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            if (_isUploading) const CircularProgressIndicator(),
                            if (!_isUploading)
                              Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: saved,
                                  child: Text(
                                    _islogin ? 'SIGN IN' : 'SIGN UP',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 80,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _islogin
                                        ? "Don't Have Account"
                                        : "Already have Account",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 15, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _islogin = !_islogin;
                                      });
                                    },
                                    child:
                                        Text(!_islogin ? 'Sign in' : 'Sign up'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*Column(
        children: [
          // contianer
          Container(
            width: double
                .infinity, // Take as much as widht available as per the screen size.
            height: 150,
            decoration: BoxDecoration(
              color: _isDarkmode
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(60),
                  bottomEnd: Radius.circular(60)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _islogin
                    ? const Text(
                        'Login',
                        textAlign: TextAlign.center,
                      )
                    : const Text('Register'),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // Text for greeting
          const Center(
            child: Text(
              'WELCOME ADMIN ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          // Card View for input fields
          Card(
            color: Color.fromARGB(255, 225, 235, 242),
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: saved,
                  child: Text(_islogin ? 'Login' : 'Register')),
              const SizedBox(
                width: 60,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _islogin = !_islogin;
                    });
                  },
                  child: Text(!_islogin
                      ? 'Already Have a Account'
                      : 'Create an Account')),
            ],
          ),
        ],
      ),*/