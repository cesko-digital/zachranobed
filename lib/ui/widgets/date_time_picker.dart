import 'package:flutter/material.dart';

class ZachranObedDateTimePicker extends StatefulWidget {
  const ZachranObedDateTimePicker({
    Key? key,
    required this.text,
    required this.controller,
    this.onValidation,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final String? Function(String?)? onValidation;

  @override
  State<ZachranObedDateTimePicker> createState() => _ZachranObedDateTimePickerState();
}

class _ZachranObedDateTimePickerState extends State<ZachranObedDateTimePicker> {

  DateTime _dateTime = DateTime.now();

  Future<DateTime?> _pickDate() => showDatePicker(
    context: context,
    initialDate: _dateTime,
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(2100),
  );

  Future<TimeOfDay?> _pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: _dateTime.hour, minute: _dateTime.minute),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  Future _pickDateTime() async {
    DateTime? date = await _pickDate();
    if(date == null) return;

    TimeOfDay? time = await _pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _dateTime = dateTime;
      widget.controller.text = "${_dateTime.day}.${_dateTime.month}.${_dateTime.year} ${_dateTime.hour.toString().padLeft(2, "0")}:${_dateTime.minute.toString().padLeft(2, "0")}";
    });
  }

  final _dateTimePickerBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: Colors.black,
    ),
    borderRadius: BorderRadius.zero,
  );

  final _dateTimePickerErrorBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffd32f2f),
    )
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDateTime,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.onValidation,
        enabled: false,
        decoration: InputDecoration(
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.grey[600]),
          disabledBorder: _dateTimePickerBorder,
          errorBorder: _dateTimePickerErrorBorder,
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}
