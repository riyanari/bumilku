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
          const SizedBox(height: 8),
          // Informasi tambahan
          Text(
            "Informasi ini membantu tenaga kesehatan memahami kondisi Anda",
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
                  controller: controller.diseaseHistoryController,
                  label: "Penyakit yang pernah/sedang diderita (hipertensi, diabetes, jantung, dll.)",
                  keyboardType: TextInputType.text,
                ),
                
                CustomInputField(
                  controller: controller.allergyHistoryController,
                  label: "Riwayat alergi (obat/makanan/bahan tertentu)",
                  keyboardType: TextInputType.text,
                ),
                
                CustomInputField(
                  controller: controller.surgeryHistoryController,
                  label: "Riwayat operasi (selain SC)",
                  keyboardType: TextInputType.text,
                ),
                
                CustomInputField(
                  controller: controller.medicationController,
                  label: "Konsumsi obat-obatan rutin (termasuk vitamin/herbal)",
                  keyboardType: TextInputType.text,
                ),
                
                // Informasi contoh pengisian
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
                        "Contoh pengisian:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("• Penyakit: Hipertensi sejak 2020", style: TextStyle(fontSize: 12)),
                      Text("• Alergi: Alergi antibiotik Amoxicillin", style: TextStyle(fontSize: 12)),
                      Text("• Operasi: Usus buntu tahun 2018", style: TextStyle(fontSize: 12)),
                      Text("• Obat: Obat hipertensi rutin, vitamin prenatal", style: TextStyle(fontSize: 12)),
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