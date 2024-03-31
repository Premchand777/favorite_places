import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place_model.dart';

class FavPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  FavPlacesNotifier() : super([]);

  bool addNewPlace(PlaceModel newPlace) {
    if (state.any((place) => place.title == newPlace.title)) {
      return false;
    } else {
      state = [...state, newPlace];
      return true;
    }
  }
}

final favPlacesProvider =
    StateNotifierProvider<FavPlacesNotifier, List<PlaceModel>>((ref) {
  return FavPlacesNotifier();
});
