class Novedad {
  final String id;
  final String titulo1;
  final String titulo2;
  final String subtitulo;
  final String contenido;
  final String pictureDownloadUrl;

  const Novedad({
    required this.id,
    required this.titulo1,
    required this.titulo2,
    required this.subtitulo,
    required this.contenido,
    required this.pictureDownloadUrl
  });

  static Novedad fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return Novedad(
      id: id,
      titulo1: json['titulo_1'] as String,
      titulo2: json['titulo_2'] as String,
      subtitulo: json['subtitulo'] as String,
      contenido: json['contenido'] as String,
      pictureDownloadUrl: json['picture_download_url'] as String,
    );
  }

}