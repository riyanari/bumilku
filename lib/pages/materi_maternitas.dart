import 'package:flutter/material.dart';

import '../theme/theme.dart';

class MateriMaternitas extends StatelessWidget {
  const MateriMaternitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Materi Maternitas",
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan gambar
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/matern.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withValues(alpha:0.4),
                ),
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    'Panduan Lengkap Ibu Hamil & Perawatan Bayi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Kesehatan Ibu Hamil
            _buildSectionTitle('Kesehatan Ibu Hamil'),
            const SizedBox(height: 12),
            _buildInfoCard(
              'Nutrisi Penting',
              'Konsumsi makanan bergizi seimbang dengan asam folat, zat besi, kalsium, dan protein. Hindari makanan mentah, alkohol, dan batasi kafein.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Aktivitas & Olahraga',
              'Lakukan olahraga ringan seperti jalan kaki, senam hamil, atau yoga. Hindari aktivitas berat dan istirahat yang cukup.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Pemeriksaan Rutin',
              'Lakukan kontrol kehamilan secara teratur untuk memantau perkembangan janin dan mendeteksi dini masalah kesehatan.',
            ),

            const SizedBox(height: 24),

            // Persalinan
            _buildSectionTitle('Persalinan'),
            const SizedBox(height: 12),
            _buildInfoCard(
              'Tanda-Tanda Persalinan',
              'Kontraksi teratur, pecah ketuban, dan pembukaan serviks. Segera hubungi dokter atau bidan ketika mengalami tanda-tanda ini.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Pilihan Persalinan',
              'Persalinan normal, caesar, atau water birth. Diskusikan dengan dokter tentang metode terbaik sesuai kondisi kesehatan.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Persiapan Menjelang Persalinan',
              'Siapkan tas berisi kebutuhan ibu dan bayi, dokumen penting, serta rencanakan transportasi ke rumah sakit.',
            ),

            const SizedBox(height: 24),

            // Perawatan Bayi
            _buildSectionTitle('Perawatan Bayi Baru Lahir'),
            const SizedBox(height: 12),
            _buildInfoCard(
              'Perawatan Tali Pusat',
              'Jaga kebersihan area tali pusat, keringkan setelah mandi, dan hindari penggunaan bedak atau alkohol berlebihan.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Menyusui',
              'Berikan ASI eksklusif 6 bulan. Pastikan pelekatan yang benar dan susui setiap 2-3 jam atau sesuai kebutuhan bayi.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Perawatan Kulit',
              'Gunakan produk bayi yang hypoallergenic, mandikan dengan air hangat, dan jaga kulit tetap kering untuk mencegah ruam.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Imunisasi',
              'Lengkapi imunisasi sesuai jadwal untuk melindungi bayi dari berbagai penyakit berbahaya.',
            ),

            const SizedBox(height: 24),

            // Tips Tambahan
            _buildSectionTitle('Tips Penting Lainnya'),
            const SizedBox(height: 12),
            _buildInfoCard(
              'Kesehatan Mental Ibu',
              'Jaga kesehatan mental dengan istirahat cukup, dukungan keluarga, dan jangan ragu berkonsultasi dengan tenaga kesehatan jika mengalami baby blues.',
            ),
            const SizedBox(height: 8),
            _buildInfoCard(
              'Pemulihan Pasca Melahirkan',
              'Lakukan perawatan pasca persalinan, konsumsi makanan bergizi, dan lakukan olahraga ringan setelah mendapat izin dokter.',
            ),

            const SizedBox(height: 24),

            // Penutup
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Selalu konsultasikan dengan tenaga kesehatan profesional untuk perawatan yang tepat sesuai kondisi individu.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.pink,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: primaryTextStyle.copyWith(
        fontSize: 18,
        fontWeight: extraBold
      )
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: kPrimaryColor.withValues(alpha: 1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}