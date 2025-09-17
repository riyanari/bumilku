import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class PhysicalDataPage extends StatelessWidget {
  final SelfDetectionController controller;

  const PhysicalDataPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Fisik Bunda",
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
                  controller: controller.heightController,
                  label: "Tinggi badan (cm)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Tinggi badan harus diisi';
                    if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                CustomInputField(
                  controller: controller.weightBeforeController,
                  label: "Berat badan sebelum hamil (kg)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Berat sebelum hamil harus diisi';
                    if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                CustomInputField(
                  controller: controller.currentWeightController,
                  label: "Berat badan saat ini (kg)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Berat saat ini harus diisi';
                    if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                if (controller.bmiValue != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Indeks Massa Tubuh (IMT): ${controller.bmiValue!.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: tPrimaryColor,
                      ),
                    ),
                  ),
                CustomInputField(
                  controller: controller.lilaController,
                  label: "Lingkar lengan atas (LILA) (cm)",
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}