import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final Icon icon;
  final Text text;
  final Icon iconButton;

  CustomRow(this.icon, this.text, this.iconButton);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              icon,
              const SizedBox(
                width: 20,
              ),
              text,
              const Spacer(),
              iconButton,
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
