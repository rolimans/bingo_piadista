import 'package:bingo_piadista/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/number.dart';

class NumberSortingPage extends StatefulWidget{
  int _i = 0;
  int _len;
  String _old_n = "";

  List<Number> _nums;

  NumberSortingPage(this._nums){
   _len = this._nums.length;
  }

  NumberSortingPageState createState() => NumberSortingPageState();
}

class NumberSortingPageState extends State<NumberSortingPage> with SingleTickerProviderStateMixin{
  Animation<double> _spinAnimation;
  AnimationController _spinAnimationController;

  void initState(){
    super.initState();
    _spinAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    _spinAnimation = new CurvedAnimation(parent: _spinAnimationController, curve: Curves.bounceInOut);
    _spinAnimation.addListener(() => this.setState(() {}));
    _spinAnimationController.forward();
  }

  void dispose(){
    _spinAnimationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(vertical:40.0, horizontal: 10),
              child: new Text(
                  "Números já sorteados:",
                style: new TextStyle(fontSize: 25),
              ),
            ),
            new Expanded(
                child: new Padding(padding: EdgeInsets.symmetric(horizontal: 15), child:
                new Text(
                "${widget._old_n}| ${widget._nums[widget._i].number} ",
                textAlign: TextAlign.center,
                )
                  ,)
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Bingo Piadista"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.clear), onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'))
        ],
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Center(
            child: new RotationTransition(
              turns: new AlwaysStoppedAnimation(_spinAnimation.value),
              child: new Text(
                  widget._nums[widget._i].number.toString(),
                style: new TextStyle(fontSize: _spinAnimation.value * 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
            )
          ),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Center(
            child: new Text(
                (widget._nums[widget._i].piada != null)? '${widget._nums[widget._i].piada.toString()}': "",
              style: new TextStyle(fontSize: _spinAnimation.value * 25),
              textAlign: TextAlign.center,
            ),
          ),
          new Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          new Center(
            child: new Text(
                (widget._nums[widget._i].descricao != null)? '"${widget._nums[widget._i].descricao.toString()}"': "",
                style: new TextStyle(fontSize: _spinAnimation.value * 15),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      floatingActionButton: new Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: new FloatingActionButton(
              onPressed: () => setState(() {
                if(widget._i == widget._len-1){
                  _endGame();
                } else {
                  widget._old_n += "| ${widget._nums[widget._i].number} ";
                  widget._i++;
                  _spinAnimationController.reset();
                  _spinAnimationController.forward();
                }
            }),
            backgroundColor: Colors.amberAccent,
            tooltip: 'Próximo número',
            child: Icon(Icons.fast_forward),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _endGame() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fim de Jogo!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Clique no botão a seguir para iniciar uma nova partida!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Recomeçar'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                        (Route route) => route == null
                );
              },
            ),
          ],
        );
      },
    );
  }

}