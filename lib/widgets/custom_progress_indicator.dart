import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final double size;
  final double padding;
  final Color selectedColor;
  final Color unselectedColor;
  final Radius roundedEdges;

  const CustomProgressIndicator({super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.size,
    required this.padding,
    required this.selectedColor,
    required this.unselectedColor,
    required this.roundedEdges,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return _buildProgressSegment(index <= currentStep);
      }),
    );
  }

  Widget _buildProgressSegment(bool isActive) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: padding / 2),
        height: size,
        decoration: BoxDecoration(
          color: isActive ? null : unselectedColor,
          gradient: isActive ?LinearGradient(
            colors: [AppColor.primaryColor, AppColor.red],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ):null,
          borderRadius: BorderRadius.all(roundedEdges),
        ),
      ),
    );
  }
}