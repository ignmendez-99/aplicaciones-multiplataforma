import 'package:url_launcher/url_launcher.dart';

class MapService {

  void openGoogleMaps(double latitude, double longitude) async {
    // https://www.google.com/maps/search/?api=1&query=37.7749,-122.4194
    final uri = Uri(
        scheme: 'https',
        host: 'www.google.com',
        path: '/maps/search/',
        queryParameters: {
          'api': '1',
          'query': '$latitude,$longitude'
        });
    final url = uri.toString();

    if(await canLaunchUrl(uri)) {
      try {
        await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication
        );
      } catch (e) {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Could not launch $url';
    }

  }

}