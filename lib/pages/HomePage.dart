import 'package:bumilku_app/pages/materi_maternitas.dart';
import 'package:bumilku_app/pages/pertanyaan_umum_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'calendar_menstruasi.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget feature() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the containers properly
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
                    color: Color(0xffFBE0EC), // Set a background color
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3), // Shadow with some transparency
                        blurRadius: 6, // Soft shadow
                        spreadRadius: 1, // Small spread
                        offset: const Offset(0, 5), // Slight offset for the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Apply radius to the top corners of the image
                        child: Image.asset(
                          "assets/det_self.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12), // Add some space between the image and text
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
                      SizedBox(height: 6), // Add space between the title and subtitle
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
            SizedBox(width: 10), // Space between the two containers

            // Second Feature Container
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => MateriMaternitas(),
                  ),);
                },
                child: Container(
                  height: 200,
                  // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12), // Add padding inside the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFBE0EC), // Set a background color
                    boxShadow: [
                      BoxShadow(
                        color: tPrimaryColor.withValues(alpha:0.3), // Shadow with some transparency
                        blurRadius: 6, // Soft shadow
                        spreadRadius: 1, // Small spread
                        offset: const Offset(0, 5), // Slight offset for the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Apply radius to the top corners of the image
                        child: Image.asset(
                          "assets/matern.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 12), // Add some space between the image and text
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
                      SizedBox(height: 6), // Add space between the title and subtitle
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
          ],
        ),
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => PertanyaanUmumPage(),
            ),);
          },
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.45,
            // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12), // Add padding inside the container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffFBE0EC), // Set a background color
              boxShadow: [
                BoxShadow(
                  color: tPrimaryColor.withValues(alpha:0.3), // Shadow with some transparency
                  blurRadius: 6, // Soft shadow
                  spreadRadius: 1, // Small spread
                  offset: const Offset(0, 5), // Slight offset for the shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // Apply radius to the top corners of the image
                  child: Image.asset(
                    "assets/det_maternitas.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100,
                  ),
                ),
                SizedBox(height: 12), // Add some space between the image and text
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
                SizedBox(height: 6), // Add space between the title and subtitle
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
      ],
    );
  }

  // Widget feature() {
  //   return GridView.count(
  //     crossAxisCount: 2, // 2 kolom
  //     childAspectRatio: 0.7, // Rasio lebar-tinggi
  //     padding: EdgeInsets.all(10),
  //     crossAxisSpacing: 10,
  //     mainAxisSpacing: 10,
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(), // Nonaktifkan scroll jika dalam scrollable parent
  //     children: [
  //       // Fitur 1
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) => SelfDetectionPageView(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             color: Color(0xffFBE0EC),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: tPrimaryColor.withValues(alpha: 0.3),
  //                 blurRadius: 6,
  //                 spreadRadius: 1,
  //                 offset: const Offset(0, 5),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //                 child: Image.asset(
  //                   "assets/det_self.png",
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                   height: 100,
  //                 ),
  //               ),
  //               SizedBox(height: 12),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Self Detection",
  //                   style: primaryTextStyle.copyWith(
  //                     fontSize: 12,
  //                     fontWeight: bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 6),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Mari deteksi kondisi kehamilan Anda sekarang",
  //                   style: greyTextStyle.copyWith(
  //                     fontSize: 10,
  //                     fontWeight: regular,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 2,
  //                 ),
  //               ),
  //               SizedBox(height: 12)
  //             ],
  //           ),
  //         ),
  //       ),
  //       // Fitur 2
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) => MateriMaternitas(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             color: Color(0xffFBE0EC),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: tPrimaryColor.withValues(alpha: 0.3),
  //                 blurRadius: 6,
  //                 spreadRadius: 1,
  //                 offset: const Offset(0, 5),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //                 child: Image.asset(
  //                   "assets/det_maternitas.png",
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                   height: 100,
  //                 ),
  //               ),
  //               SizedBox(height: 12),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Apa itu Keperawatan Maternitas?",
  //                   style: primaryTextStyle.copyWith(
  //                     fontSize: 12,
  //                     fontWeight: bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 6),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Keperawatan maternitas adalah cabang keperawatan yang fokus pada kesehatan",
  //                   style: greyTextStyle.copyWith(
  //                     fontSize: 10,
  //                     fontWeight: regular,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 2,
  //                 ),
  //               ),
  //               SizedBox(height: 12)
  //             ],
  //           ),
  //         ),
  //       ),
  //       // Fitur 3 - akan otomatis pindah ke baris baru
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) => MateriMaternitas(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             color: Color(0xffFBE0EC),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: tPrimaryColor.withValues(alpha: 0.3),
  //                 blurRadius: 6,
  //                 spreadRadius: 1,
  //                 offset: const Offset(0, 5),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //                 child: Image.asset(
  //                   "assets/det_maternitas.png",
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                   height: 100,
  //                 ),
  //               ),
  //               SizedBox(height: 12),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Apa itu Keperawatan Maternitas?",
  //                   style: primaryTextStyle.copyWith(
  //                     fontSize: 12,
  //                     fontWeight: bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 6),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                 child: Text(
  //                   "Keperawatan maternitas adalah cabang keperawatan yang fokus pada kesehatan",
  //                   style: greyTextStyle.copyWith(
  //                     fontSize: 10,
  //                     fontWeight: regular,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 2,
  //                 ),
  //               ),
  //               SizedBox(height: 12)
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    /// ubah logo unissula, di klik ke profile mahasiswi
                    // GestureDetector(
                    //   onTap: (){
                    //     // Navigator.push(
                    //     //     context,
                    //     //     MaterialPageRoute(builder: (context) => const ProfilePage())
                    //     // );
                    //   },
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8), // Atur radius sesuai kebutuhan
                    //     child: Image.asset("assets/logo_unissula.png", height: 36),
                    //   ),
                    // ),
                  ],
                ),
                CalendarMenstruasi(),
                SizedBox(height: 20),
                feature()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
