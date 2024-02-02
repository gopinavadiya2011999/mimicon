import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mimicon/core/constant/color_constant.dart';

Future showFlushbar({required String text,required context}){
  return Flushbar(
    backgroundColor: ColorConstant.black.withOpacity(0.5),
    message: text,
    flushbarPosition: FlushbarPosition.TOP,
    messageSize: 14,
    messageColor: ColorConstant.white,
    duration: const Duration(seconds: 4),
    forwardAnimationCurve: Curves.easeIn,
    borderRadius: BorderRadius.circular(20),
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: const EdgeInsets.all(16),
  ).show(context);
}