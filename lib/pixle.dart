import 'package:flutter/material.dart';

class MyPixle extends StatelessWidget {
  final innercolor;
  final outercolor;
  final child;
  const MyPixle({super.key, this.outercolor, this.child, this.innercolor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child:ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(4),
            color: outercolor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(4),
                color: innercolor,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ),
    );
  }
}
