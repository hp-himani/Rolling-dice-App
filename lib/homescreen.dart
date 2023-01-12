import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  int li=1, ri=1;
  late AnimationController _cntrl;
  late CurvedAnimation an;
  @override
  void initState() {
    super.initState();
    animate();
  }
  animate(){
    _cntrl = AnimationController(duration: Duration(seconds: 1), vsync: this);
    an = CurvedAnimation(parent: _cntrl, curve: Curves.bounceOut);
    _cntrl.addListener(() {
      setState(() {
      });
      print(_cntrl.value);});
    _cntrl.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          li= Random().nextInt(6)+1;
          ri= Random().nextInt(6)+1;
        });
        print("completed");
        _cntrl.reverse();
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _cntrl.dispose();
  }

  void roll(){
    _cntrl.forward();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rolling Dice',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dicee"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Image(
                          height: 200- an.value*200,
                          image: AssetImage('images/dice-$li.png')),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: roll,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Image(
                          height: 200- an.value*200,
                          image: AssetImage('images/dice-$ri.png')),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              // style: ButtonStyle(
              //
              // ),
                onPressed: roll,
                child: Text("Roll")
            ),
          ],
        ),
      ),
    );
  }
}
