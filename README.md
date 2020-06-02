# instamojo_dart_api

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).

kushal@Kushals-MBP instamojo_dart_api % heroku config:set DART_SDK_URL=https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
Setting DART_SDK_URL and restarting ⬢ aqueductserv... done, v9
DART_SDK_URL: https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
kushal@Kushals-MBP instamojo_dart_api % heroku config:set BUILDPACK_URL=https://github.com/stablekernel/heroku-buildpack-dart.git
Setting BUILDPACK_URL and restarting ⬢ aqueductserv... done, v9
BUILDPACK_URL: https://github.com/stablekernel/heroku-buildpack-dart.git
kushal@Kushals-MBP instamojo_dart_api % heroku config:set DART_GLOBAL_PACKAGES="aqueduct@3.2.1"
Setting DART_GLOBAL_PACKAGES and restarting ⬢ aqueductserv... done, v9
DART_GLOBAL_PACKAGES: aqueduct@3.2.1
kushal@Kushals-MBP instamojo_dart_api % heroku config:set PATH=/app/bin:/usr/local/bin:/usr/bin:/bin:/app/.pub-cache/bin:/app/dart-sdk/bin
Setting PATH and restarting ⬢ aqueductserv... done, v9
PATH: /app/bin:/usr/local/bin:/usr/bin:/bin:/app/.pub-cache/bin:/app/dart-sdk/bin
kushal@Kushals-MBP instamojo_dart_api % heroku config:set PUB_CACHE=/app/pub-cache
Setting PUB_CACHE and restarting ⬢ aqueductserv... done, v9
PUB_CACHE: /app/pub-cache
kushal@Kushals-MBP instamojo_dart_api % git commit -am "Adds Procfile" On branch master
Your branch is ahead of 'origin/master' by 3 commits.
(use "git push" to publish your local commits)

nothing to commit, working tree clean
kushal@Kushals-MBP instamojo_dart_api % git push heroku master Everything up-to-date
kushal@Kushals-MBP instamojo_dart_api % git add .
kushal@Kushals-MBP instamojo_dart_api % git commit -m"second"
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
(use "git push" to publish your local commits)

nothing to commit, working tree clean
kushal@Kushals-MBP instamojo_dart_api % git push heroku master
Everything up-to-date
kushal@Kushals-MBP instamojo_dart_api % git add .  
kushal@Kushals-MBP instamojo_dart_api % git commit -m"second"
[master a62742c] second
1 file changed, 1 deletion(-)
kushal@Kushals-MBP instamojo_dart_api % git push heroku master
