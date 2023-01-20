import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:infosyst/api/apiConstant.dart';

class ApiFunction {
  Future loginApi(String userId, String pass) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    Map par = {"username": userId, "password": pass};
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(url + login));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(par)));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    EasyLoading.dismiss();
    httpClient.close();
    return res;
  }

  Future getAllProduct() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    // Map par = {"username": userId, "password": pass};
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse(url + allProduct));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(par)));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    EasyLoading.dismiss();
    httpClient.close();
    return res;
  }

  Future getAllProductCategory() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    // Map par = {"username": userId, "password": pass};
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse(url + allCategoryProduct));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(par)));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    List res = json.decode(reply);
    EasyLoading.dismiss();
    httpClient.close();
    return res;
  }

  Future getAllProductByCategory(String category) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    // Map par = {"username": userId, "password": pass};
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse("$url$allByCategory/$category"));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(par)));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    EasyLoading.dismiss();
    httpClient.close();
    return res;
  }

  Future searchItem(String value) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    // Map par = {"username": userId, "password": pass};
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await httpClient.getUrl(Uri.parse("$url$searchItemConst$value"));
    // request.headers.set('content-type', 'application/json');
    // request.add(utf8.encode(json.encode(par)));
    HttpClientResponse response = await request.close();

    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    EasyLoading.dismiss();
    httpClient.close();
    return res;
  }
}
