import 'package:flutter/material.dart';
import 'package:flutter_range_selector/custom_range_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Range Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double start = 0.25;
  double end = 0.75;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double rsWidth =size.width*0.75;
    double rsHeight = rsWidth*0.25;
    return Scaffold(
      backgroundColor:  Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomRangeSelector(
              width: rsWidth,
              height: rsHeight,
              divisions: 10,
              start: start,
              end: end,
              onStartChange: (value){
                setState(() {
                  start = value;
                });
              },
              onEndChange: (value){
                setState(() {
                  end= value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("Start: $start   |   End: $end",
              style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}



