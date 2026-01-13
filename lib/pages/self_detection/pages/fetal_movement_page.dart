import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bumilku_app/theme/theme.dart';
import '../../../l10n/app_localizations.dart';
import '../self_detection_controller.dart';

class FetalMovementPage extends StatefulWidget {
  final SelfDetectionController controller;

  const FetalMovementPage({super.key, required this.controller});

  @override
  State<FetalMovementPage> createState() => _FetalMovementPageState();
}

class _FetalMovementPageState extends State<FetalMovementPage> {
  // Controller untuk input field
  final TextEditingController _movementCountController = TextEditingController();

  // Durasi tetap 12 jam
  final int _fixedDurationHours = 12;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupControllers();
  }

  void _initializeData() {
    final now = DateTime.now();

    widget.controller.fetalMovementDateTime ??= now;

    // default values -> pakai string default ID dulu, nanti akan di-sync ulang di build()
    if (widget.controller.movementComparison.isEmpty) {
      widget.controller.movementComparison = 'Sama saja';
    }
    if (widget.controller.fetalActivityPattern.isEmpty) {
      widget.controller.fetalActivityPattern = 'Tidak ada pola khusus';
    }

    widget.controller.fetalMovementDuration = _fixedDurationHours;
    widget.controller.fetalAdditionalComplaints =
        widget.controller.fetalAdditionalComplaints ?? <String>[];
  }

  void _setupControllers() {
    _movementCountController.text = widget.controller.fetalMovementCount > 0
        ? widget.controller.fetalMovementCount.toString()
        : '';

    _movementCountController.addListener(() {
      final count = int.tryParse(_movementCountController.text) ?? 0;
      widget.controller.fetalMovementCount = count;
      setState(() {});
    });
  }

  Future<void> _showDateTimePicker(BuildContext context) async {
    final initial = widget.controller.fetalMovementDateTime ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initial),
      );

      if (pickedTime != null && mounted) {
        setState(() {
          widget.controller.fetalMovementDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  double _getMovementsPerHour(int movementCount) => movementCount / _fixedDurationHours;

  FetalMovementStatus _calculateStatus(int movementCount) {
    if (movementCount == 0) return FetalMovementStatus.incomplete;

    const normalThreshold = 10; // >=10 normal
    const warningThreshold = 7; // 7-9 monitoring
    const dangerThreshold = 4;  // 4-6 attention
    // <4 emergency

    if (movementCount >= normalThreshold) {
      return FetalMovementStatus.normal;
    } else if (movementCount >= warningThreshold) {
      return FetalMovementStatus.monitoring;
    } else if (movementCount >= dangerThreshold) {
      return FetalMovementStatus.attention;
    } else {
      return FetalMovementStatus.emergency;
    }
  }

  String? _validateMovementCount(AppLocalizations t, String? value) {
    if (value == null || value.isEmpty) return t.fetalMoveErrorRequired;
    final count = int.tryParse(value);
    if (count == null) return t.fetalMoveErrorInvalidNumber;
    if (count < 0) return t.fetalMoveErrorNegative;
    return null;
  }

  @override
  void dispose() {
    _movementCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    // === OPTIONS BERDASARKAN LOCALE ===
    final activityPatterns = <String>[
      t.fetalPatternMorning,
      t.fetalPatternAfternoon,
      t.fetalPatternNight,
      t.fetalPatternNoPattern,
    ];

    final comparisonOptions = <String>[
      t.fetalCompareMoreActive,
      t.fetalCompareSame,
      t.fetalCompareLess,
    ];

    final complaintOptions = <String>[
      t.fetalComplaintDizzyWeak,
      t.fetalComplaintAbdominalPain,
      t.fetalComplaintNone,
    ];

    // === SYNC DEFAULT VALUE BIAR GROUPVALUE NYAMBUNG (karena sebelumnya string ID) ===
    // jika current value bukan bagian dari options locale sekarang → set default locale sekarang
    if (!activityPatterns.contains(widget.controller.fetalActivityPattern)) {
      widget.controller.fetalActivityPattern = t.fetalPatternNoPattern;
    }
    if (!comparisonOptions.contains(widget.controller.movementComparison)) {
      widget.controller.movementComparison = t.fetalCompareSame;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.fetalMoveTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),

          _buildInfoCard(t),
          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: [
                _buildSectionTitle(t.fetalMoveMainParams),
                const SizedBox(height: 12),

                _buildDateTimeField(t, locale),
                const SizedBox(height: 16),

                _buildMovementCountField(t),
                const SizedBox(height: 16),

                _buildDurationInfo(t),
                const SizedBox(height: 16),

                _buildActivityPatternField(t, activityPatterns),
                const SizedBox(height: 20),

                _buildSectionTitle(t.fetalMoveMotherSubjective),
                const SizedBox(height: 12),

                _buildMovementComparisonField(t, comparisonOptions),
                const SizedBox(height: 16),

                _buildAdditionalComplaintsField(t, complaintOptions),
                const SizedBox(height: 20),

                _buildSummarySection(t),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue[700], size: 16),
              const SizedBox(width: 8),
              Text(
                t.fetalMoveImportantInfoTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            t.fetalMoveImportantInfoDesc(_fixedDurationHours),
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: tPrimaryColor,
      ),
    );
  }

  Widget _buildDateTimeField(AppLocalizations t, Locale locale) {
    final dt = widget.controller.fetalMovementDateTime;

    // Format sesuai locale
    final df = DateFormat('d MMM y, HH:mm', locale.toLanguageTag());

    final displayText = dt != null ? df.format(dt) : t.fetalMovePickDateTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.fetalMoveStartDateTimeLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  displayText,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: dt != null ? Colors.black : Colors.grey[400],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: tPrimaryColor),
                onPressed: () => _showDateTimePicker(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMovementCountField(AppLocalizations t) {
    final hasError = _validateMovementCount(t, _movementCountController.text) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.fetalMoveCountLabel(_fixedDurationHours),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError ? Colors.red : Colors.grey[300]!,
              width: hasError ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _movementCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: t.fetalMoveCountHint(_fixedDurationHours),
                    hintStyle: const TextStyle(fontSize: 12),
                    errorStyle: const TextStyle(height: 0),
                  ),
                ),
              ),
              Text(
                t.fetalMoveTimesSuffix,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            _validateMovementCount(t, _movementCountController.text)!,
            style: const TextStyle(fontSize: 10, color: Colors.red),
          ),
        ] else ...[
          const SizedBox(height: 4),
          Text(
            t.fetalMoveTargetHint,
            style: TextStyle(fontSize: 10, color: Colors.grey[500]),
          ),
        ],
      ],
    );
  }

  Widget _buildDurationInfo(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: Colors.green[700], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.fetalMoveDurationInfo(_fixedDurationHours),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityPatternField(AppLocalizations t, List<String> patterns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.fetalMoveActivityPatternLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ...patterns.map(
              (pattern) => RadioListTile<String>(
            title: Text(pattern, style: const TextStyle(fontSize: 12)),
            value: pattern,
            groupValue: widget.controller.fetalActivityPattern,
            onChanged: (value) {
              if (value == null) return;
              setState(() => widget.controller.fetalActivityPattern = value);
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMovementComparisonField(AppLocalizations t, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.fetalMoveComparisonLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ...options.map(
              (option) => RadioListTile<String>(
            title: Text(option, style: const TextStyle(fontSize: 12)),
            value: option,
            groupValue: widget.controller.movementComparison,
            onChanged: (value) {
              if (value == null) return;
              setState(() => widget.controller.movementComparison = value);
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalComplaintsField(AppLocalizations t, List<String> options) {
    final selected = widget.controller.fetalAdditionalComplaints;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.fetalMoveOtherComplaintsLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ...options.map(
              (complaint) => CheckboxListTile(
            title: Text(complaint, style: const TextStyle(fontSize: 12)),
            value: selected.contains(complaint),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  widget.controller.fetalAdditionalComplaints = [...selected, complaint];
                } else {
                  widget.controller.fetalAdditionalComplaints =
                      selected.where((x) => x != complaint).toList();
                }
              });
            },
            contentPadding: EdgeInsets.zero,
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(AppLocalizations t) {
    final movementCount = widget.controller.fetalMovementCount;
    final hasData = movementCount > 0;

    final status = _calculateStatus(movementCount);
    final mph = _getMovementsPerHour(movementCount);

    if (!hasData) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          t.fetalMoveSummaryEmpty,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: status.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(status.icon, color: status.color, size: 16),
              const SizedBox(width: 8),
              Text(
                status.titleText(t),
                style: TextStyle(fontWeight: FontWeight.bold, color: status.color),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Text(
            t.fetalMoveSummaryMoves(movementCount, _fixedDurationHours, mph),
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 6),

          Text(
            status.getMessage(t, movementCount, _fixedDurationHours, mph),
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),

          Text(
            t.fetalMoveSummaryDetailTitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(t.fetalMoveSummaryDetailCount(movementCount), style: const TextStyle(fontSize: 11)),
          Text(t.fetalMoveSummaryDetailDuration(_fixedDurationHours), style: const TextStyle(fontSize: 11)),
          Text(t.fetalMoveSummaryDetailTarget, style: const TextStyle(fontSize: 11)),
          Text(t.fetalMoveSummaryDetailPattern(widget.controller.fetalActivityPattern), style: const TextStyle(fontSize: 11)),
          Text(t.fetalMoveSummaryDetailCompare(widget.controller.movementComparison), style: const TextStyle(fontSize: 11)),
          if (widget.controller.fetalAdditionalComplaints.isNotEmpty)
            Text(
              t.fetalMoveSummaryDetailComplaints(widget.controller.fetalAdditionalComplaints.join(', ')),
              style: const TextStyle(fontSize: 11),
            ),
        ],
      ),
    );
  }
}

// ENUM STATUS
enum FetalMovementStatus {
  incomplete(Colors.grey, Icons.hourglass_empty),
  normal(Colors.green, Icons.check_circle),
  monitoring(Colors.blue, Icons.timelapse),
  attention(Colors.orange, Icons.info),
  emergency(Colors.red, Icons.warning);

  const FetalMovementStatus(this.color, this.icon);
  final Color color;
  final IconData icon;

  String titleText(AppLocalizations t) {
    switch (this) {
      case FetalMovementStatus.incomplete:
        return t.fetalStatusIncomplete;
      case FetalMovementStatus.normal:
        return t.fetalStatusNormal;
      case FetalMovementStatus.monitoring:
        return t.fetalStatusMonitoring;
      case FetalMovementStatus.attention:
        return t.fetalStatusAttention;
      case FetalMovementStatus.emergency:
        return t.fetalStatusEmergency;
    }
  }

  String getMessage(AppLocalizations t, int movementCount, int durationHours, double mph) {
    switch (this) {
      case FetalMovementStatus.normal:
        return t.fetalMsgNormal(movementCount, durationHours);
      case FetalMovementStatus.monitoring:
        return t.fetalMsgMonitoring(movementCount, durationHours);
      case FetalMovementStatus.attention:
        return t.fetalMsgAttention(movementCount, durationHours);
      case FetalMovementStatus.emergency:
        return t.fetalMsgEmergency(movementCount, durationHours);
      case FetalMovementStatus.incomplete:
        return t.fetalMsgIncomplete;
    }
  }
}
