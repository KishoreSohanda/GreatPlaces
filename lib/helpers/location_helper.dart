const key = 'pk.d595127f0d9581f65ad188d25a9c68da';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.locationiq.com/v3/staticmap?key=$key&center=$latitude,$longitude&zoom=13&size=600x300&format=jpg&maptype=streets&markers=icon:medium-red-cutout|$latitude,$longitude';
  }
}
