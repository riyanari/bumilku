import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../theme/theme.dart';

class CalendarMenstruasi extends StatefulWidget {
  final String medisId;
  final int cycleLength;
  final DateTime lmp;
  final DateTime edd;
  final void Function(int cycleLength, DateTime lmp)? onSave;

  const CalendarMenstruasi({
    super.key,
    required this.medisId,
    required this.cycleLength,
    required this.lmp,
    required this.edd,
    this.onSave,
  });

  @override
  State<CalendarMenstruasi> createState() => _CalendarMenstruasiState();
}

class _CalendarMenstruasiState extends State<CalendarMenstruasi> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  // === UI HELPERS ===
  Widget _infoRow({
    required String label,
    required DateTime date,
    required IconData icon,
    required Color color,
  }) {
    final dateFmt = DateFormat('d MMM y', 'id_ID');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: ${dateFmt.format(date)}',
              style: blackTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    ),
  );

  Widget _markerBuilder(BuildContext context, DateTime day, List events) {
    final d = DateTime(day.year, day.month, day.day);
    final isLmp = isSameDay(widget.lmp, d);
    final isEdd = isSameDay(widget.edd, d);

    if (!isLmp && !isEdd) return const SizedBox.shrink();

    return Stack(
      children: [
        if (isLmp)
          Positioned(top: 2, right: 2, child: _badge('LMP', Colors.purple)),
        if (isEdd)
          Positioned(top: 2, left: 2, child: _badge('HPL', Colors.orange)),
      ],
    );
  }

  String _calculateGestationalAge() {
    final difference = DateTime.now().difference(widget.lmp);
    final weeks = (difference.inDays / 7).floor();
    return 'Anda memasuki minggu ke-$weeks usia kehamilan';
  }

  void _showEditLmpCycleDialog() {
    DateTime tempLmp = widget.lmp;
    int tempCycleLength = widget.cycleLength;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Atur Informasi Haid',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Keterangan LMP
                  Text(
                    'Hari Pertama Haid Terakhir (LMP) adalah hari pertama menstruasi terakhir Anda. '
                    'Data ini digunakan untuk menghitung usia kehamilan dan memperkirakan Hari Perkiraan Lahir (HPL).',
                    style: greyTextStyle.copyWith(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),

                  // Pilih tanggal LMP
                  Text(
                    'Tanggal Hari Pertama Haid Terakhir',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_today,
                      color: kPrimaryColor,
                    ),
                    title: Text(
                      DateFormat('EEEE, d MMMM y', 'id_ID').format(tempLmp),
                      style: blackTextStyle,
                    ),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: tempLmp,
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        locale: const Locale('id', 'ID'),
                      );
                      if (picked != null) {
                        setStateDialog(() => tempLmp = picked);
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  // Pilih panjang siklus
                  Text(
                    'Panjang Siklus Menstruasi',
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<int>(
                    value: tempCycleLength,
                    isExpanded: true,
                    items: List.generate(26, (i) => 20 + i)
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e hari'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) =>
                        setStateDialog(() => tempCycleLength = val!),
                  ),

                  const SizedBox(height: 20),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final adjustment = tempCycleLength - 28;
                        final newEdd = tempLmp.add(
                          Duration(days: 280 + adjustment),
                        );

                        // callback ke parent
                        widget.onSave?.call(tempCycleLength, tempLmp);

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: whiteTextStyle.copyWith(fontWeight: bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10,
          shadowColor: kPrimaryColor,
          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TableCalendar(
                  locale: 'id_ID',
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: _onDaySelected,
                  calendarFormat: CalendarFormat.month,
                  rangeSelectionMode: RangeSelectionMode.disabled,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: primaryTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 16,
                      color: kWhiteColor,
                    ),
                    leftChevronIcon: const Icon(
                      Icons.chevron_left,
                      color: kWhiteColor,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.chevron_right,
                      color: kWhiteColor,
                    ),
                    headerPadding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: _markerBuilder,
                  ),
                ),

                const Divider(color: kPrimaryColor, thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kalender Kehamilan',
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showEditLmpCycleDialog,
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
                _infoRow(
                  label: 'Haid pertama terakhir',
                  date: widget.lmp,
                  icon: Icons.favorite,
                  color: tSecondary10Color,
                ),
                const SizedBox(height: 6),
                _infoRow(
                  label: 'Prediksi melahirkan',
                  date: widget.edd,
                  icon: Icons.cake,
                  color: kPrimaryColor,
                ),
                const SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         // ke list riwayat kehamilan
                //       },
                //       child: Text("Riwayat Kehamilan"),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),

        if (widget.lmp != null) ...[
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: tPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('d MMMM y', 'id_ID').format(DateTime.now()),
                  style: whiteTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: kWhiteColor, thickness: 1),
                Text(
                  _calculateGestationalAge(),
                  style: whiteTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],

        // if (widget.lmp != null) ...[
        //   const SizedBox(height: 20),
        //   GestureDetector(
        //     onTap: () {
        //       AwesomeDialog(
        //         context: context,
        //         dialogType: DialogType.question,
        //         animType: AnimType.bottomSlide,
        //         title: "Konfirmasi",
        //         desc: "Apakah bayi Anda sudah lahir?",
        //         btnCancelOnPress: () {},
        //         btnOkOnPress: () {
        //           // TODO: panggil MedisCubit.markAsCompleted(userId)
        //           context.read<MedisCubit>().markAsCompleted(
        //             widget.medisId,
        //             DateTime.now(), // deliveredAt = hari ini
        //           );
        //         },
        //         btnOkText: "Ya, Sudah Lahir",
        //         btnCancelText: "Batal",
        //       ).show();
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(12),
        //       decoration: BoxDecoration(
        //         color: tPrimaryColor,
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       child: Column(
        //         children: [
        //           Text(
        //             DateFormat('d MMMM y', 'id_ID').format(DateTime.now()),
        //             style: whiteTextStyle.copyWith(
        //               fontSize: 10,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           const Divider(color: kWhiteColor, thickness: 1),
        //           Text(
        //             _calculateGestationalAge(),
        //             style: whiteTextStyle.copyWith(
        //               fontSize: 10,
        //               fontWeight: FontWeight.bold,
        //             ),
        //             textAlign: TextAlign.center,
        //           ),
        //           const SizedBox(height: 6),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const Icon(
        //                 Icons.touch_app,
        //                 size: 14,
        //                 color: Colors.white,
        //               ),
        //               const SizedBox(width: 4),
        //               Text(
        //                 "Tap jika bayi sudah lahir",
        //                 style: whiteTextStyle.copyWith(
        //                   fontSize: 9,
        //                   fontStyle: FontStyle.italic,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
