import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_access/screens/service_provider.dart';


// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _email='';
    String _password='';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Text('WELCOME'),
              ),
              FaIcon(
                FontAwesomeIcons.circleUser,
                size: 55,
                color: Colors.black,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 50),
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                          decoration: const InputDecoration(
                              hintText: 'Username or Email',
                              hintStyle:
                              TextStyle(fontSize: 15, letterSpacing: 1.2)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50),
                        child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value){
                            _password = value;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                              TextStyle(fontSize: 15, letterSpacing: 1.2)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => AuthService().signInWithGoogle(),
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 113, 113, 113)),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 29, 93, 158))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
