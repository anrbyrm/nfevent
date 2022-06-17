import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';
import 'package:nfevent/models/creator.dart';
import 'package:nfevent/models/event.dart';
import 'package:nfevent/pages/details.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(this.event, this.users, this.offset, {Key? key})
      : super(key: key);

  final EventModel? event;
  final List<Creator> users;
  final ValueNotifier<double>? offset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailsPage(event, users)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: gray,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      event!.image!,
                      height: MediaQuery.of(context).size.height * .35,
                      alignment: Alignment(-(offset!.value / 1000).abs(), 0),
                      fit: BoxFit.none,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.6, 0.95],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: verticalPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * .8) -
                        cardPadding * 7,
                    child: Text(
                      event!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        getIconPath('star'),
                        color: yellow,
                        height: 15,
                      ),
                      const SizedBox(width: itemHorizontalPadding),
                      Text(
                        event!.rating!.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: verticalPadding / 2),
              Text(
                '${DateFormat('dd.MM.yyyy').format(DateTime.parse(event!.date!))}, ${DateFormat('hh:mm a').format(DateTime.parse(event!.date!))} • ${event!.eventType}',
                style: const TextStyle(color: lightGray),
              ),
              const SizedBox(height: verticalPadding),
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(cardPadding),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            getIconPath('etherium'),
                            height: 14,
                            color: scaffoldColor,
                          ),
                          const SizedBox(width: itemHorizontalPadding),
                          Text(
                            '${event!.price.toString()} ETH',
                            style: const TextStyle(
                              color: scaffoldColor,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: itemHorizontalPadding),
                  Container(
                    decoration: BoxDecoration(
                      color: gray,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(cardPadding),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            getIconPath('group'),
                            height: 14,
                            color: darkGray,
                          ),
                          const SizedBox(width: itemHorizontalPadding),
                          Text(
                            event!.participants.toString(),
                            style: const TextStyle(color: darkGray),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: verticalPadding),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
    required this.bgImageKey,
  }) : super(repaint: scrollable!.position);

  final ScrollableState? scrollable;
  final BuildContext? itemContext;
  final GlobalKey? bgImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(height: constraints.maxHeight);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable!.context.findRenderObject() as RenderBox?;

    final listItemBox = itemContext!.findRenderObject() as RenderBox?;
    final listItemOffset = listItemBox!.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    final viewportDimension = scrollable!.position.viewportDimension;
    final scrollFraction = (listItemOffset.dx / viewportDimension).clamp(0, 1);

    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);

    final backgroundSize =
        (bgImageKey!.currentContext!.findRenderObject() as RenderBox?)!.size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0, childRect.left)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant ParallaxFlowDelegate oldDelegate) =>
      scrollable != oldDelegate.scrollable ||
      itemContext != oldDelegate.itemContext ||
      bgImageKey != oldDelegate.bgImageKey;
}
