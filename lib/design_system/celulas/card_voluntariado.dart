import 'package:aplicaciones_multiplataforma/design_system/molecules/vacantes.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/maps_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class CardVoluntariado extends StatefulWidget {

  final Voluntariado voluntariado;

  CardVoluntariado({
    Key? key,
    required this.voluntariado
  }) : super(key: key);

  @override
  State<CardVoluntariado> createState() => _CardVoluntariadoState();
}

class _CardVoluntariadoState extends State<CardVoluntariado> {

  final MapService _mapService = MapService();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  late bool favorito;

  @override
  Widget build(BuildContext context) {
    favorito = widget.voluntariado.favorito;
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.sombra2,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {
                context.goNamed(
                  'voluntariados',
                  pathParameters: {
                    'tabId': '0',
                    'voluntariadoId': widget.voluntariado.id
                  }
                )
              },
              child: SizedBox(
                height: 138,
                width: double.infinity,
                child: FittedBox(
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                    "assets/images/1109 techo 500.jpeg",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 18, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.voluntariado.tipoDeVoluntariado,
                        style: MyTheme.overline(color: AppColors.neutralGrey75),
                      ),
                      Text(
                        widget.voluntariado.titulo,
                        style: MyTheme.subtitle01(),
                      ),
                      Vacantes(vacantes: widget.voluntariado.vacantes,)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          widget.voluntariado.favorito = !widget.voluntariado.favorito;
                          await _userService.changeFavouriteInVoluntariado(
                            voluntariadoId: widget.voluntariado.id,
                            userId: _authService.currentUser!.id,
                            changeTo: widget.voluntariado.favorito
                          );
                          setState(() {
                            favorito = widget.voluntariado.favorito;
                          });
                        },
                        icon: favorito ? MyIcons.favoriteActivated : MyIcons.favoriteOutlineActivated
                      ),
                      const SizedBox(width: 16,),
                      GestureDetector(
                        onTap: () => _mapService.openGoogleMaps(widget.voluntariado.ubicacion.latitude, widget.voluntariado.ubicacion.longitude),
                        child: MyIcons.locationOnActivated
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}