import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/locale_cubit.dart';
import '../../theme/theme.dart';

class DataMensPage extends StatelessWidget {
  final int cycleLength;
  final DateTime? selectedLmp;
  final DateTime? edd;
  final String? babyName;
  final Function(int) onCycleChanged;
  final Function(DateTime) onLmpChanged;
  final Function(String) onBabyNameChanged;

  const DataMensPage({
    super.key,
    required this.cycleLength,
    required this.selectedLmp,
    required this.edd,
    this.babyName,
    required this.onCycleChanged,
    required this.onLmpChanged,
    required this.onBabyNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        final title = isEn
            ? 'Calculate your estimated due date'
            : 'Hitung perkiraan tanggal persalinan Anda';

        final babyLabel = isEn ? 'Baby name (Optional)' : 'Nama Bayi (Opsional)';
        final babyHint = isEn ? 'Enter baby name...' : 'Masukkan nama bayi...';

        final cycleLabel = isEn ? 'Cycle length (days)' : 'Panjang siklus dalam hari';

        final lmpLabel = isEn
            ? 'First day of your last period'
            : 'Hari pertama haid terakhir Bunda';

        final dueLabel = isEn ? 'Estimated due date: ' : 'Perkiraan tanggal persalinan: ';
        final babyPreviewLabel = isEn ? 'Baby name: ' : 'Nama Bayi: ';

        // Locale untuk DateFormat & CalendarDatePicker
        final dateLocale = isEn ? 'en_US' : 'id_ID';

        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

                // === NAMA BAYI ===
                Text(
                  babyLabel,
                  style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: onBabyNameChanged,
                  decoration: InputDecoration(
                    hintText: babyHint,
                    hintStyle: greyTextStyle.copyWith(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  style: blackTextStyle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 16),

                // === PANJANG SIKLUS ===
                Text(
                  cycleLabel,
                  style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(26, (i) => 20 + i).map((num) {
                      final bool selected = num == cycleLength;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text('$num'),
                          selected: selected,
                          onSelected: (_) => onCycleChanged(num),
                          selectedColor: kPrimaryColor,
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: kSecondaryColor.withValues(alpha: 0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 14),

                // === LMP ===
                Text(
                  lmpLabel,
                  style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedLmp ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                    // ini yang bikin bulan/hari ikut bahasa
                    // locale: Locale(isEn ? 'en' : 'id', isEn ? 'US' : 'ID'),
                    onDateChanged: (date) => onLmpChanged(
                      DateTime(date.year, date.month, date.day),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // === PREVIEW HPL ===
                if (edd != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (babyName != null && babyName!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: RichText(
                              text: TextSpan(
                                style: blackTextStyle.copyWith(fontSize: 14),
                                children: [
                                  TextSpan(text: babyPreviewLabel),
                                  TextSpan(
                                    text: babyName!,
                                    style: primaryTextStyle.copyWith(fontWeight: bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        RichText(
                          text: TextSpan(
                            style: blackTextStyle.copyWith(fontSize: 14),
                            children: [
                              TextSpan(text: dueLabel),
                              TextSpan(
                                text: DateFormat('d MMMM y', dateLocale).format(edd!),
                                style: primaryTextStyle.copyWith(fontWeight: bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
