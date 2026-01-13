import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class HealthHistoryPage extends StatelessWidget {
  final SelfDetectionController controller;

  const HealthHistoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.healthHistoryTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            t.healthHistorySubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.diseaseHistoryController,
                  label: t.healthHistoryDiseaseLabel,
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.allergyHistoryController,
                  label: t.healthHistoryAllergyLabel,
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.surgeryHistoryController,
                  label: t.healthHistorySurgeryLabel,
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.medicationController,
                  label: t.healthHistoryMedicationLabel,
                  keyboardType: TextInputType.text,
                ),

                // Example info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.healthHistoryExamplesTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(t.healthHistoryExampleDisease,
                          style: const TextStyle(fontSize: 12)),
                      Text(t.healthHistoryExampleAllergy,
                          style: const TextStyle(fontSize: 12)),
                      Text(t.healthHistoryExampleSurgery,
                          style: const TextStyle(fontSize: 12)),
                      Text(t.healthHistoryExampleMedication,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
