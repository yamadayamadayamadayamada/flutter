import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'music app'), /* ここで上に表示する文字を変えられる */
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //シンバル用
  final cymbalPlayer = AudioCache(fixedPlayer: AudioPlayer());
  AudioPlayer cymbalAudioSource;
  // ギター用Audio
  final guitarPlayer = AudioCache(fixedPlayer: AudioPlayer());
  AudioPlayer guitarAudioSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Image.asset(
            "images/background.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          SafeArea(
            child: Center(
              child: Row(
                /* 横に並べる */
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                      onPressed: () async {
                        /* 非同期関数として定義される */
                        if (cymbalAudioSource != null) {
                          cymbalAudioSource.stop();
                        }
                        /* シンバルを再生 */
                        cymbalAudioSource = await cymbalPlayer.play(
                            "cymbalSound.mp3",
                            mode: PlayerMode.LOW_LATENCY);
                      },
                      child: Image.asset('images/cymbal.png')),
                  FlatButton(
                      onPressed: () async {
                        if (guitarAudioSource != null) {
                          // すでに再生中なら一旦停止する
                          guitarAudioSource.stop();
                        }
                        // AudioCacheを用いて再生
                        guitarAudioSource = await guitarPlayer.play(
                            'guitarSound.mp3',
                            mode: PlayerMode.LOW_LATENCY);
                      },
                      child: Image.asset('images/guitar.png')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
