import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:numberpicker/numberpicker.dart';
import '../util/piadas_fetcher.dart';

class MainPage extends StatefulWidget{
  MainPage({Key key}) : super(key: key);

  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>{
  int _n = 75;

  Widget build(BuildContext context){
    return new Material(
      color: Colors.indigoAccent,
      child: new InkWell(
        onTap: test,
        child: new Column(
          children: <Widget>[
            new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                        "Toque Para Iniciar o Bingo Piadista",
                      style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                    new RaisedButton(
                      onPressed: _showIntDialog,
                    child: new Text(
                        "Número de pedras do bingo: $_n",
                      style: new TextStyle(fontSize: 18),
                    ),
                      color: Colors.tealAccent,
                      padding: EdgeInsets.all(10.0),
                    ),
                    new Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                    new Icon(
                      Icons.play_circle_filled,
                      color: Colors.white,
                      size: 45,
                    )
                  ],
                )
            ),
            new Padding(padding: EdgeInsets.all(5.0),
                child: new Align(
                  alignment: Alignment.centerRight,
                    child: new RichText(
                        text: new TextSpan(
                            children: [
                                new TextSpan(
                                  text: 'Desenvolvido em um dia por: ',
                                  style: new TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic),
                                  ),
                                new TextSpan(
                                  text: 'Eduardo Amaral ❤',
                                  style: new TextStyle(color: Colors.amber, fontStyle: FontStyle.italic, fontSize: 13),
                                  recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                      _launchURL("http://amarall.com");
                                    },
                                )
                            ],
                        )
                    ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 1,
          maxValue: 100,
          initialIntegerValue: _n,
          title: new Text("Número de pedras do bingo:"),
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _n = value);
      }
    });
  }

  void test(){
    new PiadasFetcher().readData.then((palo) => print(palo));
  }

}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}