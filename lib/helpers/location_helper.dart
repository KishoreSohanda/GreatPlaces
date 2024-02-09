import 'dart:convert';

import 'package:http/http.dart' as http;

const key = 'pk.d595127f0d9581f65ad188d25a9c68da';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.locationiq.com/v3/staticmap?key=$key&center=$latitude,$longitude&zoom=13&size=600x300&format=jpg&maptype=streets&markers=icon:medium-red-cutout|$latitude,$longitude';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://us1.locationiq.com/v1/reverse?key=$key&lat=$lat&lon=$lng&format=json');
    final response = await http.get(url);
    return json.decode(response.body)['display_name'];
  }
}
