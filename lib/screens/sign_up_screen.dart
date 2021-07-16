import 'dart:io';

import 'package:edge/provider/auth.dart';
import 'package:edge/screens/admin_screen.dart';
import 'package:edge/screens/home_screen.dart';
import 'package:edge/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../fade_animation.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign-up-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _hidePassword = true;
  static const Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  //String _password;

  _showBetaDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Beta User!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          content: Text(
            'You are very special to us. \n\nSome features may have some bugs, We are still working on it.',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.black);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      setState(() {
        isLoaded = true;
      });
    }
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        barrierColor: Colors.black26,
        borderColor: Colors.black54,
        indicatorColor: Colors.black,
        backgroundColor: Colors.white54,
        padding: const EdgeInsets.all(30),
        textStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
              )
            ],
            fontWeight: FontWeight.w600),
        child: Builder(builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.1),
              ], begin: Alignment.bottomCenter),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/sign.jpg'),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 100, bottom: 20),
                child: FadeAnimation(
                  1,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('edge.',
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).maybePop();
                            },
                            child: Icon(
                              Icons.clear_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        'Create new account.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                              )
                            ],
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  name: 'Full Name',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.minLength(context, 6),
                                    FormBuilderValidators.required(context),
                                  ]),
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.black,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black,
                                    hintText: 'Enter your full name',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    labelText: 'Full name',
                                    labelStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  name: 'Email',
                                  cursorColor: Colors.black,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(context),
                                    FormBuilderValidators.required(context),
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Ionicons.at_outline,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black,
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    labelText: 'E-Mail',
                                    labelStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  name: 'Password',
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.black,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.match(
                                        context, pattern,
                                        errorText:
                                            'Password should contain at least one digit. \n'
                                            'Password should contain at least 6 characters. \n')
                                  ]),
                                  keyboardType: TextInputType.visiblePassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  obscureText: _hidePassword,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black54,
                                    ),
                                    suffixIcon: InkWell(
                                      child: Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                    ),
                                    fillColor: Colors.black,
                                    hintText: 'Enter your Password',
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onSubmitted: (value) {
                                    setState(() {
                                      //_password = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: FormBuilderTextField(
                                  name: 'Confirm password',
                                  textInputAction: TextInputAction.done,
                                  cursorColor: Colors.black,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    // FormBuilderValidators.match(context, _password,
                                    //     errorText: 'Passwords don\'t match')
                                  ]),
                                  keyboardType: TextInputType.visiblePassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  obscureText: _hidePassword,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black54,
                                    ),
                                    fillColor: Colors.black,
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          final progress = ProgressHUD.of(context);
                          progress.showWithText('Loading');
                          if (_formKey.currentState.saveAndValidate()) {
                            final formInputs = _formKey.currentState.value;
                            print(formInputs);
                            try {
                              await auth.signup(
                                  name: formInputs['Full Name'],
                                  email: formInputs['Email'],
                                  password: formInputs['Password']);

                              print('user signed up');
                              progress.dismiss();
                              if (auth.isAdmin) {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 150),
                                        opaque: false,
                                        pageBuilder: (_, animation1, __) {
                                          return SlideTransition(
                                              position: Tween(
                                                      begin: Offset(1.0, 0.0),
                                                      end: Offset(0.0, 0.0))
                                                  .animate(animation1),
                                              child: AdminPage());
                                        }));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 150),
                                        opaque: false,
                                        pageBuilder: (_, animation1, __) {
                                          return SlideTransition(
                                              position: Tween(
                                                      begin: Offset(1.0, 0.0),
                                                      end: Offset(0.0, 0.0))
                                                  .animate(animation1),
                                              child: HomePage());
                                        }));
                              }
                            } on HttpException catch (e) {
                              progress.dismiss();
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('An error occurred!',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      content: Text(
                                        e.message,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Okay',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }
                          progress.dismiss();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin:
                                  const EdgeInsets.only(right: 15.0, left: 10),
                              child: Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 36,
                              )),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 2),
                                )
                              ],
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: new Container(
                              margin:
                                  const EdgeInsets.only(left: 15.0, right: 10),
                              child: Divider(
                                color: Colors.black,
                                thickness: 1.5,
                                height: 36,
                              )),
                        ),
                      ]),
                      SizedBox(
                        height: 22,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.logo_google,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Sign up with Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already a member? ',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 4),
                                  )
                                ],
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 150),
                                      opaque: false,
                                      pageBuilder: (_, animation1, __) {
                                        return SlideTransition(
                                            position: Tween(
                                                    begin: Offset(1.0, 0.0),
                                                    end: Offset(0.0, 0.0))
                                                .animate(animation1),
                                            child: SignInScreen());
                                      }));
                            },
                            child: Text(
                              'Log in!',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
