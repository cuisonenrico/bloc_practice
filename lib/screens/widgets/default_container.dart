import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    required this.child,
    this.height,
    this.color,
    super.key,
  });

  final Widget child;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      child: child,
    );
  }
}
