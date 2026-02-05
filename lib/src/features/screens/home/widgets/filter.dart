import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late DateTime? _startDate;
  late DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDateRangePicker(context);
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: tPrimaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.filter_alt_rounded,
          size: 24,
          color: tPrimaryColor,
        ),
      ),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: tPrimaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _showConfirmationDialog(context);
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Date Range Selected'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Start Date: $_startDate'),
                Text('End Date: $_endDate'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
