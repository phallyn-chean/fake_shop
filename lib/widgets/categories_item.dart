import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRadioListTile<T> extends StatelessWidget {
  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.leading,
    required this.onChanged,
  });

  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: [
          _customRadioButton,
        ],
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff0F172A) : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        leading,
        style: GoogleFonts.ubuntuMono(
          color: isSelected ? Colors.white : const Color(0xff0F172A),
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
