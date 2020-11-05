import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [

            Center(
              child: SafeArea(
                top: false,
                bottom: false,
                left: false,
                right: false,
                child: Container(
                  padding: EdgeInsets.only(top:50),
                  //background image in BoxDecoration
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/original.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: ListView(
                        children: [

                          Column(
                            mainAxisAlignment:MainAxisAlignment.start,

                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0.0,right: 200.0,top: 40.0),
                                height: 90,
                                width: 90,
                                child: Container(
                                  child: CircleAvatar(

                                    backgroundColor: Colors.white,
                                    child: ClipOval(

                                      child: new FlareActor(
                                        "assets/Face.flr",
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: 'Waking',
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              tabs(context),

                              SizedBox(
                                height: 22.0,
                                width: 20.0,
                              ),

                              AnimatedCrossFade(
                                duration: Duration(milliseconds: 200),
                                firstChild: signUp(context),
                                secondChild: login(context),
                                crossFadeState: index==0? CrossFadeState.showFirst:CrossFadeState.showSecond,
                              ),

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

  Widget login(BuildContext context) {
    return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 60.0),
            height: 160,
            width: 340.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.purple[50]
            ),


            child:Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'User name:',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0,
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      prefixIcon: Icon(Icons.account_circle,color: Colors.grey,),
                      //labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                  ),),

                SizedBox(
                  height: 10.0,
                  width: 20.0,
                ),

                Divider(),


                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password:',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0
                      ),
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                      //labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                  ),),

                SizedBox(
                  height: 20.0,
                  width: 20.0,
                )

              ],
            ) ,
          ),

          Positioned(
            top: 140,
            child: Container(
              child: Center(
                child: GestureDetector(
                  child: Container(
                    //width: MediaQuery.of(context).size.width-100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFFCDD2), //FFCDD2
                              const Color(0xFF7986CB) //9FA8DA
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 85),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style:TextStyle(
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0) ,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]);
  }

  Widget signUp(BuildContext context){

    return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 240,
            width: 340,
            margin: EdgeInsets.only(bottom: 40.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.purple[50]
            ),


            child:Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email:',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0,
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      prefixIcon: Icon(Icons.account_circle,color: Colors.grey,),
                      //labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                  ),),

                SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),

                Divider(),


                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password:',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0
                      ),
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),

                      //labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                  ),),

                SizedBox(
                  height: 10.0,
                  width: 10.0,
                ),

                Divider(),

                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Re-enter Password:',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0
                      ),
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                      //labelStyle: TextStyle(color: Colors.black87),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))

                  ),),

                SizedBox(
                  height: 20.0,
                  width: 10.0,
                )

              ],
            ) ,
          ),

          Positioned(
            top: 220,
            child: Container(
              child: Center(
                child: GestureDetector(
                  child: Container(
                    //width: MediaQuery.of(context).size.width-100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFFCDD2), //FFCDD2
                              const Color(0xFF7986CB) //9FA8DA
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 85.0),
                      child: Center(
                        child: Text(
                          'SIGN UP',
                          style:TextStyle(
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0) ,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ]);
  }

  Widget tabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30.0,left: 15.0,right:15.0 ),
      child: Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.18), //light background of login/signUp
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
                          color: index==0? Colors.white: Colors.transparent,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: index==0?Colors.indigo[200]:Colors.white,
                                fontSize: index==0? 24:13.5,
                                fontWeight: index==0?FontWeight.bold:FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
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
                          color: index==1?Colors.white:Colors.transparent,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: index==1?Colors.indigo[200]:Colors.white,
                                fontSize: index==1? 24:13.5,
                                fontWeight: index==1? FontWeight.bold: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
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