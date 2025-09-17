import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String result;
  final String recommendation;

  const ResultDisplay({
    super.key,
    required this.result,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    Color resultColor;
    IconData resultIcon;

    if (result == "Risiko tinggi") {
      resultColor = Colors.red;
      resultIcon = Icons.warning;
    } else if (result == "Perlu perhatian") {
      resultColor = Colors.orange;
      resultIcon = Icons.info;
    } else {
      resultColor = Colors.green;
      resultIcon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: resultColor.withValues(alpha:0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(resultIcon, color: resultColor),
              const SizedBox(width: 8),
              Text(
                result,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recommendation,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}