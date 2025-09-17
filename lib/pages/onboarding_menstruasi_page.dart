import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'loading_page.dart';

class OnboardingMenstruasiPage extends StatefulWidget {
  const OnboardingMenstruasiPage({super.key});

  @override
  State<OnboardingMenstruasiPage> createState() => _OnboardingMenstruasiPageState();
}

class _OnboardingMenstruasiPageState extends State<OnboardingMenstruasiPage> {
  int cycleLength = 28; // panjang siklus default
  DateTime? selectedLmp; // LMP = hari pertama haid terakhir
  DateTime? edd; // Estimated Due Date / HPL

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null).then((_) {
      setState(() {}); // rebuild setelah inisialisasi locale
    });
  }

  void _recalculateEDD() {
    if (selectedLmp == null) {
      setState(() => edd = null);
      return;
    }
    // Naegele: EDD = LMP + 280 hari, disesuaikan panjang siklus
    final adjustment = cycleLength - 28;
    final result = selectedLmp!.add(Duration(days: 280 + adjustment));
    setState(() => edd = result);
  }

  Future<void> _savePregnancyData() async {
    if (selectedLmp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Silakan pilih hari pertama haid terakhir', style: whiteTextStyle),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _recalculateEDD(); // pastikan EDD ter-update
    if (edd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tidak bisa menghitung HPL. Coba ulangi.', style: whiteTextStyle),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 1) Minta nama bayi via AwesomeDialog
    final babyName = await _askBabyName();
    if (babyName == null) return; // user batal / kosong

    // 2) Simpan ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final newRecord = {
      'cycleLengthDays': cycleLength,
      'lmp': selectedLmp!.toIso8601String(),
      'edd': edd?.toIso8601String(),
      'babyName': babyName,
      'createdAt': DateTime.now().toIso8601String(),
    };

    final existingRecordsJson = prefs.getString('pregnancyRecords') ?? '[]';
    final List<dynamic> records = json.decode(existingRecordsJson);
    records.add(newRecord);

    await prefs.setString('pregnancyRecords', json.encode(records));
    await prefs.setInt('currentCycleLength', cycleLength);
    await prefs.setString('currentLmp', selectedLmp!.toIso8601String());
    await prefs.setString('currentBabyName', babyName);
    if (edd != null) {
      await prefs.setString('currentEDD', edd!.toIso8601String());
    }

    // 3) Arahkan ke halaman loading (nanti halaman loading yang akan push ke congrats)
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoadingPage(babyName: babyName, edd: edd!),
      ),
    );
  }


  Future<String?> _askBabyName() async {
    final controller = TextEditingController();
    final completer = Completer<String?>();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: 'Nama bayi',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Masukkan nama bayi', style: blackTextStyle),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'cth: Aisyah / Bima',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {}, // biar keyboard done
          ),
          const SizedBox(height: 6),
          Text('Nama ini bisa diubah nanti di pengaturan.',
              style: blackTextStyle.copyWith(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
      btnCancelText: 'Batal',
      btnCancelOnPress: () => completer.complete(null),
      btnOkText: 'Lanjut',
      btnOkOnPress: () {
        final value = controller.text.trim();
        completer.complete(value);
      },
    ).show();

    final name = await completer.future;
    if ((name == null) || name.isEmpty) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama bayi tidak boleh kosong', style: whiteTextStyle),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('d MMMM y', 'id_ID');

    return Scaffold(
      backgroundColor: kBackgroundColor,

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _savePregnancyData,
              child: Text('Simpan', style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 14)),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Text(
                'Hitung perkiraan tanggal persalinan Anda',
                style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // PANJANG SIKLUS
              Text(
                'Panjang siklus dalam hari',
                style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
              ),
              const SizedBox(height: 10),

              // Container angka 20-45, list horizontal
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
                        onSelected: (bool selected) {
                          setState(() => cycleLength = num);
                          _recalculateEDD();
                        },
                        selectedColor: kPrimaryColor,
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: kSecondaryColor.withValues(alpha:0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // LMP + kalender inline
              Text(
                'Hari pertama haid terakhir bunda',
                style: blackTextStyle.copyWith(fontWeight: regular, fontSize: 12),
              ),
              const SizedBox(height: 10),

              Card(
                elevation: 4,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: kPrimaryColor,
                      onPrimary: kWhiteColor,
                      onSurface: tBlackColor,
                    ),
                    datePickerTheme: DatePickerThemeData(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      headerBackgroundColor: kPrimaryColor,
                      headerForegroundColor: kWhiteColor,
                      headerHeadlineStyle: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 14,
                        color: kWhiteColor,
                      ),
                      weekdayStyle: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        color: tBlackColor,
                      ),
                      // Gaya untuk semua hari (termasuk yang dipilih)
                      dayStyle: primaryTextStyle.copyWith(
                        fontSize: 12, // Ukuran font lebih kecil
                      ),
                      // Shape khusus untuk hari yang dipilih (membuat container lebih kecil)
                      dayShape: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Border radius lebih kecil
                          );
                        }
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        );
                      }),
                      // Warna teks hari
                      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) return kWhiteColor;
                        if (states.contains(WidgetState.disabled)) return Colors.grey;
                        return tBlackColor;
                      }),
                      // Warna background hari (membuat container selected lebih kecil)
                      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return kPrimaryColor;
                        }
                        return Colors.transparent;
                      }),
                      // Highlight untuk 'hari ini'
                      todayForegroundColor: WidgetStateProperty.all(tSecondary20Color),
                      todayBackgroundColor:
                      WidgetStateProperty.all(tSecondary20Color.withValues(alpha: 0.15)),
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedLmp ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                    onDateChanged: (date) {
                      setState(() => selectedLmp = DateTime(date.year, date.month, date.day));
                      _recalculateEDD();
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Preview HPL (optional, membantu user)
              if (edd != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: blackTextStyle.copyWith(fontSize: 14),
                      children: [
                        const TextSpan(text: 'Perkiraan tanggal persalinan: '),
                        TextSpan(
                          text: dateFmt.format(edd!),
                          style: primaryTextStyle.copyWith(fontWeight: bold),
                        ),
                      ],
                    ),
                  ),
                ),

              // const SizedBox(height: 24),

              // Tombol Simpan
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: kPrimaryColor,
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //     ),
              //     onPressed: _savePregnancyData,
              //     child: Text(
              //       'Simpan',
              //       style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 14),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
