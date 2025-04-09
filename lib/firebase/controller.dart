import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toilet_client_web_v2/utils/mystring.dart';

class FirebaseDataController {
  final StreamController<Map<String, dynamic>> _dataStreamController = StreamController<Map<String, dynamic>>.broadcast();
  late final DatabaseReference _databaseRef;
  FirebaseDataController() {
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      name: MyString.FIREBASE_APP_NAME,
      options: const FirebaseOptions(
        apiKey: MyString.FIREBASE_apiKey,
        appId: MyString.FIREBASE_appId,
        messagingSenderId: MyString.FIREBASE_messagingSenderId,
        projectId: MyString.FIREBASE_projectId,
      ),
    );

    _databaseRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(MyString.FIREBASE_APP_NAME),
      databaseURL: MyString.FIREBASE_url,
    ).ref().child('roomMen');

    _databaseRef.onValue.listen((event) {
      final model = (event.snapshot.value as Map<dynamic, dynamic>?)
              ?.cast<String, dynamic>() ??
          {};
      debugPrint('_databaseRef $model');
      _dataStreamController.add(model);
    });
  }

  Stream<Map<String, dynamic>> get dataStream => _dataStreamController.stream;

  void dispose() {
    _dataStreamController.close();
  }
}
