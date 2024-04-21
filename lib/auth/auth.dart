import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:web/web.dart' as web;
import 'package:dio/dio.dart';

import '../profile/model.dart';

class Auth extends StatefulWidget {
  const Auth({super.key, this.callback});

  final Function(Profile profile)? callback;

  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final String _apiUrl = 'http://192.168.1.24:8000/api/';
  String? _challenge;

  _preauth() async {
    // var url = web.window.location.href + "api/preauth";
    var url = "${_apiUrl}preauth";
    var resp = await Dio().get(url);
    setState(() {
      _challenge = resp.data['code'];
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      var url = '${_apiUrl}authenticated/$_challenge';
      Dio().get(url).then((resp) {
        Map<String, dynamic> data = resp.data.runtimeType == String
            ? jsonDecode(resp.data)
            : resp.data;
        if (data['user'] != null) {
          timer.cancel();
          if (widget.callback != null) widget.callback!(Profile.fromJson(data['user']));
        }

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preauth();
  }

  @override
  Widget build(context) {
    String qrData = '${_apiUrl}authenticate/$_challenge';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guildhall',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(child: Container()),
              QrImageView(data: qrData, size: 200),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
