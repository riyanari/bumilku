import 'package:bumilku_app/pages/self_detection/pages/complaints_page.dart';
import 'package:bumilku_app/pages/self_detection/pages/fetal_movement_page.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/self_detection_cubit.dart';
import '../../l10n/app_localizations.dart';
import 'detection_history_page.dart';
import 'loading_self_detection.dart';

class SelfDetectionPageView extends StatefulWidget {
  const SelfDetectionPageView({super.key});

  @override
  State<SelfDetectionPageView> createState() => _SelfDetectionPageViewState();
}

class _SelfDetectionPageViewState extends State<SelfDetectionPageView> {
  final PageController _pageController = PageController();
  final SelfDetectionController _controller = SelfDetectionController();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  List<Widget> _buildPages() {
    final pages = <Widget>[
      VitalDataPage(controller: _controller),
      ComplaintsPage(controller: _controller),
    ];

    // Tambahkan halaman gerakan janin jika dipilih
    if (_controller.shouldShowFetalMovementPage) {
      pages.add(FetalMovementPage(controller: _controller));
    }

    // Tambahkan halaman lainnya
    pages.addAll([
      PregnancyHistoryPage(controller: _controller),
      HealthHistoryPage(controller: _controller),
      PhysicalDataPage(controller: _controller),
      MenstrualPage(controller: _controller),
      LifestylePage(controller: _controller),
    ]);

    return pages;
  }

  int get _totalPages => _buildPages().length;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onControllerUpdate() {
    setState(() {});
  }

  void _nextPage() {
    if (_controller.currentPage < _totalPages - 1) {
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

  bool _validateCurrentPage() {
    final currentPage = _controller.currentPage;
    final pages = _buildPages();

    if (currentPage < pages.length) {
      final page = pages[currentPage];

      // Gunakan runtimeType untuk pengecekan tipe yang lebih aman
      if (page is VitalDataPage) {
        return _validateVitalData();
      } else if (page is FetalMovementPage) {
        return _validateFetalMovementPage();
      } else if (page is PregnancyHistoryPage) {
        return _validatePregnancyHistory();
      } else if (page is PhysicalDataPage) {
        return _validatePhysicalData();
      } else if (page is MenstrualPage) {
        return _controller.selectedLMPDate != null;
      } else if (page is LifestylePage) {
        return _validateLifestyleData();
      }
      // Untuk halaman lain (ComplaintsPage, HealthHistoryPage) tidak perlu validasi
    }

    return true;
  }

  bool _validateVitalData() {
    final validators = [
          (value) => value.isEmpty ? 'Tekanan darah sistolik harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Tekanan darah diastolik harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Suhu tubuh harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Nadi harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Frekuensi napas harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      _controller.systolicBpController,
      _controller.diastolicBpController,
      _controller.temperatureController,
      _controller.pulseController,
      _controller.respirationController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validateFetalMovementPage() {
    return _controller.fetalMovementCount > 0 &&
        _controller.fetalMovementDuration > 0 &&
        _controller.movementComparison.isNotEmpty;
  }

  bool _validatePregnancyHistory() {
    final validators = [
          (value) => value.isEmpty ? 'Jumlah anak harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Usia pertama hamil harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Jarak kehamilan harus diisi' : null,
    ];

    final controllers = [
      _controller.childrenCountController,
      _controller.firstPregnancyAgeController,
      _controller.pregnancyGapController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validatePhysicalData() {
    final validators = [
          (value) => value.isEmpty ? 'Tinggi badan harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Berat sebelum hamil harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
          (value) => value.isEmpty ? 'Berat saat ini harus diisi' : double.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      _controller.heightController,
      _controller.weightBeforeController,
      _controller.currentWeightController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  bool _validateLifestyleData() {
    final validators = [
          (value) => value.isEmpty ? 'Usia saat ini harus diisi' : int.tryParse(value) == null ? 'Masukkan angka yang valid' : null,
    ];

    final controllers = [
      _controller.currentAgeController,
    ];

    for (int i = 0; i < controllers.length; i++) {
      final error = validators[i](controllers[i].text);
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  Future<void> _startRiskFlow() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoadingSelfDetectionPage()),
    );

    await Future.delayed(const Duration(milliseconds: 700));

    // Hitung risiko berdasarkan formula yang benar
    final Map<String, dynamic> riskResult = _controller.calculateRiskBasedOnFormula(context);

    print('🔍 Risk Result Data:');
    print('Risk Level: ${riskResult['riskLevel']}');
    print('Score: ${riskResult['score']}');
    print('Details: ${riskResult['details']}');
    print('Recommendation: ${riskResult['recommendation']}');

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<SelfDetectionCubit>(context),
          child: ResultPage(
            riskResult: riskResult,
            onBack: () => Navigator.of(context).pop(),
            onSave: () async {
              if (_currentUser != null) {
                // Gunakan Cubit untuk save ke Firebase
                context.read<SelfDetectionCubit>().saveDetectionResult(
                  userId: _currentUser.uid,
                  riskResult: riskResult,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String _getButtonText(AppLocalizations t) {
    final currentPage = _controller.currentPage;
    if (currentPage == _totalPages - 1) {
      return t.calculateRisk;
    } else {
      return t.next;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = _totalPages;
    final currentPage = _controller.currentPage;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.selfDetectionTitle,
          style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: t.detectionHistory,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SelfDetectionCubit>(context),
                    child: const DetectionHistoryPage(),
                  ),
                ),
              );
            },
          ),
        ],
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
              currentPage: currentPage,
              pageCount: totalPages,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  _controller.currentPage = index;
                },
                children: _buildPages(),
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
                  if (currentPage > 0)
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
                          child: Text(t.back),
                        ),
                      ),
                    ),
                  if (currentPage > 0) const SizedBox(width: 12),
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
                          if (_validateCurrentPage()) {
                            if (currentPage == totalPages - 1) {
                              _startRiskFlow();
                            } else {
                              _nextPage();
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text(t.completeStepData),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(_getButtonText(t), style: whiteTextStyle),
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