import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';

const double holeSize = 80;

class CustomNavigationBar extends HookWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  Widget middleButton() {
    return Transform.translate(
      offset: const Offset(0, -23),
      child: Container(
        height: holeSize * .9,
        width: holeSize * .9,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(iconPadding * 1.7),
          child: SvgPicture.asset(
            getIconPath('add'),
            color: white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);

    return Transform.translate(
      offset: const Offset(0, -10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        padding: const EdgeInsets.symmetric(vertical: bottomBarPadding / 5) +
            const EdgeInsets.symmetric(horizontal: bottomBarPadding * 3),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: const CustomBorderShape(),
          shadows: [
            BoxShadow(
              color: black.withOpacity(.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              index: 0,
              path: 'home',
              selectedIndex: selectedIndex,
              selectedPath: 'home_filled',
            ),
            IconButton(
              index: 1,
              path: 'person',
              selectedIndex: selectedIndex,
              selectedPath: 'person_filled',
            ),
            middleButton(),
            IconButton(
              index: 2,
              path: 'wallet',
              selectedIndex: selectedIndex,
              selectedPath: 'wallet_filled',
            ),
            IconButton(
              index: 3,
              path: 'settings',
              selectedIndex: selectedIndex,
              selectedPath: 'settings_filled',
            ),
          ],
        ),
      ),
    );
  }
}

class IconButton extends HookWidget {
  const IconButton({
    this.path,
    this.index,
    this.selectedIndex,
    this.selectedPath,
    Key? key,
  }) : super(key: key);

  final String? path;
  final String? selectedPath;
  final int? index;
  final ValueNotifier<int>? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final color = selectedIndex!.value == index ? black : darkGray;

    return GestureDetector(
      onTap: () => selectedIndex!.value = index!,
      child: SizedBox(
        height: 30,
        child: Column(
          children: <Widget>[
            SvgPicture.asset(
              getIconPath(selectedIndex!.value == index ? selectedPath : path),
              color: color,
              height: 25,
            ),
            const SizedBox(height: 2),
            if (selectedIndex!.value == index)
              Container(
                height: 3,
                width: 3,
                decoration: const BoxDecoration(
                  color: black,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class CustomBorderShape extends ShapeBorder {
  const CustomBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)),
        )
        ..close(),
      Path()
        ..addOval(
          Rect.fromCenter(
            center: rect.center.translate(0, -rect.height / 3.5),
            width: holeSize,
            height: holeSize,
          ),
        ),
    )..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
