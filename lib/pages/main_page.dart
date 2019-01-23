import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatelessWidget{
  Widget build(BuildContext context){
    return new Material(
      color: Colors.indigoAccent,
      child: new InkWell(
        onTap: () => print("Cliquei"),
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
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}