import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  var boxOneController = TextEditingController();
  var boxTwoController = TextEditingController();
  var boxTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Point Scorer"),
        ),
        body: ListView( shrinkWrap: false, children: <Widget>[ Container(
          color: Colors.blueGrey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              Text('Player 1:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 30.0, right: 30.0),
                      child: Container(
                        color: Colors.white,
                          child: TextField(
                        controller: boxOneController,
              ))),
              Text('Player 2:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 30.0, right: 30.0),
                  child: Container(
                      color: Colors.white,
                      child: TextField(
                        controller: boxTwoController,
                      ))),
              Text('Time:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 150.0, right: 150.0),
                  child: Container(
                      color: Colors.white,
                      child: TextField(
                        controller: boxTimeController,
                      ))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    child: Text('Enter'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScorePage(
                                boxOneController.text,
                                boxTwoController.text,
                                boxTimeController.text)),
                      );
                    },
                  )),
                Padding(padding: const EdgeInsets.all(10),),
                Image(image:AssetImage('assets/sports.png'),),
                Padding(padding: const EdgeInsets.all(20),),
            ],
          ),
        )]));
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    return new Text(
      animation.value.toString(),
      style: new TextStyle(fontSize: 150.0),
    );
  }
}

class ScorePage extends StatefulWidget {
  var playerOneName;
  var playerTwoName;
  var time;
  ScorePage(this.playerOneName, this.playerTwoName, this.time, {Key key})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> with TickerProviderStateMixin {
  AnimationController _controller;
  int _counter = 0;
  int _counter2 = 0;

  _ScorePageState();

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: int.parse(widget.time))
    );
  }

  void stop() {
    _controller =AnimationController(
      vsync: this,
      //duration: Duration(s)
    );
  }

  void pauseState() {
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _incrementCounter2() {
    setState(() {
      _counter2++;
    });
  }

  void _decrementCounter2() {
    setState(() {
      _counter2--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Score Page"),
      ),
      body: Container(
          color: Colors.blueGrey,
          child: ListView( shrinkWrap: true, children: <Widget>[
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              children: <Widget>[
              //Timer///////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.all(5.0),
                ),
                Countdown(
                  animation: StepTween(
                    begin: int.parse(widget.time),
                    end: 0,
                  ).animate(_controller),
                ),
                Row(children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 120),
                    child:
                      RawMaterialButton(
                        fillColor: Colors.greenAccent,
                        shape: const CircleBorder(),
                        constraints: BoxConstraints.tight(Size(60.0, 60.0)),
                        child: Icon(Icons.play_arrow),
                        onPressed: () { 
                            if (_controller.isAnimating)
                              _controller.stop();
                            else {
                              _controller.forward(
                                from: _controller.value
                              );
                          }
                        }
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(left: 10),
                    child:
                      RawMaterialButton(
                        fillColor: Colors.redAccent,
                        shape: const CircleBorder(),
                        constraints: BoxConstraints.tight(Size(60.0, 60.0)),
                        child: Icon(Icons.stop),
                        onPressed: () => _controller.reset(),
                      ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(15),
                ),
              //////////////////////////////////////////////////////////
                Text(
                  '${widget.playerOneName}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                ),
                Padding(padding: const EdgeInsets.all(5),),

                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 10),
                    child: Text(':', style: TextStyle(fontSize: 30)),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                    RawMaterialButton(
                      fillColor: Colors.grey,
                      constraints: BoxConstraints.tight(Size(70.0, 70.0)),
                      onPressed: _incrementCounter,
                      //tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    Padding(padding: const EdgeInsets.all(10),),
                    RawMaterialButton(
                      fillColor: Colors.grey,
                      constraints: BoxConstraints.tight(Size(70.0, 70.0)),
                      onPressed: _decrementCounter,
                      //tooltip: 'Increment',
                      child: Icon(Icons.remove),
                    ),
                ]),

                Padding(padding: const EdgeInsets.all(10),),
                Text(
                  '${widget.playerTwoName}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                ),
                Padding(padding: const EdgeInsets.all(5),),
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 10),
                    child: Text(':',
                        style: TextStyle(fontSize: 30)
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '$_counter2',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                    RawMaterialButton(
                      fillColor: Colors.grey,
                      constraints: BoxConstraints.tight(Size(70.0, 70.0)),
                      onPressed: _incrementCounter2,
                      //tooltip: 'Increment',
                      child: Icon(Icons.add),
                    ),
                    Padding(padding: const EdgeInsets.all(10),),
                    RawMaterialButton(
                      fillColor: Colors.grey,
                      constraints: BoxConstraints.tight(Size(70.0, 70.0)),
                      onPressed: _decrementCounter2,
                      //tooltip: 'Increment',
                      child: Icon(Icons.remove),
                    ),
                ]),
                Padding(padding: const EdgeInsets.all(10),),
              ],
            ),
          )]),
        )
    );
  }
}
