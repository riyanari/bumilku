import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class LifestylePage extends StatelessWidget {
  final SelfDetectionController controller;

  const LifestylePage({super.key, required this.controller});

  // ✅ label opsi chip mengikuti locale, tapi key tetap string lama (ID) di controller
  String _optionLabel(BuildContext context, String key) {
    final t = AppLocalizations.of(context)!;

    switch (key) {
    // Smoking
      case "Tidak merokok":
        return t.lifestyleSmokingNone;
      case "Merokok":
        return t.lifestyleSmokingActive;
      case "Terpapar asap rokok":
        return t.lifestyleSmokingPassive;

    // Alcohol/Drugs
      case "Tidak mengonsumsi":
        return t.lifestyleAlcoholNone;
      case "Mengonsumsi alkohol":
        return t.lifestyleAlcoholYes;
      case "Mengonsumsi obat terlarang":
        return t.lifestyleDrugsYes;

      default:
        return key; // fallback
    }
  }

  Widget _buildRadioGroup(
      BuildContext context, {
        required String title,
        required Map<String, bool> options,
        required Function(String) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: tPrimaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.entries.map((entry) {
            final key = entry.key;
            final selected = entry.value;

            return ChoiceChip(
              label: Text(_optionLabel(context, key)),
              selected: selected,
              onSelected: (isSelected) {
                // Deselect all other options
                for (final k in options.keys) {
                  options[k] = false;
                }
                options[key] = isSelected;

                onChanged(key); // ✅ kirim key lama (ID) agar scoring tetap konsisten
                controller.notifyListeners();
              },
              selectedColor: kSecondaryColor,
              labelStyle: TextStyle(
                color: selected ? tPrimaryColor : Colors.grey.shade700,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.lifestyleTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.lifestyleSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.currentAgeController,
                  label: t.lifestyleAgeLabel,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.errorAgeRequired;
                    if (int.tryParse(value) == null) return t.errorInvalidNumber;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                _buildRadioGroup(
                  context,
                  title: t.lifestyleSmokingTitle,
                  options: controller.smokingStatus,
                  onChanged: (_) {},
                ),

                _buildRadioGroup(
                  context,
                  title: t.lifestyleAlcoholDrugTitle,
                  options: controller.alcoholDrugStatus,
                  onChanged: (_) {},
                ),

                const SizedBox(height: 16),

                CustomInputField(
                  controller: controller.physicalActivityController,
                  label: t.lifestylePhysicalActivityLabel,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16),

                CustomInputField(
                  controller: controller.familySupportController,
                  label: t.lifestyleFamilySupportLabel,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[100]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.lifestyleRiskInfoTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(t.lifestyleRiskBullet1, style: const TextStyle(fontSize: 12)),
                      Text(t.lifestyleRiskBullet2, style: const TextStyle(fontSize: 12)),
                      Text(t.lifestyleRiskBullet3, style: const TextStyle(fontSize: 12)),
                      Text(t.lifestyleRiskBullet4, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
