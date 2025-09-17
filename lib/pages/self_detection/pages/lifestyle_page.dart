import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';
import '../widgets/result_display.dart';

class LifestylePage extends StatelessWidget {
  final SelfDetectionController controller;

  const LifestylePage({super.key, required this.controller});

  Widget _buildRadioGroup(
      String title,
      Map<String, bool> options,
      Function(String) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
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
            return ChoiceChip(
              label: Text(entry.key),
              selected: entry.value,
              onSelected: (selected) {
                // Deselect all other options
                for (var key in options.keys) {
                  options[key] = false;
                }
                options[entry.key] = selected;
                onChanged(entry.key);
                controller.notifyListeners(); // Tambahkan ini
              },
              selectedColor: kSecondaryColor,
              labelStyle: TextStyle(
                color: entry.value ? tPrimaryColor : Colors.grey.shade700,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Faktor Sosial & Gaya Hidup",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 18),
              children: [
                CustomInputField(
                  controller: controller.currentAgeController,
                  label: "Usia bunda sekarang",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Usia saat ini harus diisi';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                _buildRadioGroup(
                  "Status merokok / paparan asap rokok",
                  controller.smokingStatus,
                      (value) {},
                ),
                _buildRadioGroup(
                  "Konsumsi alkohol / obat-obatan terlarang",
                  controller.alcoholDrugStatus,
                      (value) {},
                ),
                CustomInputField(
                  controller: controller.physicalActivityController,
                  label: "Aktivitas fisik harian (aktif/ringan/banyak istirahat)",
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.familySupportController,
                  label: "Dukungan keluarga (ada/minim/tidak ada)",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                if (controller.result.isNotEmpty)
                  ResultDisplay(
                    result: controller.result,
                    recommendation: controller.recommendation,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}