import '../DTO/skuInfo.dart';
import '../service/stockService.dart';

class HomeViewModel {
  var _service = stockService();

  Future<skuInfo> skuDetail() {
    return Future.delayed(Duration(seconds: 2) , (){
      return _service.requestSkuInfo();
    });
  }
}