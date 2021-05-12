// import 'package:msafiri_admin/admin_home.dart';
// import 'package:msafiri_admin/login_screen.dart';
// import 'package:msafiri_admin/services/auth_service.dart';
import 'package:brightcare_admin/admin_home.dart';
import 'package:brightcare_admin/login_screen.dart';
import 'package:brightcare_admin/services/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  static final String id = "register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obSecureText = false;
  String _name, _email, _password;
  bool isSignIn = false;
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminHome(),
                ));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHome(),
                              ));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  void submita() {
    final phone = _phoneController.text.trim();
    loginUser(phone, context);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
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
      AuthService.signUpUser(context, _name, _email, _password);
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

  /*Future<void>signUpWithFacebook() async{
    try{
      var facebookLogin = new FacebookLogin();
      var result  = await facebookLogin.logIn(['email']);
      if(result.status==FacebookLoginStatus.loggedIn){
         final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
         );
         final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
         print('signed in ' + user.displayName);
         return user;
      }
    } catch(e){
      print(e.message);
    }
  }
*/
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id, arguments: {"name": user.displayName, "email": user.email},);

    } catch (e) {
      print(e.message);
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        // Navigator.pushReplacementNamed(context, DashBoardScreen.id, arguments: {"name": user.displayName, "email": user.email},);
        print('Signed in' + user.displayName);
        print('Photo' + user.photoUrl);
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
        leading: FlatButton(
          textColor: Colors.white,
          onPressed: () {},
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 40.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          _googleSignUp();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Text(
                          'Google',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 40.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                        color: Color(0xff4267B2),
                        onPressed: () {
                          signUpWithFacebook();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Text(
                          'Facebook',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text('Or'),
              SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
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
                        keyboardType: TextInputType.text,
                        validator: (name) =>
                            name.trim().isEmpty ? 'Enter valid name' : null,
                        onSaved: (name) => _name = name,
                      ),
                    ),
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
                    /* Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter phone number',
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
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        validator: (password) => password.length != 13
                            ? "Enter valid phone number"
                            : null,
                      ),
                    ),
                    */
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
                        validator: (password) => password.length < 5
                            ? 'Password mut be atleast 5 characters'
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'ProductSans-Bold',
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Login.id);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ))
                      ],
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
/*   
   validator: (value){
     if(value.isEmpty) {
       setState((){
          errors.add('Please enter your email');
       });
     }
     return null; 
   }
 */
