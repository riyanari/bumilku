import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class PregnancyHistoryPage extends StatelessWidget {
  final SelfDetectionController controller;

  const PregnancyHistoryPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Riwayat Kehamilan & Persalinan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          // Informasi tambahan untuk membantu pengguna
          Text(
            "Isilah sesuai dengan riwayat kehamilan dan persalinan sebelumnya",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.childrenCountController,
                  label: "Jumlah anak yang sudah lahir",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Jumlah anak harus diisi';
                    if (int.tryParse(value) == null)
                      return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.firstPregnancyAgeController,
                  label: "Usia bunda saat pertama kali hamil",
                  keyboardType: TextInputType.number,
                  suffixText: "tahun",
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Usia pertama hamil harus diisi';
                    if (int.tryParse(value) == null)
                      return 'Masukkan angka yang valid';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.pregnancyGapController,
                  label: "Jarak kehamilan dengan anak sebelumnya",
                  keyboardType: TextInputType.number,
                  suffixText: "bulan",
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.obstetricHistoryController,
                  label:
                      "Riwayat Obstetrik atau riwayat kehamilan dan persalinan (riwayat keguguran, riwayat caesar, riwayat kelahiran prematur, riwayat hamil ektopik atau di luar kandungan, dll)",
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.deliveryComplicationController,
                  label:
                      "Riwayat komplikasi persalinan (perdarahan, tekanan darah tinggi saat hamil, dll.)",
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.babyWeightHistoryController,
                  label:
                      "Riwayat bayi lahir (berat badan normal >=2.5 / besar >4 kg)",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  controller: controller.previousPregnancyController,
                  label:
                      "Riwayat kehamilan sebelumnya (normal/bermasalah/janin meninggal)",
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
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
                      Text(
                        "• Riwayat Obstetrik atau riwayat kehamilan dan persalinan (riwayat keguguran, riwayat caesar, riwayat kelahiran prematur, riwayat hamil ektopik atau di luar kandungan, dll)",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "• Riwayat kompilasi persalinan (perdarahan, tekanan darah tinggi saat hamil, dll.)",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "• Riwayat obstetri: Pernah keguguran 1x, SC 1x",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "• Komplikasi: Perdarahan pasca persalinan",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "• Bayi lahir: Berart badan normal minimal 2.5 kg",
                        style: TextStyle(fontSize: 12),
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
