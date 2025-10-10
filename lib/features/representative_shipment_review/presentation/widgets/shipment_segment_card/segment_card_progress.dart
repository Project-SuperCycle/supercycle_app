import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class SegmentCardProgress extends StatelessWidget {
  final int currentStep;
  final List<StepData> steps;
  final Color activeColor;
  final Color inactiveColor;
  final Color completedColor;

  const SegmentCardProgress({
    super.key,
    required this.currentStep,
    required this.steps,
    this.activeColor = Colors.blueAccent,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.completedColor = const Color(0xFF3BC577),
  }) : assert(steps.length == 3, 'Must have exactly 3 steps');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          for (int i = 0; i < 3; i++) ...[
            Expanded(
              child: Column(
                children: [
                  // Step circle
                  _buildStepCircle(i),
                  const SizedBox(height: 12),
                  // Step label centered under circle
                  _buildStepLabel(i, context),
                ],
              ),
            ),
            if (i < 2)
              // Connector positioned between circles
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: _buildConnector(i),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepCircle(int index) {
    final isCompleted = index < currentStep;
    final isActive = index == currentStep;

    Color circleColor;
    if (isCompleted) {
      circleColor = completedColor;
    } else if (isActive) {
      circleColor = activeColor;
    } else {
      circleColor = inactiveColor;
    }

    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check_rounded, color: Colors.white, size: 15)
            : Icon(steps[index].icon, color: Colors.white, size: 15),
      ),
    );
  }

  Widget _buildConnector(int index) {
    final isCompleted = index < currentStep;

    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: isCompleted ? completedColor : inactiveColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildStepLabel(int index, BuildContext context) {
    final isCompleted = index < currentStep;
    final isActive = index == currentStep;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        steps[index].title,
        style: AppStyles.styleSemiBold12(context).copyWith(
          color: isActive || isCompleted
              ? const Color(0xFF212121)
              : const Color(0xFF9E9E9E),
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// Data model for steps
class StepData {
  final String title;
  final IconData icon;

  const StepData({required this.title, required this.icon});
}
