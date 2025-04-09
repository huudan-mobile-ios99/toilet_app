import 'package:flutter/material.dart';
import 'package:toilet_client_web_v2/utils/mycolors.dart';
import 'package:toilet_client_web_v2/utils/padding.dart';
import 'package:toilet_client_web_v2/utils/text.dart';

showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      backgroundColor: MyColor.white,
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: PaddingDefault.pading08),child:text_custom(text:"Loading, Please wait for a moment" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
