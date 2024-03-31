import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/widgets/widgets/styles/common_styles.dart';
import 'package:favorite_places/widgets/screens/place_details.dart';

class FavPlacesList extends ConsumerWidget {
  const FavPlacesList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favPlaces = ref.watch(favPlacesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      child: ListView.builder(
          itemCount: favPlaces.length,
          itemBuilder: (ctx, index) {
            return ListTile(
              minVerticalPadding: 24.0,
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: FileImage(
                  favPlaces[index].placeImage,
                ),
              ),
              title: Text(
                favPlaces[index].title,
                style: cmnLetterSpacing.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PlaceDetailsScreen(
                      place: favPlaces[index],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
