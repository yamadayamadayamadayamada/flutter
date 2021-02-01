import 'dart:math';

import 'package:flutter/material.dart'; /* マテリアルデザインのインポート */

void main() {
  /* メイン関数 */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /* FlutterのクラスはすべてWidgetを継承している */
  /* StatelessWidgetは静的な関数 */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        /* デフォルトデザイン */
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'), /* 表示対象 */
    );
  }
}

/* 自分のアプリのHome */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key); /* コンストラクタ */
  final String title;
  @override
  /* とりあえず状態を、状態_MyHomePagteStateにする */
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int answerNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              /* これを挟むことで画像サイズを調整できる */
              child: jankenImage(),
            ),
            Padding(
              /* これを挟むことで余白を挿入できる */
              padding: EdgeInsets.all(20.0),
              child: jankenText(),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: FlatButton(
                onPressed: () {
                  int newAnswerNumber = 0;
                  print("タップされた");
                  do {
                    newAnswerNumber = Random().nextInt(3) + 1;
                  } while (answerNumber == newAnswerNumber);
                  setState(() {
                    answerNumber = newAnswerNumber;
                  });
                },
                color: Colors.pink,
                child: Text(
                  "じゃんけんをする！",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

/* answerNumberに応じた画像を返すメソッド */
  Widget jankenImage() {
    if (answerNumber == 0) {
      return Container();
    } else if (answerNumber == 1) {
      return Image.asset("images/gu.png");
    } else if (answerNumber == 2) {
      return Image.asset("images/choki.png");
    } else {
      return Image.asset("images/pa.png");
    }
  }

  /* answerNumberに応じたテキストを返すメソッド */
  Widget jankenText() {
    final fontSizeText = TextStyle(fontSize: 20);
    if (answerNumber == 0) {
      return Text(
        "これからじゃんけんをします",
        style: fontSizeText,
      );
    } else if (answerNumber == 1) {
      return Text("グー", style: fontSizeText);
    } else if (answerNumber == 2) {
      return Text("チョキ", style: fontSizeText);
    } else {
      return Text("パー", style: fontSizeText);
    }
  }
}
