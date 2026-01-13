import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class VitalDataPage extends StatelessWidget {
  final SelfDetectionController controller;

  const VitalDataPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.vitalTitle,
            style: const TextStyle(
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
                // Sistolik & Diastolik
                Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        controller: controller.systolicBpController,
                        label: t.vitalSystolicLabel, // "Sistolik (mmHg)"
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return t.vitalSystolicRequired;
                          }
                          if (double.tryParse(value) == null) {
                            return t.vitalValidNumber;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomInputField(
                        controller: controller.diastolicBpController,
                        label: t.vitalDiastolicLabel, // "Diastolik (mmHg)"
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return t.vitalDiastolicRequired;
                          }
                          if (double.tryParse(value) == null) {
                            return t.vitalValidNumber;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                CustomInputField(
                  controller: controller.temperatureController,
                  label: t.vitalTempLabel, // "Suhu tubuh (°C)"
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.vitalTempRequired;
                    }
                    if (double.tryParse(value) == null) {
                      return t.vitalValidNumber;
                    }
                    return null;
                  },
                ),

                CustomInputField(
                  controller: controller.pulseController,
                  label: t.vitalPulseLabel, // "Nadi (x/menit)"
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.vitalPulseRequired;
                    }
                    if (int.tryParse(value) == null) {
                      return t.vitalValidNumber;
                    }
                    return null;
                  },
                ),

                CustomInputField(
                  controller: controller.respirationController,
                  label: t.vitalRespLabel, // "Frekuensi napas (x/menit)"
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return t.vitalRespRequired;
                    }
                    if (int.tryParse(value) == null) {
                      return t.vitalValidNumber;
                    }
                    return null;
                  },
                ),

                // Info nilai normal
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
                        t.vitalNormalTitle, // "Nilai Normal:" / "Normal Values:"
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.vitalNormalBpMain,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        t.vitalNormalBpSys,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        t.vitalNormalBpDia,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        t.vitalNormalTemp,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        t.vitalNormalPulse,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        t.vitalNormalResp,
                        style: const TextStyle(fontSize: 12),
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
