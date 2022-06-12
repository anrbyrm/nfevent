import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:nfevent/constants.dart';
import 'package:nfevent/models/creator.dart';

class CreatorWidget extends StatelessWidget {
  const CreatorWidget(this.creator, {this.isFirstItem = false, Key? key})
      : super(key: key);
  final Creator? creator;
  final bool? isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isFirstItem! ? 0 : listItemPadding,
        bottom: listItemPadding,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius * 2),
            child: SizedBox(
              height: circleDiameter,
              width: circleDiameter,
              child: BlurHash(
                hash: creator!.blurHash!,
                image: creator!.image,
                imageFit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: horizontalPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                creator!.name!,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                creator!.description!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: darkGray,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: gray),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: cardPadding * 3,
                vertical: cardPadding * 1.5,
              ),
              child: Text(
                'Follow',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
