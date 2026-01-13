import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/theme.dart';

class DataDiriPage extends StatelessWidget {
  final TextEditingController namaController;
  final TextEditingController alamatController;
  final TextEditingController tanggalLahirController;
  final DateTime? selectedTanggalLahir;
  final Function(DateTime) onTanggalPicked;

  const DataDiriPage({
    super.key,
    required this.namaController,
    required this.alamatController,
    required this.tanggalLahirController,
    required this.selectedTanggalLahir,
    required this.onTanggalPicked,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isEn = locale.languageCode == 'en';
    final dateLocale = isEn ? 'en_US' : 'id_ID';

    return Padding(
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              t.signupWelcomeTitle, // "Selamat datang! 👋" / "Welcome! 👋"
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              t.signupWelcomeDesc, // "Sebelum mulai..." / "Before we start..."
              style: blackTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // === NAMA ===
            Row(
              children: [
                const Icon(Icons.face_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  t.signupNameLabel, // "Nama Bunda" / "Your Name"
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: namaController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: t.signupNameHint, // "Masukkan nama Bunda" / "Enter your name"
                hintStyle: greyTextStyle.copyWith(fontSize: 12),
                prefixIcon: Icon(
                  Icons.person_rounded,
                  color: kPrimaryColor.withValues(alpha: 0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return t.signupNameEmpty; // "Nama tidak boleh kosong"
                if (v.length < 2) return t.signupNameMin2; // "Nama minimal 2 karakter"
                if (v.length > 30) return t.signupNameMax30; // "Nama maksimal 30 karakter"
                return null;
              },
            ),

            const SizedBox(height: 12),

            // === ALAMAT ===
            Row(
              children: [
                const Icon(Icons.home_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  t.signupAddressLabel, // "Alamat" / "Address"
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: alamatController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: t.signupAddressHint, // "Masukkan alamat lengkap" / "Enter your full address"
                prefixIcon: Icon(
                  Icons.location_on,
                  color: kPrimaryColor.withValues(alpha: 0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              validator: (value) {
                final v = (value ?? '').trim();
                if (v.isEmpty) return t.signupAddressEmpty; // "Alamat tidak boleh kosong"
                return null;
              },
            ),

            const SizedBox(height: 12),

            // === TANGGAL LAHIR ===
            Row(
              children: [
                const Icon(Icons.cake_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  t.signupDobLabel, // "Tanggal Lahir" / "Date of Birth"
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: tanggalLahirController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: t.signupDobHint, // "Pilih tanggal lahir" / "Select date of birth"
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: kPrimaryColor.withValues(alpha: 0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: tGreyColor.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedTanggalLahir ?? DateTime(1990, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  // JANGAN set locale di sini.
                  // Biar ikut MaterialApp.locale (LocaleCubit) otomatis,
                  // dan menghindari error "named parameter locale isn't defined" di komponen lain.
                );

                if (picked != null) {
                  onTanggalPicked(picked);
                  tanggalLahirController.text =
                      DateFormat('d MMMM y', dateLocale).format(picked);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) return t.signupDobRequired; // "Tanggal lahir wajib diisi"
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
