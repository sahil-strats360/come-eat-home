import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../../utils/color.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }
  }

  // WillPopScope(
  // onWillPop: Helper.of(context).onWillPop,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // key: _con.scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          // Image.asset("assets/img/food.jpg"),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     width: config.App(context).appWidth(100),
          //     height: config.App(context).appHeight(37),
          //     decoration: BoxDecoration(color: Theme.of(context).accentColor),
          //   ),
          // ),
          // Positioned(
          //   top: config.App(context).appHeight(37) - 120,
          //   child: Container(
          //     width: config.App(context).appWidth(84),
          //     height: config.App(context).appHeight(37),
          //     child: Text(
          //       S.of(context).lets_start_with_login,
          //       style: Theme.of(context)
          //           .textTheme
          //           .headline2
          //           .merge(TextStyle(color: Theme.of(context).primaryColor)),
          //     ),
          //   ),
          // ),
          Positioned(
            top: config.App(context).appHeight(37) - -90,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding:
                    EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@')
                            ? S.of(context).should_be_a_valid_email
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          // labelText: S.of(context).email,
                          labelText: "Email ID",
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // color: Theme.of(context).accentColor,
                              color: Colors.black),
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'johndoe@gmail.com',
                          hintStyle: TextStyle(color: Colors.white
                              //    color: Theme.of(context).focusColor.withOpacity(0.7),
                              ),
                          // prefixIcon: Icon(Icons.alternate_email,
                          //     color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.password = input,
                        validator: (input) => input.length < 3
                            ? S.of(context).should_be_more_than_3_characters
                            : null,
                        obscureText: _con.hidePassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: S.of(context).password,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,

                            // color: Theme.of(context).accentColor,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(16),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.7)),
                          // prefixIcon: Icon(Icons.lock_outline,
                          //     color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _con.hidePassword = !_con.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Checkbox(
                              value: true,
                              onChanged: (value) {
                                //todo
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(height: 12),

                      Container(
                        height: 50,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              end: Alignment.topLeft,
                              begin: Alignment.topRight,
                              colors: [
                                kPrimaryColorLiteorange,
                                kPrimaryColororange
                              ],
                            )),
                        child: ElevatedButton(
                          onPressed: () {
                            //todo
                            _con.login();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      // BlockButtonWidget(
                      //   text: Text(
                      //     S.of(context).login,
                      //     style:
                      //         TextStyle(color: Theme.of(context).primaryColor),
                      //   ),
                      //   color: Theme.of(context).accentColor,
                      //   onPressed: () {
                      //     _con.login();
                      //   },
                      // ),
                      SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   width:80,
                          //   child: ElevatedButton.icon(
                          //     // <-- ElevatedButton
                          //     onPressed: () {},
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.white,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(25)),
                          //     ),
                          //     icon: Image.asset("assets/img/google.png",height: 19,width: 19,),
                          //     label: Text(
                          //       'Sign in with Google',
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.normal,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Container(
                              padding: EdgeInsets.all(4),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24)
                              ),
                              child: Row(
                                children: [
                                  Image.asset("assets/img/google.png",height: 19,width: 19),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 8),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Container(
                              padding: EdgeInsets.all(4),

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              child: Row(
                                children: [
                                  Image.asset("assets/img/facebook.png",height: 19,width: 19),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 8),),
                                ],
                              ),
                            ),
                          ),
                          // ElevatedButton.icon(
                          //   // <-- ElevatedButton
                          //   onPressed: () {},
                          //   style: ElevatedButton.styleFrom(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(25)),
                          //   ),
                          //   icon: Image.asset("assets/img/facebook.png",height: 19,width: 19,),
                          //
                          //   label: Text(
                          //     'Sign in with Facebook',
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.normal,
                          //     ),
                          //   ),
                          // ),
                        ],
                      )

                      // MaterialButton(
                      //   elevation: 0,
                      //   focusElevation: 0,
                      //   highlightElevation: 0,
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .pushReplacementNamed('/Pages', arguments: 2);
                      //   },
                      //   shape: StadiumBorder(),
                      //   textColor: Theme.of(context).hintColor,
                      //   child: Text(S.of(context).skip),
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      // ),
//                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 10,
          //   child: Column(
          //     children: <Widget>[
          //       MaterialButton(
          //         elevation: 0,
          //         focusElevation: 0,
          //         highlightElevation: 0,
          //         onPressed: () {
          //           Navigator.of(context)
          //               .pushReplacementNamed('/ForgetPassword');
          //         },
          //         textColor: Theme.of(context).hintColor,
          //         child: Text(S.of(context).i_forgot_password),
          //       ),
          //       MaterialButton(
          //         elevation: 0,
          //         focusElevation: 0,
          //         highlightElevation: 0,
          //         onPressed: () {
          //           Navigator.of(context).pushReplacementNamed('/SignUp');
          //         },
          //         textColor: Theme.of(context).hintColor,
          //         child: Text(S.of(context).i_dont_have_an_account),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
