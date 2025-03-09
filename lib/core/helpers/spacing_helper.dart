import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.height, {super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: (MediaQuery.sizeOf(context).height / 852) * height);
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.width, {super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: (MediaQuery.sizeOf(context).width / 393) * width);
  }
}
