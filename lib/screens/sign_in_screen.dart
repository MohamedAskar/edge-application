import 'dart:io';

import 'package:edge/provider/auth.dart';
import 'package:edge/screens/admin_screen.dart';
import 'package:edge/screens/home_screen.dart';
import 'package:edge/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../fade_animation.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'sign-in-screen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _hidePassword = true;
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
            height: MediaQuery.of(context).size.height,
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
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 4),
                                  )
                                ],
                              )),
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
                        'Hello, \nWelcome Back!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
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
                                  name: 'Email',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.email(context),
                                    FormBuilderValidators.required(context),
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.black,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.alternate_email_outlined,
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
                                  cursorColor: Colors.black,
                                  textInputAction: TextInputAction.done,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
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
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () => {},
                        child: Text('Forget your Password?',
                            style: TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                )
                              ],
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )),
                      ),
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
                              await auth.login(
                                  email: formInputs['Email'],
                                  password: formInputs['Password']);

                              print('user logged in');
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
                                              fontSize: 18,
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
                              'SIGN IN',
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
                                color: Colors.white,
                                thickness: 1.5,
                                height: 36,
                              )),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
                                color: Colors.white,
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
                                  'Continue with Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 2,
                                          color: Color.fromRGBO(0, 0, 0, 0.75),
                                          offset: Offset(0, 2),
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
                      //Spacer(),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
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
                                            child: SignUpScreen());
                                      }));
                            },
                            child: Text(
                              'Create one!',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 2),
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
