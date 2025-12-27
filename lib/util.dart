import 'package:url_launcher/url_launcher.dart';
class AppRoutes {
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String comunity = '/comunity';
}

void launchRepo() async {
   final Uri url = Uri.parse('https://github.com/NoachDev/SeferTorah');

   if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
    }
}