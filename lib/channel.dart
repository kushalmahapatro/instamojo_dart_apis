import 'dart:collection';

import 'package:instamojo_dart_api/core.dart';
import 'instamojo_dart_api.dart';

class InstamojoDartApiChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    initConfigs();
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();
    router.route("/order").linkFunction((request) async {
      final map = await request.body.decode<Map<String, dynamic>>();
      LinkedHashMap<String, String> creds =
          getEnvironmentCreds(map['env'].toString());
      final response = await createOrder(map, creds);
      return response;
    });

    router.route("/").linkFunction((request) {
      return Response.ok({"message": "Welcome to Instamojo Dart Rest Api"});
    });

    return router;
  }
}

LinkedHashMap<String, String> getEnvironmentCreds(String environment) {
  final LinkedHashMap<String, String> env = new LinkedHashMap();
  switch (environment) {
    case "TEST":
      {
        env['clientId'] = config.testClientID.toString();
        env['clientSecret'] = config.testClientSecret.toString();
        env['url'] = config.testURL.toString();
        break;
      }
    case "PRODUCTION":
      {
        env['clientId'] = config.prodClientID;
        env['clientSecret'] = config.prodClientSecret;
        env['url'] = config.prodURL;
        break;
      }
    default:
      {
        env['clientId'] = config.testClientID;
        env['clientSecret'] = config.testClientSecret;
        env['url'] = config.testURL;
        break;
      }
  }
  return env;
}

void initConfigs() {
  config = Config(
      prodClientID: "", //Put your client id over here//,
      prodClientSecret: "", // Put your client secret key here,
      testClientID: "", // Put your testClient Id,
      testClientSecret: "", // Put your testClient secret key,
      prodURL: "https://api.instamojo.com",
      testURL: "https://test.instamojo.com");
}
