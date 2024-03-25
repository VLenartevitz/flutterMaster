import 'package:flutter/material.dart';

class ProfileItemRow extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function() onTop;

  const ProfileItemRow({
    required this.name,
    required this.icon,
    required this.onTop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTop,
          leading: Icon(icon),
          title: Text(name, style: const TextStyle(
            fontWeight: FontWeight.bold
          ),),
          visualDensity: const VisualDensity(vertical: 3),
          trailing: const Icon(Icons.arrow_right_alt_sharp),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
