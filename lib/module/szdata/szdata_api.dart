import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:helloworld/module/szdata/dto/second_hand_deal.dart';
import 'package:helloworld/module/szdata/dto/second_hand_deal_dto.dart';
import 'package:logger/logger.dart';

typedef RequestCallBack<T> = void Function(T value);

class SzdataApi {
  final Logger logger = Logger();
  static const String BASE_URL = "https://opendata.sz.gov.cn";

  //static const String SECOND_HAND_DEAL = "/api/29200_01903513/1/service.xhtml?page=1&rows=10&appKey=0dc4dee091444a85b74e8e6782f0adab";
  static const String SECOND_HAND_DEAL = "/api/29200_01903513/1/service.xhtml";

  static const String appKey = "0dc4dee091444a85b74e8e6782f0adab";

  // 命名参数写在{}中
  void findSecondHandDeal(
      {Map<String, dynamic>? queryParameters,
      RequestCallBack<SecondHandDealDto>? requestCallBack}) async {
    String url = BASE_URL + SECOND_HAND_DEAL;

    // todo 断网了会直接报错 SocketException: Failed host lookup: 'opendata.sz.gov.cn'
    Dio dio = Dio();
    Options options =
        Options(headers: {HttpHeaders.acceptHeader: "application/json"});

    // 判断空，如果空就创建一个
    queryParameters ??= <String, dynamic>{};
    queryParameters['appKey'] = appKey;

    Response response =
        await dio.get(url, options: options, queryParameters: queryParameters);
    logger.i(response);
    SecondHandDealDto result =
        SecondHandDealDto.fromJson(json.decode(response.data));
    List<SecondHandDeal> items = result.data!;
    // List data = json.decode(response.data)["data"];
    // data.map((item) => SecondHandDeal.fromJson(item)).toList();

    if (requestCallBack != null) {
      requestCallBack(result);
    }
  }

  void testMethod(RequestCallBack requestCallBack) async {
    String username = "";
    String password = "";
    String base64 = base64Encode(utf8.encode("$username:$password"));
    String basicAuth = "Basic $base64";
    Dio dio = Dio();
    String url = BASE_URL + SECOND_HAND_DEAL;

    Options options = Options(headers: {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: basicAuth
    });
    Response response = await dio.get(url, options: options);
    List result = json.decode(response.data)["data"];
    requestCallBack(result);
  }
}
