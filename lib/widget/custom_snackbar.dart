import 'package:flutter/material.dart';
import 'package:toilet_client_web_v2/utils/mycolors.dart';
import 'package:toilet_client_web_v2/utils/text.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar({context,String? message}){
   final snackBar = SnackBar(
    backgroundColor: MyColor.greenBG,
    duration: const Duration(seconds: 1),
    content: text_custom(text:'$message!',color:MyColor.white),
);
  return   ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
