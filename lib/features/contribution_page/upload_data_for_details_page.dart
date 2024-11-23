import 'package:flutter/material.dart';

import '../../common/custom_text_form_field.dart';

class UploadDataForDetailsPage extends StatelessWidget {
  final GlobalKey<FormState> globalKey;
  final Function(
    String? location,
    String? state,
    String? country,
    String? imageUrl,
  ) onSaved;

  UploadDataForDetailsPage({
    super.key,
    required this.globalKey,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    String? location;
    String? state;
    String? country;
    String? imageUrl;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                labelText: 'Location',
                prefixIcon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onSaved: (value) => location = value,
              ),
              SizedBox(height: 8),
              CustomTextFormField(
                labelText: 'State',
                prefixIcon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a state';
                  }
                  return null;
                },
                onSaved: (value) => state = value,
              ),
              SizedBox(height: 8),
              CustomTextFormField(
                labelText: 'Country',
                prefixIcon: Icons.public,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
                onSaved: (value) => country = value,
              ),
              SizedBox(height: 8),
              CustomTextFormField(
                labelText: 'Image URL',
                prefixIcon: Icons.image,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Your Image';
                  }
                  return null;
                },
                onSaved: (value) => imageUrl = value,
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    onSaved(location, state, country, imageUrl);
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
