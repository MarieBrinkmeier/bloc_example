import 'package:url_launcher/url_launcher.dart';

/// A service class for opening URLs.
///
/// This service provides a method to open a URL using the default browser
/// of the device.
class UrlService {
  /// Opens the given [url] in the default browser of the device.
  ///
  /// Throws an exception if the URL cannot be launched.
  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
