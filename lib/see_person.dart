import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/feedback.dart';
import 'main.dart' as home;
import 'chat_screen.dart' as chat;

class SeePersonInCharge extends StatefulWidget {
  _SeePersonInChargeState createState() => _SeePersonInChargeState();
}

class _SeePersonInChargeState extends State<SeePersonInCharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('images/avatar_container.png'))),
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 30.0,
                                top: 8.0),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                child: Image.asset(
                                  'images/profile_pic.jpg',
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100.0)),
                              ),
                            )),                   
                     ),
                     Container(
                       margin: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                       child: home.textTheme('Ms. Thao Thai', Colors.grey, 30.0),
                     ),
                     home.textTheme('HR Manager', Colors.grey, 20.0),
                     Container(
                       margin: const EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                       decoration: BoxDecoration(
                         borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                         color: Colors.grey[300]
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(25.0),
                         child: Text('This is something about Thao Thai, may be some fun facts')
                       ),
                     )
                    ],
                  ),
                )),
                Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1 / 3 - 20,
              child: Align(
                  alignment: Alignment.bottomRight,
                  // child: Container(
                  //   margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      chat.optionsSection('See the progress'),
                      chat.optionsSection('See who you will meet'),
                      chat.optionsSection('Play with Welcome Robot'),
                      chat.optionsSection('Rate my feedback',() => Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen())))
                    ],
                  )
                  // ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
