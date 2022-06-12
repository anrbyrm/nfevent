import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: circleDiameter,
          width: circleDiameter,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ghostWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(iconPadding),
            child: SvgPicture.asset(
              getIconPath('etherium'),
              color: purple,
            ),
          ),
        ),
        const SizedBox(width: horizontalPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              '5.343 ETH',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              'Balance',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: lightGray,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: circleDiameter,
          width: circleDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: gray),
          ),
          child: Padding(
            padding: const EdgeInsets.all(iconPadding * 1.1),
            child: SvgPicture.asset(getIconPath('bell')),
          ),
        ),
      ],
    );
  }
}
