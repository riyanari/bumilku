import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hitung perkiraan tanggal persalinan Anda',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // === NAMA BAYI ===
            Text(
              'Nama Bayi (Opsional)',
              style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: onBabyNameChanged,
              decoration: InputDecoration(
                hintText: 'Masukkan nama bayi...',
                hintStyle: greyTextStyle.copyWith(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2),
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
              'Panjang siklus dalam hari',
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
              'Hari pertama haid terakhir Bunda',
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
                onDateChanged: (date) => onLmpChanged(DateTime(date.year, date.month, date.day)),
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
                    // Nama Bayi
                    if (babyName != null && babyName!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RichText(
                          text: TextSpan(
                            style: blackTextStyle.copyWith(fontSize: 14),
                            children: [
                              const TextSpan(text: 'Nama Bayi: '),
                              TextSpan(
                                text: babyName,
                                style: primaryTextStyle.copyWith(fontWeight: bold),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Tanggal Persalinan
                    RichText(
                      text: TextSpan(
                        style: blackTextStyle.copyWith(fontSize: 14),
                        children: [
                          const TextSpan(text: 'Perkiraan tanggal persalinan: '),
                          TextSpan(
                            text: DateFormat('d MMMM y', 'id_ID').format(edd!),
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
  }
}