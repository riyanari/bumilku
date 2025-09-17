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
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.bloodPressureController,
                  label: "Tekanan darah (mmHg)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Tekanan darah harus diisi';
                    if (double.tryParse(value) == null) return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}