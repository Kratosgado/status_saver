import 'package:flutter/material.dart';

Widget statusItem() {
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: const Border.symmetric(
          vertical: BorderSide(
            color: Colors.amber,
            width: 2,
          ),
          horizontal: BorderSide(
            color: Colors.indigo,
            width: 1,
          ),
        ),
      ),
    ),
  );
}
