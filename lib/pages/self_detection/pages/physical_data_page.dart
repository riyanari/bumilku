import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class PhysicalDataPage extends StatelessWidget {
  final SelfDetectionController controller;

  const PhysicalDataPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: controller,
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.physicalDataTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.physicalDataSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                CustomInputField(
                  controller: controller.heightController,
                  label: t.physicalDataHeightLabel,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.physicalDataHeightRequired;
                    if (double.tryParse(value) == null) return t.commonInvalidNumber;
                    return null;
                  },
                ),

                CustomInputField(
                  controller: controller.weightBeforeController,
                  label: t.physicalDataWeightBeforeLabel,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.physicalDataWeightBeforeRequired;
                    if (double.tryParse(value) == null) return t.commonInvalidNumber;
                    return null;
                  },
                ),

                CustomInputField(
                  controller: controller.currentWeightController,
                  label: t.physicalDataCurrentWeightLabel,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return t.physicalDataCurrentWeightRequired;
                    if (double.tryParse(value) == null) return t.commonInvalidNumber;
                    return null;
                  },
                ),

                // BMI Card
                if (controller.bmiValue != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getBmiStatusColor(controller.bmiValue!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.physicalDataBmiValue(controller.bmiValue!.toStringAsFixed(1)),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getBmiStatusTextColor(controller.bmiValue!),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getBmiCategoryText(t, controller.bmiValue!),
                          style: TextStyle(
                            fontSize: 14,
                            color: _getBmiStatusTextColor(controller.bmiValue!),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _getIdealWeightGainText(t, controller.bmiValue!),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getBmiStatusTextColor(controller.bmiValue!),
                          ),
                        ),

                      ],
                    ),
                  ),

                CustomInputField(
                  controller: controller.lilaController,
                  label: t.physicalDataMuacLabel, // MUAC = LILA
                  keyboardType: TextInputType.number,
                ),

                // Normal values info
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
                        t.physicalDataNormalValuesTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(t.physicalDataNormalBmi, style: const TextStyle(fontSize: 12)),
                      Text(t.physicalDataNormalMuac, style: const TextStyle(fontSize: 12)),
                      Text(t.physicalDataBmiUnderweightInfo, style: const TextStyle(fontSize: 12)),
                      Text(t.physicalDataBmiOverweightInfo, style: const TextStyle(fontSize: 12)),
                      Text(t.physicalDataBmiObesityInfo, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }

  // Helper warna IMT
  // Color _getBmiColor(double bmi) {
  //   if (bmi < 18.5) return Colors.orange[100]!;
  //   if (bmi < 25) return Colors.green[100]!;
  //   if (bmi < 30) return Colors.orange[100]!;
  //   return Colors.red[100]!;
  // }
  //
  // Color _getBmiTextColor(double bmi) {
  //   if (bmi < 18.5) return Colors.orange[800]!;
  //   if (bmi < 25) return Colors.green[800]!;
  //   if (bmi < 30) return Colors.orange[800]!;
  //   return Colors.red[800]!;
  // }

  Color _getBmiStatusColor(double bmi) {
    if (bmi < 18.5) return Colors.red[100]!;
    if (bmi < 25) return Colors.green[100]!;
    if (bmi < 30) return Colors.yellow[100]!;
    return Colors.red[100]!;
  }

  Color _getBmiStatusTextColor(double bmi) {
    if (bmi < 18.5) return Colors.red[800]!;
    if (bmi < 25) return Colors.green[800]!;
    if (bmi < 30) return Colors.orange[800]!; // text kuning biasanya kurang kebaca, pakai orange gelap
    return Colors.red[800]!;
  }

  String _getIdealWeightGainText(AppLocalizations t, double bmi) {
    if (bmi < 18.5) {
      return "${t.bmiIdealGainLabel} ${t.bmiIdealGainValue("12", "18")}";
    }
    if (bmi < 25) {
      return "${t.bmiIdealGainLabel} ${t.bmiIdealGainValue("11", "16")}";
    }
    if (bmi < 30) {
      return "${t.bmiIdealGainLabel} ${t.bmiIdealGainValue("7", "11")}";
    }
    return "${t.bmiIdealGainLabel} ${t.bmiIdealGainValue("5", "9")}";
  }

  String _getBmiCategoryText(AppLocalizations t, double bmi) {
    if (bmi < 18.5) return t.physicalDataBmiCategoryUnderweight;
    if (bmi < 25) return t.physicalDataBmiCategoryNormal;
    if (bmi < 30) return t.physicalDataBmiCategoryOverweight;
    return t.physicalDataBmiCategoryObesity;
  }
}
