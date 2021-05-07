import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// void main () => runApp(MyApp1()); //처음 메일 시작시 MyApp 위젯을 실행한다고 선언

// class MyApp extends StatelessWidget { //statefullwidget은 상태(값) 변경이 불가능한 위젯
//   @override
//   Widget build(BuildContext context) { //기본 빌드
//     return MaterialApp( //리턴은 마테리얼 앱으로 리턴
//       title: "Flutter Demo", //제목
//       theme: ThemeData(primarySwatch: Colors.blue),//테마
//       home: MyHomePage(title:'Flutter Demo Home Page'), //홈 중간에는 MyHomePage 위젯을 리턴해준다.(매개변수로 타이틀을 넘겨줌)
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {//stateFulWidget을 선언함으로서 상태변경이 가능함
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();//상태변경이 가능하므로 상태를 만들어주는 함수를 호출한다 => 한줄 리턴 이므로 화살표 함수 사용
// }
//
// class _MyHomePageState extends State<MyHomePage> { //MyHomePage의 상태를 정의하는 함수이므로 기존의 위젯을 매개변수로 스테이트를 상속받아야 한다.
//   int _counter = 0;
//   @override
//   Widget build(BuildContext context) { //빌드 설명
//     return Scaffold( //가장 기본적이 스카폴드 위젯
//       appBar: AppBar( //상단바 정의
//         title: Text(widget.title)
//       ),
//       body: Center( //중간 바디를 중앙 위젯으로 설정
//         child: Column(//자식요소로 칼럼과 로우 중 칼럼 지정
//           mainAxisAlignment: MainAxisAlignment.center,//정렬은 센터
//           children: <Widget>[//자식요소로는 위젯 배열
//             Text('You have pused button this many times,'),
//             Text("$_counter",style: Theme.of(context).textTheme.display1),
//             RaisedButton(
//                 child: Text("Second"),
//                 onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context) => second())),
//             )
//           ],
//         ),//
//       ),
//       floatingActionButton: FloatingActionButton(//바닥 액션 바
//         onPressed: _incrementCounter, //눌렀을때ㅔ 액션
//         tooltip: "Increment", //툴팁
//         child: Icon(Icons.add), //아이콘 설정
//       ),
//     );
//   }
//
//   void _incrementCounter() { //온 프레스 함수 정의
//     setState(() { //상태변경
//       _counter++;
//     });
//   }
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("hello world"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text("create button",style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 추가해준다.
                String book = "천년의_질문";
                firestore.collection('books').document(book)
                    .setData({ 'page': 433, 'purchase?': false, 'title':'천년의_질문'});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("read button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 읽어준다
                String title = "";
                firestore.collection("books").document("on_intelligence").get()
                .then((DocumentSnapshot ds){
                  title = ds.data["title"];
                  print(title);
                });
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("update button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 갱신해준다.
                firestore.collection("books").document("chemistry_between_us").updateData({"page":543});
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("delete button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 삭제해 준다.
                //특정 document 삭제
                firestore.collection("books").document("천년의_질문").delete();
                //특정 document field 하나를 삭제
                firestore.collection("books").document("chemistry_between_us").updateData({"page":FieldValue.delete()});
              },
            ),
          ],
        ),
      ),
    );
  }
}