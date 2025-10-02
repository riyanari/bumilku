import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bumilku_app/pages/materi_maternitas.dart';
import 'package:bumilku_app/pages/pertanyaan_umum_page.dart';
import 'package:bumilku_app/pages/profile_page.dart';
import 'package:bumilku_app/pages/self_detection/detection_history_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/medis_cubit.dart';
import '../theme/theme.dart';
import 'calendar_menstruasi.dart';
import 'login_page.dart';

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Listen untuk state AuthInitial (setelah logout success)
        if (state is AuthInitial) {
          // Navigate ke login page dan hapus semua route
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
          );
        }

        // Handle logout error
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logout gagal: ${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header dengan logo dan icon logout langsung
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/lg_bumilku.png", height: 20,),
                          SizedBox(width: 8,),
                          Text(
                            "BUMILKU",
                            style: primaryTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                      // Container untuk icon profile dan logout
                      Row(
                        children: [
                          // Icon Profile
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => ProfilePage(),
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: kBackground2Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          // Icon Logout
                          GestureDetector(
                            onTap: () {
                              _showLogoutConfirmation(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: kBackground2Color,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.logout,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Calendar dan data medis
                  BlocBuilder<MedisCubit, MedisState>(
                    builder: (context, state) {
                      if (state is MedisLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MedisSuccess) {
                        final activeMedis = state.activeMedis;
                        final medisHistory = state.medisHistory;

                        final medisToShow = activeMedis ??
                            (medisHistory.isNotEmpty ? medisHistory.first : null);

                        if (medisToShow == null) {
                          return Column(
                            children: [
                              Text("Belum ada data kehamilan"),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
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
                            final adjustment = cycleLength - 28;
                            final newEdd = lmp.add(Duration(days: 280 + adjustment));

                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              if (activeMedis != null) {
                                context.read<MedisCubit>().addMedis(
                                  userId: user.uid,
                                  cycleLength: cycleLength,
                                  selectedLmp: lmp,
                                  edd: newEdd,
                                  babyName: activeMedis.babyName,
                                );
                              } else {
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
      ),
    );
  }

  // Dialog konfirmasi logout
  void _showLogoutConfirmation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Konfirmasi Logout',
      desc: 'Apakah Anda yakin ingin logout dari aplikasi BUMILKU?',
      btnCancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: tGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Batal",
          style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold
          )
        ),
      ),
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          context.read<AuthCubit>().signOut();
        },
        child: Text(
          "Logout",
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold
          )
        ),
      ),
      titleTextStyle: blackTextStyle.copyWith(
        fontSize: 20,
        fontWeight: bold
      ),
      descTextStyle: const TextStyle(
        fontSize: 16,
        color: tGreyColor,
      ),
    ).show();
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