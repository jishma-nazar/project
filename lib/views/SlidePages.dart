import 'package:flutter/material.dart';
import 'package:project/views/LoginPage.dart';
import 'package:introduction_screen/introduction_screen.dart';


class SlidePages extends StatefulWidget {
  @override
  _SlidePagesState createState() => _SlidePagesState();
}

class _SlidePagesState extends State<SlidePages> {

  int index = 0;

  List<PageViewModel> getPages() {
    return [

      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    const Color(0xFFb29ddb), //FFCDD2
                    const Color(0xFF7986CB) //9FA8DA
                  ],
                ),
              )
          ),
          image: Container(
            //margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/purple.jpeg'),
              // backgroundColor: Colors.deepPurple[100],
              // child: ClipOval(
              //   child: Image(
              //     image: AssetImage('images/purple.jpeg'),
              //     alignment: Alignment.center,
              //   ),
              // ),
            ),
          ),
          titleWidget: Text('Slider Page',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
            ),),
          body: "Number 1"
        //footer: Text('bleeeh'),
      ),
      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    const Color(0xFFb29ddb), //FFCDD2
                    const Color(0xFF7986CB) //9FA8DA
                  ],
                ),
              )
          ),
          image: Container(
            //margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/purple.jpeg'),
              // backgroundColor: Colors.deepPurple[100],
              // child: ClipOval(
              //   child: Image(
              //     image: AssetImage('images/purple.jpeg'),
              //     alignment: Alignment.center,
              //   ),
              // ),
            ),
          ),
          titleWidget: Text('Slider Page',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
            ),),
          body: "Number 2"
        //footer: Text('bleeeh'),
      ),
      PageViewModel(
          decoration: PageDecoration(
              boxDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    const Color(0xFFb29ddb), //FFCDD2
                    const Color(0xFF7986CB) //9FA8DA
                  ],
                ),
              )
          ),
          image: Container(
            //margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.only(top: 50.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/purple.jpeg'),
              // backgroundColor: Colors.deepPurple[100],
              // child: ClipOval(
              //   child: Image(
              //     image: AssetImage('images/purple.jpeg'),
              //     alignment: Alignment.center,
              //   ),
              // ),
            ),
          ),
          titleWidget: Text('Slider Page',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
            ),),
          body: "Number 3"
        //footer: Text('bleeeh'),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroductionScreen(
          curve: Curves.bounceInOut,
          animationDuration: 300,
          dotsDecorator: DotsDecorator(
              activeColor: Color(0xFF594979),
              color: Color(0xFF907cb5),
              activeShape: RoundedRectangleBorder()
          ),
          done: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.white,
            onPressed: () {},
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color: Color(0xFF8775a8)),
              onPressed: () {
                Navigator.push(context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder: (context,
                            Animation<double> animation,
                            Animation<double> secAnimation, Widget child) {
                          return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child);
                        },

                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secAnimation) {
                          return LoginPage();
                        }
                    ));
              },
            ),
          ),
          onDone: () {},
          pages: getPages(),
          globalBackgroundColor: Colors.deepPurple[100],

        ),
      ),
    );
  }

}
