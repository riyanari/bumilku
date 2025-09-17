import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class HealthHistoryPage extends StatelessWidget {
  final SelfDetectionController controller;

  const HealthHistoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Riwayat Kesehatan Bunda",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                CustomInputField(
                  controller: controller.diseaseHistoryController,
                  label: "Penyakit yang pernah/sedang diderita (hipertensi, diabetes, dll.)",
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.allergyHistoryController,
                  label: "Riwayat alergi (obat/makanan)",
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.surgeryHistoryController,
                  label: "Riwayat operasi (selain SC)",
                  keyboardType: TextInputType.text,
                ),
                CustomInputField(
                  controller: controller.medicationController,
                  label: "Konsumsi obat-obatan rutin",
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}