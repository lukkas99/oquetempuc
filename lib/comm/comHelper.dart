import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

alertDialog(String msg) {
  Toast.show(
    msg,
    duration: Toast.lengthLong,
    gravity: Toast.bottom,
  );
}

validateEmail(String email) {
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}

String generateMd5(String input) {
  var bytes = utf8.encode(input); // Codifique a senha como bytes
  var digest = md5.convert(bytes); // Gere o hash MD5
  return digest.toString(); // Converta o hash em uma string hexadecimal
}
