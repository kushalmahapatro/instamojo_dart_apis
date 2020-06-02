class Config {
  Config(
      {this.prodClientID,
      this.prodClientSecret,
      this.testClientID,
      this.testClientSecret,
      this.prodURL,
      this.testURL});
  final String prodClientID;

  final String prodClientSecret;

  final String testClientID;

  final String testClientSecret;

  final String prodURL;

  final String testURL;
}

Config _config;

Config get config {
  return _config;
}

set config(Config value) {
  if (value != null) {
    _config = value;
  }
}
