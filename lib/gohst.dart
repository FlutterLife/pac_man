import 'package:flutter/material.dart';

class MyGhost extends StatelessWidget {
  const MyGhost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Image.asset("lib/image/pac_man_ghost.png"),
    );
  }
}
