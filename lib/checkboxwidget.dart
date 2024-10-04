import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final String task;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CheckboxWidget({
    super.key,
    required this.task,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(
          task,
          style: TextStyle(
            fontSize: 18,
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}
