// 深圳二手房交易
import 'package:helloworld/page/szdata/dto/second_hand_deal.dart';

class SecondHandDealDto {
  String? date;
  int? total;
  List<SecondHandDeal>? data;

  SecondHandDealDto(this.date, this.total, this.data);

  SecondHandDealDto.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    total = json['total'];
    data = <SecondHandDeal>[];
    json['data'].forEach((item) => data!.add(SecondHandDeal.fromJson(item)));
        //json['data'].map(item => SecondHandDeal.fromJson(item)).toList() as List<SecondHandDeal>;
  }
}
