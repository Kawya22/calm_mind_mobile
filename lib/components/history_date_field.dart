import 'package:flutter/material.dart';

class HistoryDateField extends StatelessWidget {
  final String label;
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime? selectedDate)? onDateChanged;

  const HistoryDateField({
    super.key,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    this.label = "",
    this.onDateChanged,
  });

  void _onTap(BuildContext context) async {
    if (onDateChanged == null) return;

    final userSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    onDateChanged!(userSelectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20,
        children: [
          Text(label),
          TextField(
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              fillColor: Color(0xFFC8B5FF),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
            controller: TextEditingController(
              text:
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),
            onTap: () => _onTap(context),
          ),
        ],
      ),
    );
  }
}
