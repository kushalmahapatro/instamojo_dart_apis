import 'package:instamojo_dart_api/instamojo_dart_api.dart';

Future main() async {
  final app = Application<InstamojoDartApiChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8333;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
