import 'package:flutter/material.dart';

class UseCaseFrame extends StatelessWidget {
  const UseCaseFrame({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: child,
          ),
        ),
      ),
    );
  }
}
