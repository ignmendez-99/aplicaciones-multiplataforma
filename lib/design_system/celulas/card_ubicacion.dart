import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:aplicaciones_multiplataforma/services/maps_service.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardUbicacion extends StatelessWidget {

  CardUbicacion({
    super.key,
    required this.titulo,
    required this.label1,
    required this.content1,
    required this.latitude,
    required this.longitude
  });

  final String titulo;
  final String label1;
  final String content1;
  final MapService _mapService = MapService();
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          color: AppColors.secondaryBlue25,
          child: Row(
            children: [
              Text(
                titulo,
                style: MyTheme.subtitle01(),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: AppColors.neutralGrey10,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label1,
                    style: MyTheme.overline(color: AppColors.neutralGrey75),
                  ),
                  Text(
                    content1,
                    style: MyTheme.body01(),
                  ),
                ]
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () => _mapService.openGoogleMaps(latitude, longitude),
                  child: MyIcons.locationOnActivated
              ),
            ],
          )
        )
      ],
    );
  }
}
