import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //
      disabledColor: Colors.grey,
      primaryColor: Colors.teal,
      splashColor: Colors.blue,
  
      appBarTheme: AppBarTheme(
        color: Colors.teal,
        shape: const StadiumBorder(),
        elevation: 8,
        shadowColor: Colors.green.shade400,
      ),
      );
}
