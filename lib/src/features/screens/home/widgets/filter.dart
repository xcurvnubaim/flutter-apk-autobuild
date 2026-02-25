import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:welangflood/src/constants/color.dart';

class FilterButton extends StatelessWidget {
  final void Function(String? start, String? end) onFilterChanged;

  const FilterButton({Key? key, required this.onFilterChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDateRangePicker(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: tPrimaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.filter_alt_rounded, size: 24, color: tPrimaryColor),
      ),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: tPrimaryColor),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      final fmt = DateFormat('yyyy-MM-dd');
      onFilterChanged(fmt.format(picked.start), fmt.format(picked.end));
    }
  }
}