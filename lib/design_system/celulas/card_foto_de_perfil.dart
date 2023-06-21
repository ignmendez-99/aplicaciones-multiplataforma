import 'dart:io';

import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardFotoDePerfil extends StatefulWidget {
  const CardFotoDePerfil({
    super.key,
    this.onChanged,
    this.initialPictureDownloadUrl,
  });

  final String? initialPictureDownloadUrl;
  final void Function(File)? onChanged;

  @override
  State<CardFotoDePerfil> createState() => _CardFotoDePerfilState();
}

class _CardFotoDePerfilState extends State<CardFotoDePerfil> {
  File? _selectedImage;

  Future<void> _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      widget.onChanged!(File(image.path));
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryBlue25,
      child: _selectedImage != null || widget.initialPictureDownloadUrl != null ?
          withImage()
          : withoutImage(),
    );
  }

  Widget withImage() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.profilePhoto,
                style: MyTheme.subtitle01(),
              ),
              ShortButtonChico(
                onPressed: _openGallery,
                content: Container(
                  margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Text(
                    AppLocalizations.of(context)!.changePhoto,
                    style: MyTheme.button(color: AppColors.neutralWhite),
                  ),
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 8, 19, 8),
          child: _selectedImage != null ?
              ProfilePictureSmall(file: _selectedImage)
              :
              ProfilePictureSmall(profilePictureDownloadUrl: widget.initialPictureDownloadUrl,)
        ),
      ],
    );
  }

  Widget withoutImage() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 14, 0, 14),
          child: Text(
            AppLocalizations.of(context)!.profilePhoto,
            style: MyTheme.subtitle01(),
          ),
        ),
        const Spacer(),
        ShortButtonChico(
          onPressed: _openGallery,
          content: Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Text(
              AppLocalizations.of(context)!.uploadPicture,
              style: MyTheme.button(color: AppColors.neutralWhite),
            ),
          ),
        )
      ],
    );
  }
}
