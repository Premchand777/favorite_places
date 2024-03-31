import 'package:flutter/material.dart';

import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/widgets/widgets/styles/common_styles.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${place.title} details',
          style: cmnLetterSpacing.copyWith(
            color: Colors.white70,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            place.placeImage,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
