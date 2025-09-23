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
          const SizedBox(height: 8),
          Text(
            "Data ini digunakan untuk menghitung Indeks Massa Tubuh (IMT)",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
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
                
                // Tampilkan IMT dengan informasi kategori
                if (controller.bmiValue != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getBmiColor(controller.bmiValue!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Indeks Massa Tubuh (IMT): ${controller.bmiValue!.toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getBmiTextColor(controller.bmiValue!),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getBmiCategory(controller.bmiValue!),
                          style: TextStyle(
                            fontSize: 14,
                            color: _getBmiTextColor(controller.bmiValue!),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                CustomInputField(
                  controller: controller.lilaController,
                  label: "Lingkar lengan atas (LILA) (cm)",
                  keyboardType: TextInputType.number,
                ),
                
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
                      Text("• IMT normal: 18.5 - 24.9", style: TextStyle(fontSize: 12)),
                      Text("• LILA normal: ≥ 23.5 cm", style: TextStyle(fontSize: 12)),
                      Text("• IMT < 18.5: Kurus", style: TextStyle(fontSize: 12)),
                      Text("• IMT ≥ 25: Kelebihan berat", style: TextStyle(fontSize: 12)),
                      Text("• IMT ≥ 30: Obesitas", style: TextStyle(fontSize: 12)),
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

  // Fungsi helper untuk kategori IMT
  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return Colors.orange[100]!;
    if (bmi < 25) return Colors.green[100]!;
    if (bmi < 30) return Colors.orange[100]!;
    return Colors.red[100]!;
  }

  Color _getBmiTextColor(double bmi) {
    if (bmi < 18.5) return Colors.orange[800]!;
    if (bmi < 25) return Colors.green[800]!;
    if (bmi < 30) return Colors.orange[800]!;
    return Colors.red[800]!;
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return "Kategori: Kurus";
    if (bmi < 25) return "Kategori: Normal";
    if (bmi < 30) return "Kategori: Kelebihan berat";
    return "Kategori: Obesitas";
  }
}