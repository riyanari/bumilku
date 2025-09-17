import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../self_detection_controller.dart';
import '../widgets/complaint_chips.dart';

class ComplaintsPage extends StatelessWidget {
  final SelfDetectionController controller;

  const ComplaintsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keluhan yang Dirasakan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Text(
                  "Pilih keluhan yang dialami saat ini:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: tPrimaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                ComplaintChips(
                  complaints: controller.complaints,
                  complaintSelected: controller.complaintSelected,
                  onComplaintSelected: (complaint) {
                    controller.complaintSelected[complaint] =
                    !controller.complaintSelected[complaint]!;
                    controller.notifyListeners();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}