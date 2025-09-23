import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

class ComplaintChips extends StatelessWidget {
  final List<String> complaints;
  final Map<String, bool> complaintSelected;
  final Map<String, int> complaintSeverity; // DITAMBAHKAN
  final ValueChanged<String> onComplaintSelected;

  const ComplaintChips({
    super.key,
    required this.complaints,
    required this.complaintSelected,
    required this.complaintSeverity, // DITAMBAHKAN
    required this.onComplaintSelected,
  });

  // Fungsi untuk mendapatkan warna berdasarkan tingkat keparahan
  Color _getSeverityColor(int severity, bool isSelected) {
    if (!isSelected) return tSecondaryColor;

    switch (severity) {
      case 2: // Berisiko tinggi
        return tErrorColor;
      case 1: // Perlu perhatian
        return Colors.orange.shade300;
      case 0: // Normal
      default:
        return Colors.green.shade300;
    }
  }

  // Fungsi untuk mendapatkan warna teks berdasarkan tingkat keparahan
  Color _getTextColor(int severity, bool isSelected) {
    if (!isSelected) return Colors.grey.shade700;

    switch (severity) {
      case 2: // Berisiko tinggi
        return kWhiteColor;
      case 1: // Perlu perhatian
        return kWhiteColor;
      case 0: // Normal
      default:
        return kWhiteColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: complaints.map((c) {
        final severity = complaintSeverity[c] ?? 0;
        final isSelected = complaintSelected[c]!;

        return ChoiceChip(
          label: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, // Lebih responsif
            ),
            child: Text(
              c,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: _getTextColor(severity, isSelected),
              ),
            ),
          ),
          selected: isSelected,
          onSelected: (v) {
            onComplaintSelected(c);
          },
          selectedColor: _getSeverityColor(severity, isSelected),
          backgroundColor: Colors.grey.shade300,
          labelStyle: TextStyle(
            color: _getTextColor(severity, isSelected),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? _getTextColor(severity, isSelected) : Colors.grey.shade400,
              width: 1,
            ),
          ),
        );
      }).toList(),
    );
  }
}