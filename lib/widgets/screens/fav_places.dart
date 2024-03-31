import 'package:flutter/material.dart';

import 'package:favorite_places/widgets/widgets/fav_places_list.dart';
import 'package:favorite_places/widgets/screens/add_fav_place.dart';
import 'package:favorite_places/widgets/widgets/styles/common_styles.dart';

class FavPlacesScreen extends StatelessWidget {
  const FavPlacesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Favorite Places',
          style: cmnLetterSpacing.copyWith(
            color: Colors.white70,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_location_alt_rounded,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return const AddFavPlaceScreen();
                }),
              );
            },
          ),
        ],
      ),
      body: const FavPlacesList(),
    );
  }
}
