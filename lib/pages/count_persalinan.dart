import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/locale_cubit.dart';
import '../theme/theme.dart';

class CountPersalinan extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CountPersalinan({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _pickDate(BuildContext context, Locale locale) async {
    final DateTime initial = selectedDate ?? DateTime.now();
    final isEn = locale.languageCode == 'en';

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      locale: isEn ? const Locale('en', 'US') : const Locale('id', 'ID'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: kPrimaryColor,
              onPrimary: kWhiteColor,
              onSurface: tBlackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        final dateLocale = isEn ? 'en_US' : 'id_ID';

        final String label = (selectedDate == null)
            ? (isEn ? "Select date" : "Pilih tanggal")
            : DateFormat('d MMMM y', dateLocale).format(selectedDate!);

        final question = isEn
            ? "When did your last period start?"
            : "Kapan periode haid terakhir Anda dimulai?";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Center(
              child: Image.asset(
                "assets/terakhir_haid.png",
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 0),
              child: Text(
                question,
                style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
              ),
            ),
            GestureDetector(
              onTap: () => _pickDate(context, locale),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                margin: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (selectedDate == null)
                        ? Colors.grey.withValues(alpha: 0.3)
                        : kPrimaryColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: (selectedDate == null)
                          ? greyTextStyle.copyWith(fontSize: 16)
                          : blackTextStyle.copyWith(fontSize: 16),
                    ),
                    Icon(
                      Icons.calendar_month,
                      color:
                      (selectedDate == null) ? Colors.grey : kPrimaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
