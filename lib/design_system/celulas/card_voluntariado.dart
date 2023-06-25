import 'package:aplicaciones_multiplataforma/design_system/molecules/vacantes.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/maps_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/snackbar.dart';
import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class CardVoluntariado extends StatefulWidget {

  final Voluntariado voluntariado;

  const CardVoluntariado({
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
  bool _loadingFavorito = false;

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
                  'voluntariado',
                  pathParameters: {
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
                  child: Image.network(widget.voluntariado.pictureDownloadUrl),
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
                      _loadingFavorito ?
                          const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () async {
                                setState(() {
                                  _loadingFavorito = true;
                                });
                                widget.voluntariado.favorito = !widget.voluntariado.favorito;
                                var response = await _userService.changeFavouriteInVoluntariado(
                                  voluntariadoId: widget.voluntariado.id,
                                  postularse: widget.voluntariado.favorito,
                                  userId: _authService.currentUser!.id,
                                );
                                setState(() {
                                  _loadingFavorito = false;
                                });
                                if(response['result'] == 'error') {
                                  await CustomSnackbar.showSnackbar(context: context, detail: response['detail']!);
                                } else {
                                  setState(() {
                                    favorito = widget.voluntariado.favorito;
                                  });
                                }
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