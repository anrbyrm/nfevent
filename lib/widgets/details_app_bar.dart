import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: circleDiameter,
          width: circleDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: gray.withOpacity(.3),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(iconPadding * 1.1),
                child: SvgPicture.asset(
                  getIconPath('left'),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Container(
              height: circleDiameter,
              width: circleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gray.withOpacity(.3),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(iconPadding * 1.1),
                    child: SvgPicture.asset(
                      getIconPath('edit'),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: horizontalPadding / 2),
            Container(
              height: circleDiameter,
              width: circleDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: gray.withOpacity(.3),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(iconPadding * 1.1),
                    child: SvgPicture.asset(
                      getIconPath('remove'),
                      color: red,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
