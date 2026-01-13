import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';
import '../widgets/input_field.dart';

class MenstrualPage extends StatelessWidget {
  final SelfDetectionController controller;

  const MenstrualPage({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    final locale = Localizations.localeOf(context);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedLMPDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        // ✅ Paksa showDatePicker ikut locale app (EN/ID) + theme
        return Localizations.override(
          context: context,
          locale: locale,
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: kPrimaryColor,
                onPrimary: Colors.white,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          ),
        );
      },
    );

    if (picked != null) {
      controller.selectedLMPDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    String formatDate(DateTime d) =>
        DateFormat('dd MMMM yyyy', locale.toLanguageTag()).format(d);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.menstrualTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.menstrualSubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                // HPHT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.menstrualLmpLabel,
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
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          controller.selectedLMPDate == null
                              ? t.commonPickDate
                              : formatDate(controller.selectedLMPDate!),
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
                          t.menstrualLmpRequired,
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
                  label: t.menstrualCycleLabel,
                  keyboardType: TextInputType.text,
                ),

                // Gerakan janin
                CustomInputField(
                  controller: controller.fetalMovementController,
                  label: t.menstrualFetalMovementLabel,
                  keyboardType: TextInputType.text,
                ),

                // USG
                CustomInputField(
                  controller: controller.ultrasoundResultController,
                  label: t.menstrualUltrasoundLabel,
                  keyboardType: TextInputType.text,
                ),

                // Info kehamilan (HPL & usia)
                if (controller.selectedLMPDate != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                          t.menstrualPregnancyInfoTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          t.menstrualEddLine(
                            formatDate(controller.selectedLMPDate!.add(const Duration(days: 280))),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          t.menstrualGestationalAgeLine(
                            _calculateGestationalAge(controller.selectedLMPDate!).toString(),
                          ),
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
                        t.menstrualImportantInfoTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(t.menstrualImportantBullet1, style: const TextStyle(fontSize: 12)),
                      Text(t.menstrualImportantBullet2, style: const TextStyle(fontSize: 12)),
                      Text(t.menstrualImportantBullet3, style: const TextStyle(fontSize: 12)),
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

  int _calculateGestationalAge(DateTime lmpDate) {
    final now = DateTime.now();
    final difference = now.difference(lmpDate);
    return (difference.inDays / 7).floor();
  }
}
