import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../self_detection_controller.dart';
import '../widgets/complaint_chips.dart';

class ComplaintsPage extends StatelessWidget {
  final SelfDetectionController controller;

  const ComplaintsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Hitung jumlah keluhan yang dipilih
    final selectedCount = controller.complaintSelected.values
        .where((isSelected) => isSelected)
        .length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Keluhan yang Dirasakan",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),

          // Informasi jumlah keluhan terpilih
          if (selectedCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: tPrimaryColor.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "$selectedCount keluhan dipilih",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: tPrimaryColor,
                ),
              ),
            ),
          const SizedBox(height: 4),

          // Keterangan tingkat keparahan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Keterangan:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tPrimaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(child: Text("Keluhan berisiko tinggi", style: TextStyle(fontSize: 10))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(child: Text("Keluhan perlu perhatian", style: TextStyle(fontSize: 10))),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(child: Text("Keluhan normal", style: TextStyle(fontSize: 10))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

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
                  complaintSeverity: controller.complaintSeverity, // DITAMBAHKAN
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