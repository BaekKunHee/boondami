import 'package:flutter/material.dart';
import 'package:jobmoim/enums/view_mode.dart';

class ToggleButton extends StatefulWidget {
  final ViewMode viewMode;
  final Function(ViewMode) onViewModeChanged;

  const ToggleButton({
    super.key,
    required this.viewMode,
    required this.onViewModeChanged,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [
        widget.viewMode == ViewMode.daily,
        widget.viewMode == ViewMode.monthly,
      ],
      onPressed: (int index) {
        setState(() {
          widget.onViewModeChanged(
              index == 0 ? ViewMode.daily : ViewMode.monthly);
        });
      },
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('일'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('월'),
        ),
      ],
    );
  }
}
