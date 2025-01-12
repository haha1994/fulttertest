// 深圳二手房交易
class SecondHandDeal {
  final String id;
  final String zone;
  final String houseUsage2;
  final int cjNum;
  final double cjArea;
  final String tjDate;

  SecondHandDeal(this.id, this.zone, this.houseUsage2, this.cjNum, this.cjArea,
      this.tjDate);

  SecondHandDeal.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as String,
        zone = json['ZONE'] as String,
        houseUsage2 = json['HOUSE_USAGE2'] as String,
        cjNum = json['CJ_NUM'] as int,
        cjArea = json['CJ_AREA'] as double,
        tjDate = json['TJ_DATE'] as String;

  String toDisplayString() {
    String result = "区域：$zone 类型：$houseUsage2 成交套数：$cjNum 成交面积：$cjArea 提交时间：$tjDate";
    return result;
  }
}
