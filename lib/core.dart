import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'instamojo_dart_api.dart';

Future<Response> createOrder(
    Map<String, dynamic> body, Map<String, String> creds) async {
  final Map<String, dynamic> orderDetails =
      await createGatewayOrder(body, creds);
  if (orderDetails['status'] == "200") {
    final Response gwOrderDetails = await createOrderForGWOrder(
        orderDetails['order']['id'].toString(), creds);
    return gwOrderDetails;
  } else {
    return Response.badRequest(body: {'response': "Bad request"});
  }
}

Future<String> fetchToken(Map<String, String> creds) async {
  final LinkedHashMap<String, dynamic> body = LinkedHashMap();
  body['client_id'] = creds['clientId'];
  body['client_secret'] = creds['clientSecret'];
  body['grant_type'] = 'client_credentials';

  final LinkedHashMap<String, String> headers = LinkedHashMap();
  headers['Content-Type'] = 'application/x-www-form-urlencoded';
  String accessToken = "";
  String result = "";
  try {
    final res = await http.post("${creds['url']}/oauth2/token/",
        headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
    if (res != null && res.statusCode == 200) {
      result = res.body;
      print("${creds['url']}/oauth2/token/::\n$result");
      final dynamic jsonMap = jsonDecode(result) as Map;
      accessToken = jsonMap['access_token'].toString();
    }
  } catch (e) {
    print(e);
    result = null;
    accessToken = "";
  }
  return accessToken;
}

Future<Map<String, dynamic>> createGatewayOrder(
    Map<String, dynamic> data, Map<String, String> creds) async {
  final String accessToken = await fetchToken(creds);
  final LinkedHashMap<String, dynamic> body = LinkedHashMap();
  body['description'] = data['description'];
  body['currency'] = "INR";
  body['amount'] = data['amount'];
  body['phone'] = data['buyer_phone'];
  body['name'] = data['buyer_name'];
  body['transaction_id'] =
      "TRAN_${Random.secure().nextInt(1000000)}_${DateTime.now().millisecondsSinceEpoch}";
  body['redirect_url'] = '${creds['url']}/integrations/android/redirect/';
  body['send_email'] = "false";
  body['webhook'] = 'http://www.example.com/webhook/';
  body['send_sms'] = "false";
  body['email'] = data['buyer_email'];
  body['allow_repeated_payments'] = "true";

  final LinkedHashMap<String, String> headers = LinkedHashMap();
  headers['Authorization'] = 'Bearer ${accessToken}';
  String result = "";

  try {
    final res = await http.post("${creds['url']}/v2/gateway/orders/",
        headers: headers, body: body);
    if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
      result = res.body;
      print("${creds['url']}/v2/gateway/orders/::\n$result");
      final LinkedHashMap<String, dynamic> response = LinkedHashMap();
      final dynamic value = (jsonDecode(result) as Map) ?? "";
      response['status'] = "200";
      response['success'] = true;
      response['order'] = value['order'] ?? "";
      response['payment_options'] = value['payment_options'] ?? "";

      return response;
    } else {
      final LinkedHashMap<String, dynamic> response = LinkedHashMap();
      response['status'] = "400";
      response['success'] = "false";
      response['order'] = null;
      response['payment_options'] = null;
      response['message'] = "Bad request";
      return response;
    }
  } catch (e) {
    print(e);
    result = null;
    final LinkedHashMap<String, dynamic> response = LinkedHashMap();
    response['status'] = "201";
    response['success'] = "false";
    response['order'] = null;
    response['payment_options'] = null;
    response['message'] = "Something went wrong";
    return response;
  }
}

Future<Response> createOrderForGWOrder(
    String gatewayOrderID, Map<String, String> creds) async {
  print(
      "Creating order for gateway order (payment request) ID $gatewayOrderID");
  final String accessToken = await fetchToken(creds);
  final LinkedHashMap<String, dynamic> body = LinkedHashMap();
  body['id'] = gatewayOrderID;

  final LinkedHashMap<String, String> headers = LinkedHashMap();
  headers['Authorization'] = 'Bearer ${accessToken}';
  // headers['Content-Type'] = 'application/json';

  String result = "";
  try {
    final res = await http.post(
        "${creds['url']}/v2/gateway/orders/payment-request/",
        headers: headers,
        body: body);
    if (res != null && (res.statusCode == 200 || res.statusCode == 201)) {
      result = res.body;
      print("${creds['url']}/v2/gateway/orders/payment-request/::\n$result");
      return Response.ok(jsonDecode(result));
    }
  } catch (e) {
    print(e);
    return Response.badRequest(body: {"success": false});
  }
}
