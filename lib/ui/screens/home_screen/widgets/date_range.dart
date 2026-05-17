import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeField extends StatefulWidget {
  const DateRangeField({
    super.key,
    required this.onChanged,
    this.initialStart,
    this.initialEnd,
  });

  final Function(DateTime start, DateTime end) onChanged;
  final DateTime? initialStart;
  final DateTime? initialEnd;

  @override
  State<DateRangeField> createState() => _DateRangeFieldState();
}

class _DateRangeFieldState extends State<DateRangeField> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.initialStart;
    endDate = widget.initialEnd;
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });

      widget.onChanged(startDate!, endDate!);
    }
  }

  String _format(DateTime? date) {
    if (date == null) return "select_date".tr();
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "target period".tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 8),

        InkWell(
          onTap: _pickDateRange,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              border: Border.all(color: const Color(0xFF5B5F97)),

              color: const Color(0xffF3F3FC),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    const Icon(Icons.date_range, color: Color(0xFF5B5F97)),

                    const SizedBox(width: 10),

                    Text(
                      "${_format(startDate)}  →  ${_format(endDate)}",

                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),

        if (startDate == null || endDate == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),

            child: Text(
              "please_select_date_range".tr(),

              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
