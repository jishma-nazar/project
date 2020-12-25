import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/helper/helperfunctions.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:project/views/tempPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int index = 0;

  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  QuerySnapshot snapshotUserInfo;

  signUP() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(
          userNameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TempPage()));
      });
    }
  }

  bool userIsLoggedIn = false;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  signIN() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
        //print("${ snapshotUserInfo.docs[0].data()["name"]} blah");
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => userIsLoggedIn != null
                      ? userIsLoggedIn
                          ? TempPage()
                          : LoginPage()
                      : LoginPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: isLoading
            ? Container(
                color: Colors.indigo,
                child: Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.indigo[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.indigo[900]),
                    //strokeWidth: 5.0,
                  ),
                  height: 55.0,
                  width: 55.0,
                )),
              )
            : Stack(
                children: [
                  Center(
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      left: false,
                      right: false,
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        //background image in BoxDecoration
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            const Color(0xFFb29ddb), //FFCDD2
                            const Color(0xFF7986CB) //9FA8DA
                          ],
                        )),
                        child: Center(
                          child: ListView(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0.0, right: 200.0, top: 40.0),
                                  height: 90,
                                  width: 90,
                                  child: Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                          // child: new FlareActor(
                                          //   "assets/Face.flr",
                                          //   alignment: Alignment.center,
                                          //   fit: BoxFit.contain,
                                          //   animation: 'Waking',
                                          // ),
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                tabs(context),
                                SizedBox(
                                  height: 48.0,
                                  //width: 20.0,
                                ),
                                AnimatedCrossFade(
                                  duration: Duration(milliseconds: 130),
                                  firstChild: Stack(
                                      overflow: Overflow.visible,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          height: 300,
                                          width: 340,
                                          margin: EdgeInsets.only(bottom: 45.0),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              color: Colors.white),
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  validator: (val) {
                                                    return val.isEmpty ||
                                                            val.length <= 2
                                                        ? "Please provide a valid Username"
                                                        : null;
                                                  },
                                                  controller:
                                                      userNameTextEditingController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Username: ',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15.0,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.all(20.0),
                                                      prefixIcon: Icon(
                                                        Icons.account_circle,
                                                        color: Colors.grey,
                                                      ),
                                                      //labelStyle: TextStyle(color: Colors.black87),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                  width: 10.0,
                                                ),
                                                Divider(),
                                                TextFormField(
                                                  validator: (val) {
                                                    return RegExp(
                                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                            .hasMatch(val)
                                                        ? null
                                                        : "     Please provide a valid email ID";
                                                  },
                                                  controller:
                                                      emailTextEditingController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Email:',
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15.0),
                                                      prefixIcon: Icon(
                                                        Icons.email,
                                                        color: Colors.grey,
                                                      ),

                                                      //labelStyle: TextStyle(color: Colors.black87),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                  width: 10.0,
                                                ),
                                                Divider(),
                                                TextFormField(
                                                  validator: (val) {
                                                    return val.length > 6
                                                        ? null
                                                        : "     Password must be more than 6 characters";
                                                  },
                                                  // controller: passwordTextEditingController,
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      hintText: 'Password:',
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15.0),
                                                      prefixIcon: Icon(
                                                        Icons.lock,
                                                        color: Colors.grey,
                                                      ),
                                                      //labelStyle: TextStyle(color: Colors.black87),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                  width: 10.0,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 277,
                                          child: Container(
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  signUP();
                                                },
                                                child: Container(
                                                  //width: MediaQuery.of(context).size.width-100,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            const Color(
                                                                0xFF5c6bc0), //FFCDD2
                                                            const Color(
                                                                0xFFb39ddb) //9FA8DA
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 85.0),
                                                    child: Center(
                                                      child: Text(
                                                        'SIGN UP',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  secondChild: Stack(
                                      overflow: Overflow.visible,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 60.0),
                                          height: 180,
                                          width: 340.0,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.white),
                                          child: Form(
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  validator: (val) {
                                                    return RegExp(
                                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                            .hasMatch(val)
                                                        ? null
                                                        : "     Please provide a valid email ID";
                                                  },
                                                  controller:
                                                      emailTextEditingController,
                                                  decoration: InputDecoration(
                                                      hintText: 'Email:',
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15.0),
                                                      prefixIcon: Icon(
                                                        Icons.email,
                                                        color: Colors.grey,
                                                      ),

                                                      //labelStyle: TextStyle(color: Colors.black87),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                ),

                                                SizedBox(
                                                  height: 10.0,
                                                  width: 20.0,
                                                ),

                                                Divider(),

                                                TextFormField(
                                                  controller:
                                                      passwordTextEditingController,
                                                  validator: (val) {
                                                    return val.isEmpty ||
                                                            val.length <= 2
                                                        ? "Please provide a valid Username"
                                                        : null;
                                                  },
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      hintText: 'Password:',
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15.0),
                                                      prefixIcon: Icon(
                                                        Icons.lock,
                                                        color: Colors.grey,
                                                      ),
                                                      //labelStyle: TextStyle(color: Colors.black87),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent)),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                  // keyboardType: TextInputType.visiblePassword
                                                ),

                                                //SizedBox(
                                                //height: 20.0,
                                                //   width: 20.0,
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 160,
                                          child: Container(
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  signIN();
                                                },
                                                child: Container(
                                                  //width: MediaQuery.of(context).size.width-100,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            const Color(
                                                                0xFF5c6bc0), //FFCDD2
                                                            const Color(
                                                                0xFFb39ddb)
                                                            // const Color(0xFFFFCDD2), //FFCDD2
                                                            //const Color(0xFF7986CB) //9FA8DA
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 85),
                                                    child: Center(
                                                      child: Text(
                                                        'LOGIN',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          //color: Colors.white,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]),
                                  crossFadeState: index == 0
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                )
                              ], //login/sigUp tab
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

  Widget tabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
      child: Container(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo
              .withOpacity(0.30), //light background of login/signUp
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //login tab with rounded border
            Expanded(
              child: GestureDetector(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: index == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color:
                                index == 0 ? Colors.indigo[400] : Colors.white,
                            fontSize: index == 0 ? 24 : 13.5,
                            fontWeight: index == 0
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
            ),

            //sign up tab with rounded border
            Expanded(
              child: GestureDetector(
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      color: index == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color:
                                index == 1 ? Colors.indigo[400] : Colors.white,
                            fontSize: index == 1 ? 24 : 13.5,
                            fontWeight: index == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
