import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  PlaceModel({
    required this.title,
    required this.placeImage,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File placeImage;
}
