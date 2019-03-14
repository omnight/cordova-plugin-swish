# cordova-plugin-swish

This is my [Apache Cordova](https://cordova.apache.org) swish plugin containing support for Android and iOS. 


## Getting started

Once you're familiar with that process, you may install this plugin with the [Cordova CLI](https://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html):

```
cordova plugin add cordova-plugin-swish --variable URL_SUFFIX=https://github.com/mattiasclaessonfujitsu/cordova-plugin-swish.git
```

## Usage

If the plugin was added to your Cordova (or Ionic) project, you may use it like that:

```
swish.prototype.isSwishInstalled({function} successCallback);
swish.prototype.beginPayment({string} token, {function} successCallback);
```
