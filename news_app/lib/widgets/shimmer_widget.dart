import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double br;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.br = 4,
  });

  const ShimmerWidget.circular({super.key, required this.width, required this.height, this.br = 50,});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: const Color(0xFFE4E4E4),
        highlightColor: const Color(0xFFDBDBDB).withOpacity(0.05),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(br)),
            color: const Color(0xFFE4E4E4),
          ),
        ),
      );
}
