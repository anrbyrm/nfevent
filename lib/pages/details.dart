import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';
import 'package:nfevent/models/creator.dart';
import 'package:nfevent/models/event.dart';
import 'package:nfevent/widgets/details_app_bar.dart';
import 'package:nfevent/widgets/face_pile.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.event, this.users, {Key? key}) : super(key: key);

  final Event? event;
  final List<Creator> users;

  @override
  Widget build(BuildContext context) {
    final stackHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: stackHeight,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: BlurHash(
                    hash: event!.blurHash!,
                    imageFit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: MediaQuery.of(context).viewPadding.top + verticalPadding,
                  child: const DetailsAppBar(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: SizedBox(
                        height: stackHeight -
                            (MediaQuery.of(context).viewPadding.top +
                                verticalPadding * 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: BlurHash(
                            hash: event!.blurHash!,
                            image: event!.image,
                            imageFit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: verticalPadding) +
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event!.name!,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: verticalPadding / 2),
                    Text(
                      event!.description!,
                      style: const TextStyle(
                        fontSize: 14.5,
                        color: darkGray,
                      ),
                    ),
                    const SizedBox(height: verticalPadding),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(getIconPath('calendar')),
                        const SizedBox(width: horizontalPadding / 2),
                        Text(
                          '${DateFormat('dd.MM.yyyy').format(DateTime.parse(event!.date!))} •  ${DateFormat('hh:mm a').format(DateTime.parse(event!.date!))}',
                        )
                      ],
                    ),
                    const SizedBox(height: verticalPadding / 2),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(getIconPath('camera')),
                        const SizedBox(width: horizontalPadding / 2),
                        Text(event!.eventType!),
                      ],
                    ),
                    const SizedBox(height: verticalPadding),
                    Container(
                      decoration: BoxDecoration(
                        color: gray,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(cardPadding * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  event!.participants!.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                const Text(
                                  'Participants',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            FacePileWidget(
                              users.take(3).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: verticalPadding / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(cardPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${event!.price.toString()} ETH',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 21,
                                    color: white,
                                  ),
                                ),
                                const Text(
                                  'Per 1 participant',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            color: gray,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(cardPadding * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  event!.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                  ),
                                ),
                                const Text(
                                  'Overall rating',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
