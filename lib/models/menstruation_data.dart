import 'menstruasi_period.dart';

class MenstruationData {
  DateTime selectedDay;
  List<DateTime> lastPeriodDays; // Hapus 'final' di sini
  List<DateTime> fertileDays;    // Hapus 'final' di sini
  List<DateTime> nextPeriodDays; // Hapus 'final' di sini
  List<MenstruationPeriod> allPeriods;
  int? periodLength;
  DateTime? lastPeriodDate;

  MenstruationData({
    required this.lastPeriodDays,
    required this.fertileDays,
    required this.nextPeriodDays,
    required this.selectedDay,
    this.periodLength,
    this.lastPeriodDate,
    required this.allPeriods,
  });
}