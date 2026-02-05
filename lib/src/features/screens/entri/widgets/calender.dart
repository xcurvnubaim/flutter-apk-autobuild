import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:intl/intl.dart';

class CalenderForm extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  const CalenderForm({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _CalenderFormState createState() => _CalenderFormState();
}

class _CalenderFormState extends State<CalenderForm> {
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: tPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
      widget.onDateSelected?.call(_selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width >= 375 ? 375 : screenSize.width - 30,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tanggal Survei',
            style: TextStyle(
              color: tPrimaryColor,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            height: screenSize.height * 0.055,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: tPrimaryColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      onTap: () => _selectDate(context),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: 'Pilih tanggal',
                        hintStyle: TextStyle(
                            color: tSecondaryColor
                        ),
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: const Icon(Icons.calendar_today, color: tPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

