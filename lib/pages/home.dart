import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/helpers.dart';
import 'package:nfevent/models/creator.dart';
import 'package:nfevent/models/event.dart';
import 'package:nfevent/widgets/card.dart';
import 'package:nfevent/widgets/creator_widget.dart';
import 'package:nfevent/widgets/home_app_bar.dart';
import 'package:nfevent/widgets/navigation_bar.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<EventModel>> getEvents() async {
      final json = await rootBundle.loadString(getJsonPath('events'));

      return (jsonDecode(json) as List<dynamic>)
          .map((e) => EventModel.fromJson(e as Map<dynamic, dynamic>))
          .toList();
    }

    Future<List<CreatorModel>> getCreators() async {
      final json = await rootBundle.loadString(getJsonPath('creators'));

      return (jsonDecode(json) as List<dynamic>)
          .map((e) => CreatorModel.fromJson(e as Map<dynamic, dynamic>))
          .toList();
    }

    final eventsFuture = useMemoized(getEvents);
    final events = useFuture(eventsFuture);

    final creatorsFuture = useMemoized(getCreators);
    final creators = useFuture(creatorsFuture);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
            ) +
            EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + verticalPadding,
            ),
        child: Column(
          children: <Widget>[
            const HomeAppBar(),
            const SizedBox(height: verticalPadding),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: verticalPadding,
                  bottom: 100,
                ),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'My Events'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: verticalPadding),
                    if (events.connectionState == ConnectionState.waiting)
                      const Center(
                        child: CircularProgressIndicator(
                          color: accentColor,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            events.data!.length,
                            (index) => Row(
                              children: [
                                CardWidget(events.data![index], creators.data!),
                                if (index == events.data!.length - 1)
                                  const SizedBox.square(dimension: 0)
                                else
                                  const SizedBox(width: horizontalPadding),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: verticalPadding * 2),
                    Text(
                      'Creators'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: verticalPadding),
                    if (creators.connectionState == ConnectionState.waiting)
                      const Center(
                        child: CircularProgressIndicator(
                          color: accentColor,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: creators.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => CreatorWidget(
                          creators.data![index],
                          isFirstItem: index == 0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
