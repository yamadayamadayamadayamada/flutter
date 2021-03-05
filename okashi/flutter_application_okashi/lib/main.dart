import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* メイン関数 */
void main() {
  runApp(MyApp());
}

/* カウンタクラス */
class CountModel extends ChangeNotifier {
  int count = 0;
  void increment() {
    count = count + 1;
    // 値が変更したことを知らせる >> UIを再構築する
    notifyListeners(); /* 教えてくれる */
  }
}

/* アプリクラス */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* 変更を受け付けるところ */
    return ChangeNotifierProvider<CountModel>(
      /* 作られた時の処理として、カウンタを生成 */
      create: (context) => CountModel(),
      child: Consumer<CountModel>(builder: (context, model, child) {
        /* 画面 */
        return Scaffold(
            appBar: AppBar(
              title: Text('Flutter Demo Home Page'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${Provider.of<CountModel>(context).count}',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              /* ボタンを押したときの処理 */
              onPressed: model.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ));
      }),
    );
  }
}
