library dio_proxy;

import 'dart:io';

import 'package:dio/adapter.dart';

/// Dio HttpProxy Adapter 给通过网关的请求加上签名
/// [ipAddr] ip地址，默认是localhost
/// [port] 端口，默认是8888
/// [proxyIsEnable] 代理是否启用，默认是false，不启用
///
class HttpProxyAdapter extends DefaultHttpClientAdapter {
  final String ipAddr;
  final int port;
  final bool proxyIsEnable;

  HttpProxyAdapter(
      {this.ipAddr = 'localhost',
      this.port = 8888,
      this.proxyIsEnable = false}) {
    if (proxyIsEnable == true) {
      onHttpClientCreate = (client) {
        var proxy = '$ipAddr:$port';
        client.findProxy = (url) {
          return 'PROXY $proxy';
        };

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }
}
