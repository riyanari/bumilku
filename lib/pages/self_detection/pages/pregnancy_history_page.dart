import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class PregnancyHistoryPage extends StatelessWidget {
  final SelfDetectionController controller;

  const PregnancyHistoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.pregnancyHistoryTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            t.pregnancyHistorySubtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.childrenCountController,
                  label: t.pregnancyHistoryChildrenCountLabel,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.validationRequiredChildrenCount;
                    }
                    if (int.tryParse(value) == null) {
                      return t.validationInvalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.firstPregnancyAgeController,
                  label: t.pregnancyHistoryFirstPregnancyAgeLabel,
                  keyboardType: TextInputType.number,
                  suffixText: t.unitYears,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.validationRequiredFirstPregnancyAge;
                    }
                    if (int.tryParse(value) == null) {
                      return t.validationInvalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.pregnancyGapController,
                  label: t.pregnancyHistoryPregnancyGapLabel,
                  keyboardType: TextInputType.number,
                  suffixText: t.unitMonths,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.obstetricHistoryController,
                  label: t.pregnancyHistoryObstetricHistoryLabel,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.deliveryComplicationController,
                  label: t.pregnancyHistoryDeliveryComplicationsLabel,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.babyWeightHistoryController,
                  label: t.pregnancyHistoryBabyWeightHistoryLabel,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),

                CustomInputField(
                  controller: controller.previousPregnancyController,
                  label: t.pregnancyHistoryPreviousPregnancyLabel,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),

                // contoh pengisian
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
                        t.pregnancyHistoryExamplesTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        t.pregnancyHistoryExampleObstetricLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        t.pregnancyHistoryExampleComplicationLabel,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        t.pregnancyHistoryExampleObstetricValue,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        t.pregnancyHistoryExampleComplicationValue,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        t.pregnancyHistoryExampleBabyWeightValue,
                        style: const TextStyle(fontSize: 12),
                      ),
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
