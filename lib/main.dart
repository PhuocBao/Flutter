import 'package:flutter/material.dart';
import 'package:demo_bmi/next_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class ResultSection extends StatelessWidget {
  final result, suggest;

  ResultSection(this.result, this.suggest);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Card(
          color: Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "Chỉ số BMI: " + result,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
                child: Text("Lời khuyên: " + suggest,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  bool _isDisplay = false;
  double height;
  double weight;
  String result, suggest;
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

  Widget _inputSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Text('Height'),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                autofocus: false,
                controller: heightController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Input your height',
                    labelStyle: TextStyle(fontSize: 13.0),
                    errorStyle: TextStyle(color: Colors.red),
                    counterStyle: TextStyle(color: Colors.red),
                    suffixText: '(m)',
                    suffixStyle: TextStyle(color: Colors.blue)),
                keyboardType: TextInputType.number,
                maxLength: 10,
                maxLengthEnforced: true,
                autocorrect: false,
                onChanged: (string) => height = double.parse(string),
              )),
          Container(
            margin: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
            child: Text('Weight'),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: weightController,
                autofocus: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Input your weight',
                    labelStyle: TextStyle(fontSize: 13.0),
                    errorStyle: TextStyle(color: Colors.red),
                    counterStyle: TextStyle(color: Colors.red),
                    suffixText: '(kg)',
                    suffixStyle: TextStyle(color: Colors.blue)),
                keyboardType: TextInputType.number,
                maxLength: 10,
                maxLengthEnforced: true,
                autocorrect: false,
                onChanged: (string) => weight = double.parse(string),
              ))
        ],
      ),
    );
  }

  _displayToggleDisplay() {
    setState(() {
      if (heightController.text.isEmpty || weightController.text.isEmpty) {
        result = 'Please input value';
        suggest = 'Please input value';
        _isDisplay = false;
      } else {
        _isDisplay = true;
      }
    });
  }

  Widget _buttonSection(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text("Display Result"),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: _displayToggleDisplay,
          ),
          RaisedButton(
            child: Text("Go to next page"),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NextPage(result, suggest))),
          ),
        ],
      ),
    ));
  }

  // Widget _resultSection(String result, String suggest) {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.only(top: 30.0),
  //       child: Card(
  //         color: Colors.blue,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(5.0))),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.all(20.0),
  //               child: Text(
  //                 "Chỉ số BMI: " + result,
  //                 style: TextStyle(fontSize: 20.0, color: Colors.white),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
  //               child: Text("Lời khuyên: " + suggest,
  //                   style: TextStyle(fontSize: 20.0, color: Colors.white)),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _caculateResult() {
    if (_isDisplay) {
      if (height == 0) {
        result = 'Nhập sai rồi';
        suggest = 'Nhập lại đi';
      } else {
        double bmi = weight / (height * height);
        if (bmi < 18.5 && bmi > 0) {
          result = 'Gầy';
          suggest = 'Ăn nhiều vào';
        } else if (bmi >= 18.5 && bmi < 25) {
          result = 'Bình thường';
          suggest = 'Cứ tiếp tục phát huy';
        } else if (bmi >= 25.0 && bmi < 40) {
          result = 'Cao';
          suggest = 'Giảm cân đi';
        } else if (bmi >= 40) {
          result = 'Nguy hiểm';
          suggest = 'Thôi đừng giảm cân nữa, sắp chết rồi :v';
        } else if (bmi <= 0) {
          result = 'Nhập sai rồi';
          suggest = 'Nhập lại đi';
        }
      }
      return ResultSection(result, suggest);
    } else {
      return Center(
          child: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Text("Please input your height and weight"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("BMI Calculator"),
          ),
          body: ListView(
            // addAutomaticKeepAlives: true,
            children: <Widget>[
              _inputSection(),
              _buttonSection(context),
              _caculateResult(),
            ],
          )),
    );
  }
}
