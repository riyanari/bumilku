import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Padding(
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              'Selamat datang! 👋',
              style: primaryTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Sebelum mulai, mari berkenalan terlebih dahulu',
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
                Icon(Icons.face_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  'Nama Bunda',
                  style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: namaController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Masukkan nama Bunda',
                hintStyle: greyTextStyle.copyWith(fontSize: 12),
                prefixIcon: Icon(Icons.person_rounded,
                    color: kPrimaryColor.withValues(alpha: 0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tGreyColor.withValues(alpha: 0.5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tGreyColor.withValues(alpha: 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: kPrimaryColor, width: 2),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.8),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                if (value.trim().length < 2) {
                  return 'Nama minimal 2 karakter';
                }
                if (value.trim().length > 30) {
                  return 'Nama maksimal 30 karakter';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            // === ALAMAT ===
            Row(
              children: [
                Icon(Icons.home_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  'Alamat',
                  style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: alamatController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Masukkan alamat lengkap',
                prefixIcon: Icon(Icons.location_on,
                    color: kPrimaryColor.withValues(alpha:0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tGreyColor.withValues(alpha:0.5)),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha:0.8),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            // === TANGGAL LAHIR ===
            Row(
              children: [
                Icon(Icons.cake_rounded, size: 18, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  'Tanggal Lahir',
                  style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: tanggalLahirController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Pilih tanggal lahir',
                prefixIcon: Icon(Icons.calendar_today,
                    color: kPrimaryColor.withValues(alpha:0.6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tGreyColor.withValues(alpha:0.5)),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha:0.8),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedTanggalLahir ?? DateTime(1990, 1, 1),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  locale: const Locale('id', 'ID'),
                );
                if (picked != null) {
                  onTanggalPicked(picked);
                  tanggalLahirController.text = DateFormat(
                    'd MMMM y',
                    'id_ID',
                  ).format(picked);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal lahir wajib diisi';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
