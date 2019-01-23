import 'package:flutter/material.dart';

class NumberSortingPage extends StatefulWidget{

  NumberSortingPage({Key key}) : super(key: key);

  NumberSortingPageState createState() => NumberSortingPageState();
}

class NumberSortingPageState extends State<NumberSortingPage>{

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bingo Piadista"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.clear), onPressed: () => print("close"))
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Center(
            child: new RotationTransition(
              turns: new AlwaysStoppedAnimation(45 / 360),
              child: new Text(
                  "22",
                style: new TextStyle(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            )
          ),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Center(
            child: new Text(
              '"Dois Patinhos na Lagoa"',
              style: new TextStyle(fontSize: 25)
            ),
          ),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Center(
            child: new Text(
                '"Descrição"',
                style: new TextStyle(fontSize: 15)
            ),
          )
        ],
      ),
      floatingActionButton: new Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: new FloatingActionButton(
              onPressed: () => setState(() {
              print("ALO");
              _neverSatisfied(context);
            }),
            backgroundColor: Colors.amberAccent,
            tooltip: 'Próximo número',
            child: Icon(Icons.navigate_next),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Future<void> _neverSatisfied(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rewind and remember'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You will never be satisfied.'),
              Text('You\’re like me. I’m never satisfied.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}