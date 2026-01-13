import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';
import '../widgets/complaint_chips.dart';

class ComplaintsPage extends StatelessWidget {
  final SelfDetectionController controller;

  const ComplaintsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final selectedCount = controller.complaintSelected.values
        .where((isSelected) => isSelected)
        .length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.complaintsTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),

          // Selected count info
          if (selectedCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: tPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                t.complaintsSelectedCount(selectedCount),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: tPrimaryColor,
                ),
              ),
            ),
          const SizedBox(height: 4),

          // Severity legend
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
                  t.complaintsLegendTitle,
                  style: const TextStyle(
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
                    Expanded(
                      child: Text(
                        t.complaintsLegendHigh,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
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
                    Expanded(
                      child: Text(
                        t.complaintsLegendMedium,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
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
                    Expanded(
                      child: Text(
                        t.complaintsLegendNormal,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
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
                  t.complaintsPickInstruction,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: tPrimaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                ComplaintChips(
                  complaints: controller.complaints,
                  complaintSelected: controller.complaintSelected,
                  complaintSeverity: controller.complaintSeverity,
                  onComplaintSelected: (complaint) {
                    controller.complaintSelected[complaint] =
                    !(controller.complaintSelected[complaint] ?? false);
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
