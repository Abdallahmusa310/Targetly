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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Color(0xFF7F73E6),
                    onPrimary: Colors.white,
                    surface: Color(0xFF1A1A2E),
                    onSurface: Colors.white,
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF7F73E6),
                    onPrimary: Colors.white,
                    onSurface: Color(0xff2B1E5E),
                  ),
                ),
          child: child!,
        );
      },
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "target period".tr(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark
                ? Colors.white
                : const Color.fromARGB(255, 39, 39, 70),
          ),
        ),

        const SizedBox(height: 8),

        InkWell(
          onTap: _pickDateRange,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white24 : const Color(0xFF5B5F97),
              ),
              color: isDark ? const Color(0xFF1A1A2E) : const Color(0xffF3F3FC),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: isDark ? Colors.white54 : const Color(0xFF5B5F97),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${_format(startDate)}  →  ${_format(endDate)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : const Color(0xff2B1E5E),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: isDark ? Colors.white54 : const Color(0xff2B1E5E),
                ),
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
