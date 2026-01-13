import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import '../../../l10n/app_localizations.dart';

class ComplaintChips extends StatelessWidget {
  final List<String> complaints;
  final Map<String, bool> complaintSelected;
  final Map<String, int> complaintSeverity;
  final ValueChanged<String> onComplaintSelected;

  const ComplaintChips({
    super.key,
    required this.complaints,
    required this.complaintSelected,
    required this.complaintSeverity,
    required this.onComplaintSelected,
  });

  String _label(BuildContext context, String complaint) {
    final t = AppLocalizations.of(context)!;

    final key = complaint.trim().toLowerCase();

    switch (key) {
      case "mual dan muntah":
        return t.complaintNauseaVomiting;
      case "kembung":
        return t.complaintBloating;
      case "maag / nyeri ulu hati":
        return t.complaintHeartburn;
      case "sakit kepala":
        return t.complaintHeadache;
      case "gerakan janin":
        return t.complaintFetalMovement;
      case "kram perut":
        return t.complaintAbdominalCramp;
      case "keputihan":
        return t.complaintVaginalDischarge;
      case "ngidam":
        return t.complaintCravings;
      case "pendarahan / bercak dari jalan lahir":
        return t.complaintBleedingSpotting;
      case "bengkak pada kaki / tangan / wajah":
        return t.complaintSwelling;
      case "sembelit":
        return t.complaintConstipation;
      case "kelelahan berlebihan":
        return t.complaintExcessiveFatigue;
      case "ngantuk dan pusing":
        return t.complaintSleepyDizzy;
      case "perubahan mood":
        return t.complaintMoodChanges;
      case "masalah tidur":
        return t.complaintSleepProblems;
      case "hilang nafsu makan":
        return t.complaintLossOfAppetite;
      case "detak jantung cepat":
        return t.complaintFastHeartbeat;
      case "nyeri pinggang / punggung":
        return t.complaintBackPain;
      case "sesak napas":
        return t.complaintShortnessOfBreath;
      case "pandangan kabur / berkunang-kunang":
        return t.complaintBlurredVision;
      case "kontraksi dini (perut sering kencang sebelum waktunya)":
        return t.complaintEarlyContractions;
      default:
        debugPrint("UNMAPPED COMPLAINT: $complaint");
        return complaint;
    }
  }

  Color _getSeverityColor(int severity, bool isSelected) {
    if (!isSelected) return Colors.grey.shade300;
    switch (severity) {
      case 2:
        return tErrorColor;
      case 1:
        return Colors.orange.shade300;
      default:
        return Colors.green.shade300;
    }
  }

  Color _getTextColor(bool isSelected) {
    return isSelected ? kWhiteColor : Colors.grey.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: complaints.map((c) {
        final severity = complaintSeverity[c] ?? 0;
        final isSelected = complaintSelected[c] ?? false;

        return ChoiceChip(
          label: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Text(
              _label(context, c), // ✅ localized label
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: _getTextColor(isSelected),
              ),
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onComplaintSelected(c),
          selectedColor: _getSeverityColor(severity, true),
          backgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? Colors.white : Colors.grey.shade400,
              width: 1,
            ),
          ),
        );
      }).toList(),
    );
  }
}
