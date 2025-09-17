import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

class ComplaintChips extends StatelessWidget {
  final List<String> complaints;
  final Map<String, bool> complaintSelected;
  final ValueChanged<String> onComplaintSelected;

  const ComplaintChips({
    super.key,
    required this.complaints,
    required this.complaintSelected,
    required this.onComplaintSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: complaints.map((c) {
        return ChoiceChip(
          label: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width, // Atur lebar maksimum
            ),
            child: Text(
              c,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          selected: complaintSelected[c]!,
          onSelected: (v) {
            onComplaintSelected(c);
          },
          selectedColor: kSecondaryColor,
          labelStyle: TextStyle(
            color: complaintSelected[c]!
                ? tPrimaryColor
                : Colors.grey.shade700,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        );
      }).toList(),
    );
  }
}