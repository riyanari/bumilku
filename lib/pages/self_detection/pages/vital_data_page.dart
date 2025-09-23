import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class VitalDataPage extends StatelessWidget {
  final SelfDetectionController controller;

  const VitalDataPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Vital",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                // Tekanan darah sistolik dan diastolik dalam satu baris
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        controller: controller.systolicBpController,
                        label: "Sistolik (mmHg)",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Sistolik harus diisi';
                          if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomInputField(
                        controller: controller.diastolicBpController,
                        label: "Diastolik (mmHg)",
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Diastolik harus diisi';
                          if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 16),
                CustomInputField(
                  controller: controller.temperatureController,
                  label: "Suhu tubuh (°C)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Suhu tubuh harus diisi';
                    if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                // const SizedBox(height: 16),
                CustomInputField(
                  controller: controller.pulseController,
                  label: "Nadi (x/menit)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Nadi harus diisi';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                // const SizedBox(height: 16),
                CustomInputField(
                  controller: controller.respirationController,
                  label: "Frekuensi napas (x/menit)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Frekuensi napas harus diisi';
                    if (int.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                // const SizedBox(height: 16),
                // Informasi nilai normal
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
                        "Nilai Normal:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("• Tekanan darah: 90/60 - 139/89 mmHg", style: TextStyle(fontSize: 12)),
                      Text("• Suhu tubuh: 36 - 37.5°C", style: TextStyle(fontSize: 12)),
                      Text("• Nadi: 60 - 100 x/menit", style: TextStyle(fontSize: 12)),
                      Text("• Frekuensi napas: 16 - 20 x/menit", style: TextStyle(fontSize: 12)),
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