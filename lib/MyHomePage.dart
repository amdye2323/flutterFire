import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';//asnyc / await 지원
import 'dart:convert';//JSON 데이터 처리 지원
import 'package:flutter/foundation.dart';//compute 함수를 제공
import 'package:http/http.dart' as http;
import 'package:testflutter/DTO/skuInfo.dart';
import 'package:testflutter/Home/HomeViewModel.dart';

import 'DTO/Photo.dart'; //http 프로토콜 지원
import 'DTO/skuInfo.dart';

class MyHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appTitle = "Isolate demo";
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _viewModel = HomeViewModel();

  Widget _todayQuestionView(skuInfo skuInfo) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(skuInfo.sku),
              Text(skuInfo.corCode),
              Text(skuInfo.skuLabel),
            ],
          ),
        )
    );
  }

  Widget _errorView(String errorMessage) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(errorMessage),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoNavigationBar(
        middle: Text("onono"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white60,
      body: FutureBuilder<skuInfo>(
        future: _viewModel.skuDetail(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return _todayQuestionView(snapshot.data);
          }else{
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}


// class MyHomePage extends StatelessWidget {
//   final String title;
//   MyHomePage({Key key, this.title}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       //photo의 리스트를 처리하는 FutureBuilder 추
//       body: FutureBuilder<List<skuInfo>>(
//         //future 항목에 fetchPhotos 함수 설정. fetchPhotos는 Future 객체를 결과값으로 반환
//         future: fetchPhotos(http.Client()),
//         //future 객체를 처리할 빌더
//         builder: (context,snapshot){
//           //에러가 발생하면 에러 출력
//           if(snapshot.hasError) print(snapshot.error);
//           //정상적으로 데이터가 수신된 경우
//           return snapshot.hasData
//               ? skuInfoList(skuList : snapshot.data)//PhotoList 출력
//               : Center(
//                   child: CircularProgressIndicator());//데이터 수신 전이면 인디케이터 출력
//         },
//       ),
//     );
//   }
// }
//
// //서버로부터 데이터를 수신하여 그 결과를 List<Photo> 형태의 Future 객체로 반환하는 async 함수
// Future<List<skuInfo>> fetchPhotos(http.Client client) async {
//   //해당 URL로 데이터를 요청하고 수신함
//   final response =
//       await client.get('alpha.golink.co.kr/stork/mobileSku?sku=101A0017');
//
//   //parsePOhotos 함수를 백그라운드 처리
//   return compute(parsePhotos,response.body);
// }
//
// //수신한 데이터를 파싱하여 List<Photos> 형태로 반환
// List<skuInfo> parsePhotos(String responseBody){
//   //수신 데이터를 JSON 포맷(JSON ARRAY)으로 디코딩
//   final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
//
//   //JSOn ARRAY를 List<Photo>로 변환하여 반환
//   return parsed.map<skuInfo>( (json) => skuInfo.fromJson(json)).toList();
// }
//
// class skuInfoList extends StatelessWidget {
//   final List<skuInfo> skuList;
//   const skuInfoList({Key key , this.skuList}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //그리드뷰를 builder를 통해 생성 . builder를 이요하면 화면이 스크롤 될때 해당 엘리면트가 렌더링 됨
//     return GridView.builder(
//         gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemCount: skuList.length,
//         itemBuilder: (context,index){
//           var sku = skuList[index];
//           //컨테이너를 생성하여 반환
//           return Container(
//             child: Column(
//               children: <Widget>[
//                 //이미지의 albumId와 ID 값을 출력
//                 Text("albumId : ${sku.sku} / ID : ${sku.skuLabel} / corCode : ${sku.corCode}"),
//               ],
//             ),
//           );
//         }
//     );
//   }
// }

