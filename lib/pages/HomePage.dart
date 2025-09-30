import 'package:bumilku_app/pages/materi_maternitas.dart';
import 'package:bumilku_app/pages/pertanyaan_umum_page.dart';
import 'package:bumilku_app/pages/self_detection/detection_history_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/medis_cubit.dart';
import '../theme/theme.dart';
import 'calendar_menstruasi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // PERBAIKAN: Ganti getMedis dengan getUserMedis
      context.read<MedisCubit>().getUserMedis(user.uid);
    }
  }

  Widget feature() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // First Feature Container
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => SelfDetectionPageView(),
                  ),);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          "assets/det_self.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Self Detection",
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Mari deteksi kondisi kehamilan Anda sekarang",
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),

            // Second Feature Container
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => DetectionHistoryPage(),
                  ),);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          "assets/riwayat_detection.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Riwayat Pemeriksaan",
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Riwayat pemeriksaan ini adalah riwayat yang dihasilkan dari self detection",
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Third Feature Container
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => MateriMaternitas(),
                  ),);
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          "assets/matern.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Apa itu Keperawatan Maternitas?",
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Keperawatan maternitas adalah cabang keperawatan yang fokus pada kesehatan",
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            // Fourth Feature Container
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => PertanyaanUmumPage(),
                  ),);
                },
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          "assets/det_maternitas.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Pertanyaan Umum",
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Mari baca pertanyaan yang sering kali ditanyakan saat hamil",
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 12,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackground2Color,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/lg_bumilku.png", height: 20,),
                    SizedBox(width: 8,),
                    Column(
                      children: [
                        Text(
                          "BUMILKU",
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                BlocBuilder<MedisCubit, MedisState>(
                  builder: (context, state) {
                    if (state is MedisLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MedisSuccess) {
                      // PERBAIKAN: Ambil data dari activeMedis atau history pertama
                      final activeMedis = state.activeMedis;
                      final medisHistory = state.medisHistory;

                      // Jika ada kehamilan aktif, tampilkan yang aktif
                      // Jika tidak ada yang aktif, tampilkan yang terbaru dari riwayat
                      final medisToShow = activeMedis ??
                          (medisHistory.isNotEmpty ? medisHistory.first : null);

                      if (medisToShow == null) {
                        return Column(
                          children: [
                            Text("Belum ada data kehamilan"),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate ke halaman tambah kehamilan
                                _showAddPregnancyDialog(context);
                              },
                              child: Text("Tambah Kehamilan"),
                            ),
                          ],
                        );
                      }

                      return CalendarMenstruasi(
                        medisId: medisToShow.id,
                        cycleLength: medisToShow.cycleLength,
                        lmp: medisToShow.selectedLmp,
                        edd: medisToShow.edd,
                        onSave: (cycleLength, lmp) {
                          // hitung ulang EDD
                          final adjustment = cycleLength - 28;
                          final newEdd = lmp.add(Duration(days: 280 + adjustment));

                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            // PERBAIKAN: Update kehamilan yang aktif
                            if (activeMedis != null) {
                              // Update kehamilan aktif yang sudah ada
                              context.read<MedisCubit>().addMedis(
                                userId: user.uid,
                                cycleLength: cycleLength,
                                selectedLmp: lmp,
                                edd: newEdd,
                                babyName: activeMedis.babyName,
                              );
                            } else {
                              // Buat kehamilan baru
                              context.read<MedisCubit>().addMedis(
                                userId: user.uid,
                                cycleLength: cycleLength,
                                selectedLmp: lmp,
                                edd: newEdd,
                              );
                            }
                          }
                        },
                      );
                    } else if (state is MedisFailed) {
                      return Column(
                        children: [
                          Text("Error: ${state.error}"),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                context.read<MedisCubit>().getUserMedis(user.uid);
                              }
                            },
                            child: Text("Coba Lagi"),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Text("Data medis belum tersedia"),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _showAddPregnancyDialog(context);
                            },
                            child: Text("Tambah Kehamilan Pertama"),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                feature()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dialog untuk menambah kehamilan baru
  void _showAddPregnancyDialog(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tambah Kehamilan Baru"),
        content: Text("Apakah Anda ingin menambah data kehamilan baru?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Default values untuk kehamilan baru
              final defaultLmp = DateTime.now().subtract(Duration(days: 30));
              final defaultEdd = defaultLmp.add(Duration(days: 280));

              context.read<MedisCubit>().addMedis(
                userId: user.uid,
                cycleLength: 28,
                selectedLmp: defaultLmp,
                edd: defaultEdd,
              );
            },
            child: Text("Tambah"),
          ),
        ],
      ),
    );
  }
}