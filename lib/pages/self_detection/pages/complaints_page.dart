import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';
import '../widgets/complaint_chips.dart';

class ComplaintsPage extends StatefulWidget {
  final SelfDetectionController controller;

  const ComplaintsPage({super.key, required this.controller});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final selectedCount = widget.controller.complaintSelected.values
        .where((isSelected) => isSelected)
        .length;

    void onAdd() {
      final text = widget.controller.customComplaintController.text;
      final trimmed = text.trim();

      if (trimmed.isEmpty) {
        setState(() => _errorText = t.complaintsEmptyError);
        return;
      }

      final exists = widget.controller.complaints
          .any((c) => c.toLowerCase() == trimmed.toLowerCase());
      if (exists) {
        setState(() => _errorText = t.complaintsDuplicateError);
        return;
      }

      setState(() => _errorText = null);
      widget.controller.addCustomComplaint(trimmed);
    }

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

          // --- Tambahan input keluhan ---
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller.customComplaintController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => onAdd(),
                  decoration: InputDecoration(
                    hintText: t.complaintsCustomHint,
                    hintStyle: greyTextStyle.copyWith(fontSize: 12),
                    errorText: _errorText,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    foregroundColor: kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onAdd,
                  child: Text(t.complaintsAddButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // --- End tambahan ---

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

          // Severity legend (punyamu tetap)
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
                  complaints: widget.controller.complaints,
                  complaintSelected: widget.controller.complaintSelected,
                  complaintSeverity: widget.controller.complaintSeverity,
                  onComplaintSelected: (complaint) {
                    widget.controller.complaintSelected[complaint] =
                    !(widget.controller.complaintSelected[complaint] ?? false);
                    widget.controller.notifyListeners();
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
