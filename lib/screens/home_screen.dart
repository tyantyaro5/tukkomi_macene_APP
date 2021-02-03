import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:soundpool/soundpool.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // String _text01 = "なんでやねん";
  // String _text02 = "あかん";
  // String _text03 = "ええ加減にせんかい";
  // String _text04 = "もうええわ";
  // String _text05 = "儲かりまっか";
  // String _text06 = "おおきに";

  List<String> _texts = [
    "なんでやねん",
    "あかん",
    "ええ加減にせんかい",
    "もうええわ",
    "儲かりまっか",
    "おおきに",
  ];

  List<int> _soundIds = [0, 0, 0, 0, 0, 0];

  Soundpool _soundpool;

  int number = 3;

  @override
  void initState() {
    super.initState();
    _initSounds();
  }

  Future<void> _initSounds() async {
    _soundpool = Soundpool();

    _soundIds[0] = await loadSound("assets/sounds/line-girl1-nandeyanen1.mp3");
    _soundIds[1] = await loadSound("assets/sounds/line-girl1-akan1.mp3");
    _soundIds[2] = await loadSound("assets/sounds/line-girl1-eekagennnisenkai1.mp3");
    _soundIds[3] = await loadSound("assets/sounds/line-girl1-moueewa1.mp3");
    _soundIds[4] = await loadSound("assets/sounds/line-girl1-moukarimakka1.mp3");
    _soundIds[5] = await loadSound("assets/sounds/line-girl1-ookini1.mp3");

    setState(() {

    });
  }
    Future<int> loadSound(String soundPath){
      return rootBundle.load(soundPath).then((value) => _soundpool.load(value));
    }
    
  @override
  void dispose() {
    _soundpool.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ツッコミマシーン"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1, //等間隔に広げる処理
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch, //縦にボタンを広げる処理
                children: [
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[0], _soundIds[0])),
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[1], _soundIds[1])),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[2], _soundIds[2])),
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[3], _soundIds[3])),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[4], _soundIds[4])),
                  Expanded(
                      flex: 1, child: _soundsButton(_texts[5], _soundIds[5])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _soundsButton(String displayText, int soundId) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
        onPressed: () => _playSound(soundId),
        child: Text(displayText),
      ),
    );
  }

  void _playSound(int soundId) {
    _soundpool.play(soundId);
  }



}
