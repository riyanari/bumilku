import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme.dart';

class CalendarMenstruasi extends StatefulWidget {
  const CalendarMenstruasi({super.key});

  @override
  State<CalendarMenstruasi> createState() => _CalendarMenstruasiState();
}

class _CalendarMenstruasiState extends State<CalendarMenstruasi> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime firstDay = DateTime.now().subtract(const Duration(days: 365));
  final DateTime lastDay = DateTime.now().add(const Duration(days: 365));

  // Hanya LMP (hari pertama haid terakhir) & HPL/EDD (perkiraan lahir)
  DateTime? _pregLmp;
  DateTime? _pregEdd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadPregnancyDates();
  }

  Future<void> _loadPregnancyDates() async {
    final prefs = await SharedPreferences.getInstance();
    final lmpStr = prefs.getString('currentLmp');
    final eddStr = prefs.getString('currentEDD');
    setState(() {
      _pregLmp = (lmpStr != null) ? DateTime.tryParse(lmpStr) : null;
      _pregEdd = (eddStr != null) ? DateTime.tryParse(eddStr) : null;
    });
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

  // Marker kalender: hanya LMP & HPL
  Widget _markerBuilder(BuildContext context, DateTime day, List events) {
    final d = DateTime(day.year, day.month, day.day);
    final isLmp = _pregLmp != null && isSameDay(_pregLmp!, d);
    final isEdd = _pregEdd != null && isSameDay(_pregEdd!, d);

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

  // === Calculate Gestational Age ===
  String _calculateGestationalAge(DateTime selectedDate) {
    if (_pregLmp == null) return ''; // Return empty if LMP is not set

    final difference = selectedDate.difference(_pregLmp!);
    final weeks = (difference.inDays / 7).floor();
    return 'Anda memasuki minggu ke-$weeks usia kehamilan';
  }

  void _showEditLmpCycleDialog() {
    DateTime? tempLmp = _pregLmp ?? DateTime.now();
    int tempCycleLength = 28; // default 28 hari

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.1),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Text(
                  'Atur Informasi Haid',
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // LMP Selection
              Text(
                'Hari Pertama Haid Terakhir (LMP)',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ListTile(
                  leading: Icon(Icons.calendar_today, color: kPrimaryColor, size: 22),
                  title: Text(
                    tempLmp != null
                        ? DateFormat('EEEE, d MMMM y', 'id_ID').format(tempLmp!)
                        : 'Pilih tanggal',
                    style: blackTextStyle.copyWith(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.arrow_drop_down, size: 22),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: tempLmp!,
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      locale: const Locale('id', 'ID'),
                      builder: (context, child) => Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: kPrimaryColor,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black,
                          ),
                          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
                        ),
                        child: child!,
                      ),
                    );
                    if (picked != null) {
                      setState(() => tempLmp = picked);
                    }
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Cycle Length Selection
              Text(
                'Panjang Siklus Haid',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.autorenew, color: kPrimaryColor, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButton<int>(
                        value: tempCycleLength,
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius: BorderRadius.circular(12),
                        style: blackTextStyle.copyWith(fontSize: 14),
                        items: List.generate(26, (i) => 20 + i)
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text('$e hari'),
                        ))
                            .toList(),
                        onChanged: (val) => setState(() => tempCycleLength = val!),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Info Text
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: kPrimaryColor, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Siklus normal berkisar antara 21-35 hari',
                        style: primaryTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Simpan ke SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('currentCycleLength', tempCycleLength);
                        if (tempLmp != null) {
                          await prefs.setString('currentLmp', tempLmp!.toIso8601String());

                          // Recalculate EDD
                          final adjustment = tempCycleLength - 28;
                          final newEdd = tempLmp!.add(Duration(days: 280 + adjustment));
                          await prefs.setString('currentEDD', newEdd.toIso8601String());

                          setState(() {
                            _pregLmp = tempLmp;
                            _pregEdd = newEdd;
                            _focusedDay = tempLmp!;
                            _selectedDay = tempLmp;
                          });
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                  firstDay: firstDay,
                  lastDay: lastDay,
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
                // Info LMP & HPL di atas kalender (muncul jika tersedia)
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

                if (_pregLmp != null || _pregEdd != null) ...[
                  if (_pregLmp != null)
                    _infoRow(
                      label: 'Haid pertama terakhir',
                      date: _pregLmp!,
                      icon: Icons.favorite,
                      color: tSecondary10Color,
                    ),
                  if (_pregEdd != null) const SizedBox(height: 6),
                  if (_pregEdd != null)
                    _infoRow(
                      label: 'Prediksi melahirkan',
                      date: _pregEdd!,
                      icon: Icons.cake,
                      color: kPrimaryColor,
                    ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ),
        // Display gestational age when LMP is available
        if (_pregLmp != null) ...[
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            // Add padding inside the container
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: tPrimaryColor, // Set a background color
              boxShadow: [
                BoxShadow(
                  color: tPrimaryColor.withValues(alpha: 0.3),
                  // Shadow with some transparency
                  blurRadius: 6,
                  // Soft shadow
                  spreadRadius: 1,
                  // Small spread
                  offset: const Offset(0, 5), // Slight offset for the shadow
                ),
              ],
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
                Divider(color: kWhiteColor, thickness: 1),
                Text(
                  _calculateGestationalAge(_selectedDay!),
                  style: whiteTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign:
                      TextAlign.center, // Center the text inside the container
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
