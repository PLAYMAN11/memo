import 'dart:io';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


void main() {
  // Initialize FFI
//sqfliteFfiInit();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux ||Platform.isMacOS||Platform.isAndroid ||Platform.isIOS ){
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

  }
  if (kIsWeb){
    sqfliteFfiInit();
    databaseFactory =databaseFactoryFfiWeb;
  }
  
  runApp(const App());
}
