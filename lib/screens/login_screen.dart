import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gior/providers/profile.dart';
import 'package:gior/model/user.dart';
import 'package:gior/providers/auth.dart';
import '../http/http_exeptions.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

enum LoginMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  // Animation<Offset> _slideAnimation;

  LoginMode _loginMode = LoginMode.Login;
  var _isLoding = false;
  Auth auth = Auth();
  Profile profile = Profile();
  var _newUser =
      User(name: '', password: '', email: '', repassword: '', phone: null);

  var _user = {
    'name': '',
    'email': '',
    'password': '',
    'repassword': '',
    'phone': '',
  };

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    // _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
    //     .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   _user = {
  //     'name': _newUser.name,
  //     'email': _newUser.email,
  //     'password': _newUser.password,
  //     'repassword': _newUser.repassword,
  //     'phone': _newUser.phone.toString(),
  //   };
  // }

  _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error Occured'),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
   
    if (!_formKey.currentState.validate()) {
      // when fails
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoding = true;
    });

    try {
      if (_loginMode == LoginMode.Login) {
        //  login
        auth.login(_newUser.email, _newUser.password);
        FocusScope.of(context).unfocus();
      } else {
        // singup
        auth.signUp(_newUser.email, _newUser.password);
        profile.createProfile(_newUser.userId, _newUser.email, _newUser.name,
            _newUser.phone, _newUser.role);
        FocusScope.of(context).unfocus();
      }
    } on HttpException catch (error) {
      var _errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        _errorMessage = 'This email already  in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        _errorMessage = 'This is not valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        _errorMessage = 'password too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        _errorMessage = 'Could not find a user with this email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        _errorMessage = 'Invalid password';
        _showErrorDialog(_errorMessage);
      }
    } catch (error) {
      const errorMessage = 'Could not authenticate. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoding = false;
    });
  }

  void _switchAuthMode() {
    if (_loginMode == LoginMode.Login) {
      setState(() {
        _loginMode = LoginMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _loginMode = LoginMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: _isLoding,
              child: Container(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                child: Opacity(
                  opacity: 0.7,
                  child:
                      Image.asset('assets/images/login.png', fit: BoxFit.cover),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: AnimatedContainer(
                      curve: Curves.linear,
                      duration: Duration(seconds: 1),
                      height: _loginMode == LoginMode.Login ? 260 : 440,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          // top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  // initialValue: _user['email'],
                                  decoration: InputDecoration(hintText: 'email'),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty || !value.contains('@')) {
                                      return 'invalid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    print('email: $value');
                                    _newUser = User(
                                        email: value,
                                        name: _newUser.name,
                                        password: _newUser.password,
                                        repassword: _newUser.repassword,
                                        phone: _newUser.phone);
                                  },
                                ),
                                TextFormField(
                                  // initialValue: _user['password'],
                                  decoration:
                                      InputDecoration(hintText: 'password'),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return 'Please, fill in longer password';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    print('password: $value');
                                    _newUser = User(
                                      email: _newUser.email,
                                      name: _newUser.name,
                                      password: value,
                                      repassword: _newUser.repassword,
                                      phone: _newUser.phone,
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                if (_loginMode == LoginMode.Signup)
                                  AnimatedContainer(
                                    constraints: BoxConstraints(
                                        minHeight: _loginMode == LoginMode.Signup
                                            ? 60
                                            : 0,
                                        maxHeight: _loginMode == LoginMode.Signup
                                            ? 75
                                            : 0),
                                    duration: Duration(seconds: 1),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        // initialValue: _user['name'],
                                        // enabled: _loginMode == LoginMode.Signup,
                                        decoration:
                                            InputDecoration(hintText: 'name'),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'fill in any name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          print('name: $value');
                                          _newUser = User(
                                            email: _newUser.email,
                                            name: value,
                                            password: _newUser.password,
                                            repassword: _newUser.repassword,
                                            phone: _newUser.phone,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (_loginMode == LoginMode.Signup)
                                  AnimatedContainer(
                                    curve: Curves.easeInOut,
                                    constraints: BoxConstraints(
                                        minHeight: _loginMode == LoginMode.Signup
                                            ? 60
                                            : 0,
                                        maxHeight: _loginMode == LoginMode.Signup
                                            ? 75
                                            : 0),
                                    duration: Duration(seconds: 1),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        // initialValue: _user['repassword'],
                                        decoration: InputDecoration(
                                            hintText: 'repeat password'),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        validator: _loginMode == LoginMode.Signup
                                            ? (value) {
                                                if (value !=
                                                    _passwordController.text) {
                                                  return 'Password does not match';
                                                }
                                              }
                                            : null,
                                        onSaved: (value) {
                                          print('repassword: $value');
                                          _newUser = User(
                                            email: _newUser.email,
                                            name: _newUser.name,
                                            password: _newUser.password,
                                            repassword: value,
                                            phone: _newUser.phone,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (_loginMode == LoginMode.Signup)
                                  AnimatedContainer(
                                    curve: Curves.easeInOut,
                                    constraints: BoxConstraints(
                                        minHeight: _loginMode == LoginMode.Signup
                                            ? 60
                                            : 0,
                                        maxHeight: _loginMode == LoginMode.Signup
                                            ? 75
                                            : 0),
                                    duration: Duration(seconds: 1),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        // initialValue: _user['phone'],
                                        // enabled: _loginMode == LoginMode.Signup,
                                        decoration:
                                            InputDecoration(hintText: 'phone'),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isNotEmpty &&
                                              (value.length == 9 ||
                                                  value.length == 11)) {
                                            return null;
                                          }
                                          return 'phone number not valid';
                                        },
                                        onSaved: (value) {
                                          print('phone: $value');
                                          _newUser = User(
                                            email: _newUser.email,
                                            name: _newUser.name,
                                            password: _newUser.password,
                                            repassword: _newUser.repassword,
                                            phone: int.parse(value),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      color: Colors.blueGrey[800],
                                      splashColor: Colors.yellow,
                                      onPressed: () {
                                        _submit();
                                      },
                                      child: Text(
                                        _loginMode == LoginMode.Login
                                            ? 'Login'
                                            : 'Sing up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      child: Text(_loginMode == LoginMode.Login
                                          ? 'I am new'
                                          : 'I am not new'),
                                      onPressed: _switchAuthMode,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
