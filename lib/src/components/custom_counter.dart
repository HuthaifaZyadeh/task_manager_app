import 'package:flutter/material.dart';

import '../themes/app_colors.dart';
import 'app_text.dart';

class CustomCounter extends StatefulWidget {
  const CustomCounter({
    super.key,
    required this.onMinus,
    required this.onPlus,
    this.defaultValue = 1,
    this.minValue = 0,
    this.maxValue = 9,
  });

  final void Function(int) onPlus;
  final void Function(int) onMinus;
  final int defaultValue;
  final int minValue;
  final int maxValue;

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  @override
  initState() {
    counter = widget.defaultValue;
    super.initState();
  }

  late int counter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: counter == widget.minValue
              ? null
              : () {
                  setState(() {
                    counter--;
                  });
                  widget.onMinus(counter);
                },
          icon: Icon(
            counter == widget.minValue
                ? Icons.remove_circle_outline
                : Icons.remove_circle,
            color: AppColors.primary,
          ),
        ),
        AppText(text: '$counter'),
        IconButton(
          onPressed: counter == widget.maxValue
              ? null
              : () {
                  setState(() {
                    counter++;
                  });
                  widget.onPlus(counter);
                },
          icon: Icon(
            counter == widget.maxValue
                ? Icons.add_circle_outline_outlined
                : Icons.add_circle_rounded,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
