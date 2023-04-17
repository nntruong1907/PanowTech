import 'package:flutter/material.dart';

import 'package:panow_tech/ui/control_screen.dart';

class SearchRecent extends StatelessWidget {
  const SearchRecent({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> searchList = [
      "Keyboard",
      "logitech 650",
      "Gaming mouse",
      "Keychron K8 Pro"
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: const [
              Text(
                'Recent search',
                style: TextStyle(
                    fontFamily: 'SFCompactRounded',
                    color: black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Spacer(),
              Text(
                'See all',
                style: TextStyle(
                  fontFamily: 'SFCompactRounded',
                  color: primaryCorlor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
          child: searchListView(searchList),
        ),
      ],
    );
  }

  Widget searchListView(List pairsList) {
    return ListView.builder(
      itemCount: pairsList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 25, right: 20),
          title: Row(
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 10),
              Text(
                pairsList[i],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () {},
              )
            ],
          ),
          onTap: () {},
        );
      },
    );
  }
}
