import 'dart:io';

import 'package:flutter/material.dart';

class OpenStatusView extends StatelessWidget {
  const OpenStatusView({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${file.hashCode}",
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("User"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Center(
              child: Image.file(file),
            )
          ],
        ),
      ),
    );
  }
}
