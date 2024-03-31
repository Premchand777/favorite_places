import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/widgets/widgets/styles/common_styles.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/providers/fav_places_provider.dart';
import 'package:favorite_places/widgets/widgets/image_input.dart';

class AddFavPlaceScreen extends ConsumerStatefulWidget {
  const AddFavPlaceScreen({
    super.key,
  });

  @override
  ConsumerState<AddFavPlaceScreen> createState() => _AddFavPlaceScreenState();

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a place name';
    }
    if (value.length < 3) {
      return 'Please enter at least 3 characters';
    }
    if (int.tryParse(value) != null || double.tryParse(value) != null) {
      return 'Please enter a valid place name';
    }
    RegExp regex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!regex.hasMatch(value)) {
      return 'Place name should not contain special characters';
    }
    return null;
  }
}

class _AddFavPlaceScreenState extends ConsumerState<AddFavPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _placeName = '';
  File? _selectedImg;

  void _saveNewPlace() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      Timer(
        const Duration(
          milliseconds: 650,
        ),
        () {
          final isAdded = ref.read(favPlacesProvider.notifier).addNewPlace(
              PlaceModel(title: _placeName, placeImage: _selectedImg!));
          if (!isAdded) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                actions: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    child: const Text(
                      'OK',
                    ),
                  ),
                ],
                content: Text(
                  'Place already exists in favorites!',
                  style: cmnLetterSpacing.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            );
            return;
          }
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Place added to favorites!',
              ),
              duration: Durations.extralong1,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          Timer(
            const Duration(
              milliseconds: 400,
            ),
            () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Place',
            style: cmnLetterSpacing.copyWith(color: Colors.white70),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white70,
          ),
        ),
        body: _isLoading
            ? const LinearProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Place Name',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: Colors.white70,
                                  letterSpacing: cmnLetterSpacing.letterSpacing,
                                ),
                          ),
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          maxLength: 50,
                          validator: (value) {
                            return widget.titleValidator(value);
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onSaved: (value) {
                            _placeName = value!.trim();
                          },
                        ),
                        const SizedBox(height: 16),
                        ImageInput(
                          onImageSelected: (image) {
                            _selectedImg = image;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _saveNewPlace,
                          icon: const Icon(
                            Icons.add,
                          ),
                          label: Text(
                            'Add',
                            style: cmnLetterSpacing.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(2.0),
                            shadowColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
