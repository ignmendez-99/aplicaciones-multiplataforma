import 'dart:io';

import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../design_system/atoms/status_bar.dart';
import '../models/novedad.dart';

class NovedadPage extends StatelessWidget {
  const NovedadPage({
    super.key,
    required this.novedadFuture
  });

  final Future<Novedad?> novedadFuture;

  Future<void> _share({required Novedad novedad}) async {
    final response = await get(Uri.parse(novedad.pictureDownloadUrl));
    final directory = await getTemporaryDirectory();
    File file = await File('${directory.path}/Image.png').writeAsBytes(response.bodyBytes);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: novedad.subtitulo,
      subject: 'Ser Manos - Compartir novedad'
    );
  }

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.secondaryBlue90,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryBlue90,
          iconTheme: const IconThemeData(
              color: AppColors.neutralWhite
          ),
          title: Center (
            child: Text(
              'Novedades',
              style: MyTheme.subtitle01(color: AppColors.neutralWhite),
            ),
          ),

          // titleSpacing: ,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            child: FutureBuilder(
              future: novedadFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasData && snapshot.data != null) {
                  final Novedad novedad = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        novedad.titulo1,
                        style: MyTheme.overline(color: AppColors.neutralGrey75),
                      ),
                      Text(
                        novedad.titulo2,
                        style: MyTheme.headline02(),
                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        height: 160,
                        width: 328,
                        child: FittedBox(
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.fitWidth,
                          child: Image.network(novedad.pictureDownloadUrl),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        novedad.subtitulo,
                        style: MyTheme.subtitle01(color: AppColors.secondaryBlue200),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        novedad.contenido,
                        style: MyTheme.body01(),
                      ),
                      const SizedBox(height: 16,),
                      Center(
                        child: Text(
                          'Comparte esta nota',
                          style: MyTheme.headline02(),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      ButtonCTAFilled(
                        onPressed: () async => await _share(novedad: novedad),
                        buttonText: 'Compartir',
                        disabled: false
                      )
                    ],
                  );
                } else {
                  // CASO IMPOSIBLE
                  return Container();
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}
