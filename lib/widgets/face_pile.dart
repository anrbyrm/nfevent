import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/models/creator.dart';

class FacePileWidget extends HookWidget {
  const FacePileWidget(this.users, {Key? key}) : super(key: key);

  final List<Creator> users;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 130),
      child: FacePile(
        users: users,
      ),
    );
  }
}

class FacePile extends HookWidget {
  const FacePile({
    required this.users,
    this.faceSize = 48,
    this.facePercentOverlap = .2,
    Key? key,
  }) : super(key: key);

  final List<Creator> users;
  final double? faceSize;
  final double? facePercentOverlap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final usersCount = users.length;

        var facePercentVisible = 1 - facePercentOverlap!;

        final maxIntrinsicWidth = usersCount > 1
            ? (1 + (facePercentVisible * (usersCount - 1))) * faceSize!
            : faceSize!;

        late double rightOffset;
        if (maxIntrinsicWidth > constraints.maxWidth) {
          rightOffset = 0;
          facePercentVisible =
              ((constraints.maxWidth / faceSize!) - 1) / (usersCount - 1);
        } else {
          rightOffset = (constraints.maxWidth - maxIntrinsicWidth) / 2;
        }

        if (constraints.maxWidth < faceSize!) {
          return const SizedBox();
        }

        return SizedBox(
          height: faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              for (int i = 0; i < usersCount; i += 1)
                AnimatedPositioned(
                  key: ValueKey(users[i].name),
                  top: 0,
                  height: faceSize,
                  right: rightOffset + (i * facePercentVisible * faceSize!),
                  width: faceSize,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: AppearingFace(
                    user: users[users.length - i - 1],
                    faceSize: faceSize,
                    index: i,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class AppearingFace extends HookWidget {
  const AppearingFace({this.user, this.faceSize, this.index, Key? key})
      : super(key: key);

  final Creator? user;
  final double? faceSize;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: Duration(milliseconds: 500 * index!));
    final animation =
        Tween<double>(begin: 0, end: 1).animate(animationController);

    animationController.forward();

    return SizedBox(
      width: faceSize,
      height: faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Transform.scale(
            scale: animation.value,
            child: AvatarCircle(
              user: user,
              size: faceSize,
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarCircle extends HookWidget {
  const AvatarCircle({this.user, this.size = 48, Key? key}) : super(key: key);

  final Creator? user;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          Center(
            child: BlurHash(
              hash: user!.blurHash!,
              image: user!.image,
              imageFit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
