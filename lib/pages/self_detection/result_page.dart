import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> riskResult;
  final VoidCallback onBack;

  const ResultPage({
    super.key,
    required this.riskResult,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final riskLevel = riskResult['riskLevel']?.toString().toLowerCase() ?? 'unknown';
    final score = riskResult['score'] ?? 0;
    final details = riskResult['details'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Deteksi Mandiri",
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor.withValues(alpha:0.05),
              kBackgroundColor.withValues(alpha:0.2),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header dengan ikon animasi
              _buildRiskHeader(riskLevel, score),

              const SizedBox(height: 24),

              // Meter risiko visual
              _buildRiskMeter(riskLevel, score),

              const SizedBox(height: 24),

              // Detail faktor risiko (jika ada)
              if (details.isNotEmpty) _buildRiskDetailsCard(details),

              // Card rekomendasi
              _buildRecommendationCard(),

              const SizedBox(height: 16),

              const SizedBox(height: 24),

              // Tombol aksi
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiskHeader(String riskLevel, int score) {
    final riskData = _getRiskData(riskLevel);

    return Column(
      children: [
        // Gunakan icon saja
        Icon(
          riskData['icon'],
          size: 80,
          color: riskData['color'],
        ),
        const SizedBox(height: 16),
        Text(
          riskResult['riskLevel'] ?? 'Tidak diketahui',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: riskData['color'],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Skor: $score/100",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          riskData['message'],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRiskMeter(String riskLevel, int score) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const indicatorW = 4.0;
            final barWidth = constraints.maxWidth;
            final pct = (score.clamp(0, 100) / 100.0) * 0.9; // 0..0.9 sesuai logika kamu
            final leftPx = ((barWidth - indicatorW) * pct)
                .clamp(0.0, barWidth - indicatorW);

            return Column(
              children: [
                Text(
                  "Tingkat Risiko Kehamilan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),

                // Meter bar visual
                Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.orange, Colors.red],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Positioned(
                      left: leftPx, // <<-- sekarang double (px), bukan string
                      top: -5,
                      child: Container(
                        width: indicatorW,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Rendah", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    Text("Sedang", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    Text("Tinggi", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }


  Widget _buildRecommendationCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services, color: kPrimaryColor),
                const SizedBox(width: 8),
                Text(
                  "Rekomendasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              riskResult['recommendation'] ?? 'Tidak ada rekomendasi spesifik',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),

            if (riskResult['nextSteps'] != null) ...[
              const SizedBox(height: 16),

              Text(
                "Langkah Selanjutnya:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 8),

              ...(riskResult['nextSteps'] as List<dynamic>).map((step) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_forward, size: 16, color: kPrimaryColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            step.toString(),
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )
              ).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRiskDetailsCard(List<dynamic> details) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Faktor Risiko yang Teridentifikasi",
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold
                    )
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ...details.map((detail) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          detail.toString(),
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                )
            ).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: kPrimaryColor,
        //     foregroundColor: Colors.white,
        //     minimumSize: const Size(double.infinity, 50),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     elevation: 2,
        //   ),
        //   onPressed: () {
        //     // Simpan atau bagikan hasil
        //     _showSaveShareOptions(context);
        //   },
        //   child: const Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Icon(Icons.share),
        //       SizedBox(width: 8),
        //       Text("Simpan & Bagikan Hasil"),
        //     ],
        //   ),
        // ),

        const SizedBox(height: 12),

        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: kPrimaryColor,
            side: BorderSide(color: kPrimaryColor),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onBack,
          child: const Text("Kembali ke Deteksi Mandiri"),
        ),

        const SizedBox(height: 12),

        if (_getRiskData(riskResult['riskLevel']?.toString().toLowerCase() ?? 'unknown')['showEmergency'] == true)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              // Hubungi bantuan darurat
              _contactEmergency(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emergency),
                SizedBox(width: 8),
                Text("Hubungi Bantuan Darurat"),
              ],
            ),
          ),
      ],
    );
  }

  void _showSaveShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.save, color: kPrimaryColor),
                title: const Text("Simpan Hasil"),
                onTap: () {
                  Navigator.pop(context);
                  // Implementasi penyimpanan
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: kPrimaryColor),
                title: const Text("Bagikan Hasil"),
                onTap: () {
                  Navigator.pop(context);
                  // Implementasi berbagi
                },
              ),
              ListTile(
                leading: const Icon(Icons.print, color: kPrimaryColor),
                title: const Text("Cetak Hasil"),
                onTap: () {
                  Navigator.pop(context);
                  // Implementasi cetak
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _contactEmergency(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hubungi Bantuan Darurat"),
          content: const Text("Apakah Anda ingin menghubungi layanan bantuan darurat?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implementasi panggilan darurat
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Hubungi"),
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> _getRiskData(String riskLevel) {
    switch (riskLevel) {
      case 'tinggi':
        return {
          'color': Colors.red,
          'icon': Icons.warning_rounded,
          'message': 'Hasil menunjukkan tingkat risiko tinggi. Segera konsultasi dengan dokter kandungan.',
          'showEmergency': true,
        };
      case 'sedang':
        return {
          'color': Colors.orange,
          'icon': Icons.info_rounded,
          'message': 'Hasil menunjukkan tingkat risiko sedang. Perhatikan kondisi dan lakukan pemeriksaan rutin.',
          'showEmergency': false,
        };
      case 'rendah':
        return {
          'color': Colors.green,
          'icon': Icons.check_circle_rounded,
          'message': 'Hasil menunjukkan tingkat risiko rendah. Pertahankan pola hidup sehat dan rutin kontrol.',
          'showEmergency': false,
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.help_rounded,
          'message': 'Tidak dapat menentukan tingkat risiko. Silakan coba lagi atau konsultasi dengan dokter.',
          'showEmergency': false,
        };
    }
  }
}