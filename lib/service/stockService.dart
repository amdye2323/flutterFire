import 'package:http/http.dart' as http;
import 'dart:convert';

import '../DTO/skuInfo.dart';

class stockService {

  Future<skuInfo> requestSkuInfo() async {
    String url = "localhost:8072/stork/mobileSku?sku=101A0017";
    Map<String,String> header = {"Content-Type" : "application/json" , "Accept" : "application/json"};
    var response = await http.get(url,headers:header);

    String resonsBody =  utf8.decode(response.bodyBytes);
    var json =  jsonDecode(resonsBody);

    print(json);
    if(json.hashCode==200){
      return skuInfo(sku:json["sku"],corCode: json["corCode"],skuLabel: json["skuLabel"]);
    }else{
      return Future.error(json["state"]);
    }
  }
}