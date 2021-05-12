// import 'package:msafiri_admin/services/auth_service.dart';
// import 'package:msafiri_admin/signup_screen.dart';
import 'package:brightcare_admin/services/auth_service.dart';
import 'package:brightcare_admin/register_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  static final String id = "log";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obSecureText = false;
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  _toggle() {
    setState(() {
      _obSecureText = !_obSecureText;
    });
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.login(context, _email, _password);
    }
  }

  void _onLoading() {
    _scaffoldkey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
            new Text(
              '    Signing-In...',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user;
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.accessToken,
        accessToken: googleSignInAuthentication.idToken,
      );
      AuthResult result = (await _auth.signInWithCredential(credential));
      _user = result.user;
      print('signed in' + _user.displayName);
      Navigator.pushReplacementNamed(context, Login.id);
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
        // leading: FlatButton(
        //   textColor: Colors.white,
        //   onPressed: () {},
        //   child: Icon(Icons.arrow_back),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     ButtonTheme(
              //       minWidth: 150.0,
              //       height: 40.0,
              //       child: Padding(
              //         padding: const EdgeInsets.all(20.0),
              //         child: RaisedButton(
              //           color: Colors.blue,
              //           onPressed: () {
              //             _googleSignUp();
              //           },
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(22.0),
              //           ),
              //           child: Text(
              //             'Google',
              //             style: TextStyle(color: Colors.white),
              //           ),
              //         ),
              //       ),
              //     ),
              //     ButtonTheme(
              //       minWidth: 150.0,
              //       height: 40.0,
              //       child: RaisedButton(
              //         color: Color(0xff4267B2),
              //         onPressed: () {},
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(22.0),
              //         ),
              //         child: Text(
              //           'Facebook',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Text('Or'),
              SizedBox(height: 20.0),
              Text(
                'Welcome Admin',
                style: TextStyle(
                  fontFamily: 'PatrickHand',
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Container(
              //   child: Center(
              //     child: CircleAvatar(
              //         radius: 50.0,
              //         backgroundImage:
              //             ExactAssetImage('assets/images/beach.jpg')),
              //   ),
              // ),
              SizedBox(height: 10.0),
              // Text(
              //   "NB: Only Admins",
              //   style: TextStyle(
              //     fontFamily: 'PatrickHand',
              //     fontSize: 15.0,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(
                  height: 20.0,
                  child: Divider(
                    color: Colors.purple,
                  )),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) => EmailValidator.validate(email)
                            ? null
                            : 'Email is invalid',
                        onSaved: (email) => _email = email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.black,
                            icon: _obSecureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: _toggle,
                          ),
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                          ),
                        ),
                        obscureText: _obSecureText,
                        validator: (password) => password.length < 6
                            ? "Must be atleast six characters"
                            : null,
                        onSaved: (password) => _password = password,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: 340.0,
                      height: 45.0,
                      child: FlatButton(
                          onPressed: () {
                            _submit();
                            _onLoading();
                          },
                          color: Colors.black,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'LOG IN',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.id);
                      },
                      child: Text(
                        'Dont have an Account?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
