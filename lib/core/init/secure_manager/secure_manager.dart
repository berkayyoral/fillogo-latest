import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:dart_des/dart_des.dart';

class SecureManager {
  final String _key_1 = "ql51m3oaqn";
  final String _key_2 = '65e64tg0lv';

  String encryp(String text) {
    List<int> encrypted;
    List<int> encrypted2;

    DES3 des3 = DES3(key: md5.convert(utf8.encode(_key_1)).bytes, mode: DESMode.ECB, paddingType: DESPaddingType.PKCS7);
    encrypted = des3.encrypt(utf8.encode(text));
    log('encrpted = ${base64.encode(encrypted)}');
    DES3 des31 = DES3(key: md5.convert(utf8.encode(_key_2)).bytes, mode: DESMode.ECB, paddingType: DESPaddingType.PKCS7);
    encrypted2 = des31.encrypt(utf8.encode(base64.encode(encrypted)));
    log('encrpted2 = ${base64.encode(encrypted2)}');
    //debugPrint('encrypted (base64): ${base64.encode(encrypted)}');
    return base64.encode(encrypted2);
  }

  String decryp(text) {
    List<int> decrypted;
    List<int> decrypted2;
    DES3 des3 = DES3(key: md5.convert(utf8.encode(_key_2)).bytes, mode: DESMode.ECB, paddingType: DESPaddingType.PKCS7);
    decrypted = des3.decrypt(base64.decode(text));
    log('decrpted 1 = ${utf8.decode(decrypted)}');
    DES3 des31 = DES3(key: md5.convert(utf8.encode(_key_1)).bytes, mode: DESMode.ECB, paddingType: DESPaddingType.PKCS7);
    decrypted2 = des31.decrypt(base64.decode(utf8.decode(decrypted)));

    log('decrpted 1 = ${utf8.decode(decrypted2)}');
    //debugPrint('decrypted (utf8): ${utf8.decode(decrypted)}');

    return utf8.decode(decrypted2);
  }
}
