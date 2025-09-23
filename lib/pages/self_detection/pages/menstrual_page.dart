import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class MenstrualPage extends StatelessWidget {
  final SelfDetectionController controller;

  const MenstrualPage({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedLMPDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor,
              onPrimary: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.selectedLMPDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Haid & Kehamilan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Informasi ini membantu menentukan usia kehamilan",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          
          Expanded(
            child: ListView(
              children: [
                // Tanggal HPHT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal Hari Pertama Haid Terakhir (HPHT)*",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha:0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          controller.selectedLMPDate == null
                              ? "Pilih tanggal"
                              : DateFormat('dd MMMM yyyy').format(controller.selectedLMPDate!),
                          style: TextStyle(
                            color: controller.selectedLMPDate == null
                                ? Colors.grey[500]
                                : Colors.black,
                          ),
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                      ),
                    ),
                    if (controller.selectedLMPDate == null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
                        child: Text(
                          'Tanggal haid terakhir harus diisi',
                          style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                  ],
                ),
                

                // Siklus haid
                CustomInputField(
                  controller: controller.menstrualCycleController,
                  label: "Siklus haid (teratur/tidak, berapa hari)",
                  keyboardType: TextInputType.text,
                ),
                

                // Gerakan janin (FIELD BARU dari controller)
                CustomInputField(
                  controller: controller.fetalMovementController,
                  label: "Gerakan janin (sudah terasa/belum/berkurang)",
                  keyboardType: TextInputType.text,
                ),
                

                // Hasil USG
                CustomInputField(
                  controller: controller.ultrasoundResultController,
                  label: "Hasil pemeriksaan USG (jika sudah ada)",
                  keyboardType: TextInputType.text,
                ),
                

                // Informasi HPL jika HPHT sudah dipilih
                if (controller.selectedLMPDate != null)
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[100]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Kehamilan:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "• Perkiraan Hari Lahir (HPL): ${DateFormat('dd MMMM yyyy').format(controller.selectedLMPDate!.add(const Duration(days: 280)))}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "• Usia kehamilan: ${_calculateGestationalAge(controller.selectedLMPDate!)} minggu",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                

                // Informasi penting
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
                        "Informasi Penting:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("• HPHT digunakan untuk menghitung usia kehamilan", style: TextStyle(fontSize: 12)),
                      Text("• Gerakan janin biasanya terasa mulai minggu 18-20", style: TextStyle(fontSize: 12)),
                      Text("• USG membantu memastikan usia kehamilan dan perkembangan janin", style: TextStyle(fontSize: 12)),
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

  // Fungsi untuk menghitung usia kehamilan
  String _calculateGestationalAge(DateTime lmpDate) {
    final now = DateTime.now();
    final difference = now.difference(lmpDate);
    final weeks = (difference.inDays / 7).floor();
    return weeks.toString();
  }
}