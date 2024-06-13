import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:flutter/material.dart';

class IdDivider extends StatefulWidget {
  const IdDivider({super.key});

  @override
  State<IdDivider> createState() => _IdDividerState();
}

class _IdDividerState extends State<IdDivider> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Row(
      children: [
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 1,
            height: 10,
            color: IdColors.gray,
          ),
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
      ],
    );
    return wg1;
  }
}
