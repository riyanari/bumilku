import 'package:bumilku_app/pages/self_detection/pages/complaints_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/health_history_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/lifestyle_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/menstrual_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/physical_data_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/pregnancy_history_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/vital_data_page.dart';
import 'package:bumilku_app/pages/self_detection/result_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_controller.dart';
import 'package:bumilku_app/pages/self_detection/widgets/page_indicator.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'loading_self_detection.dart';

class SelfDetectionPageView extends StatefulWidget {
  const SelfDetectionPageView({super.key});

  @override
  State<SelfDetectionPageView> createState() => _SelfDetectionPageViewState();
}

class _SelfDetectionPageViewState extends State<SelfDetectionPageView> {
  final PageController _pageController = PageController();
  final SelfDetectionController _controller = SelfDetectionController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  void _nextPage() {
    if (_controller.currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_controller.currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Future<void> _startRiskFlow() async {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (_) => const LoadingPage()),
  //   );
  //
  //   await Future.delayed(const Duration(milliseconds: 700));
  //   _controller.calculateRisk();
  //
  //   // TAMBAHKAN DATA EDUKASI KE riskResult
  //   final Map<String, dynamic> riskResult = {
  //     'riskLevel': _normalizeRiskLevel(_controller.result),
  //     'score': _controller.score.round(),
  //     'recommendation': _controller.recommendation,
  //     'details': _controller.redFlagReasons,
  //     // TAMBAH DATA EDUKASI DI SINI:
  //     'complaintEducations': _controller.selectedComplaintEducations,
  //     'riskEducation': _controller.riskLevelEducation,
  //     'generalTips': _controller.getGeneralPregnancyTips(),
  //   };
  //
  //   if (!mounted) return;
  //
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (_) => ResultPage(
  //         riskResult: riskResult,
  //         onBack: () => Navigator.of(context).pop(),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _startRiskFlow() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoadingPage()),
    );

    await Future.delayed(const Duration(milliseconds: 700));

    // Hitung risiko berdasarkan formula yang benar
    final Map<String, dynamic> riskResult = _controller.calculateRiskBasedOnFormula();

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultPage(
          riskResult: riskResult,
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

// Ubah "Risiko tinggi" / "Perlu perhatian" / "Kehamilan normal" -> "tinggi" / "sedang" / "rendah"
  String _normalizeRiskLevel(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('tinggi')) return 'tinggi';
    if (lower.contains('perlu perhatian') || lower.contains('sedang')) return 'sedang';
    if (lower.contains('normal') || lower.contains('rendah')) return 'rendah';
    return 'tidak diketahui';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deteksi Mandiri Ibu Hamil",
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
        child: Column(
          children: [
            PageIndicator(
              currentPage: _controller.currentPage,
              pageCount: 7,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                // allowImplicitScrolling: true,
                onPageChanged: (index) {
                  _controller.currentPage = index;
                },
                children: [
                  VitalDataPage(controller: _controller),
                  ComplaintsPage(controller: _controller),
                  PregnancyHistoryPage(controller: _controller),
                  HealthHistoryPage(controller: _controller),
                  PhysicalDataPage(controller: _controller),
                  MenstrualPage(controller: _controller),
                  LifestylePage(controller: _controller),
                ],
              ),
            ),
            // Navigation Buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha:0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_controller.currentPage > 0)
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kPrimaryColor,
                            side: BorderSide(color: kPrimaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _previousPage,
                          child: const Text("Kembali"),
                        ),
                      ),
                    ),
                  if (_controller.currentPage > 0) const SizedBox(width: 12),
                  if (_controller.currentPage < 6)
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            if (_controller.validateCurrentPage()) {
                              _nextPage();
                            } else {
                              setState(() {});
                            }
                          },
                          child: Text("Lanjut", style: whiteTextStyle),
                        ),
                      ),
                    ),
                  if (_controller.currentPage == 6)
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          onPressed: () {
                            if (_controller.validateCurrentPage()) {
                              _startRiskFlow();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Harap lengkapi data pada langkah ini.")),
                              );
                              setState(() {});
                            }
                          },
                          child: Text("Hitung Risiko", style: whiteTextStyle),
                        ),
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