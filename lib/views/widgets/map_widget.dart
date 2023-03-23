import 'package:google_maps_flutter/google_maps_flutter.dart';

googleMapWidget(currentPosition, [destinationPosition, markers, polyines]) {
  LatLng defaultPosition;
  if (destinationPosition != null) {
    defaultPosition = destinationPosition;
  } else {
    defaultPosition = currentPosition;
  }
  return GoogleMap(
    initialCameraPosition: CameraPosition(target: defaultPosition, zoom: 15),
    markers: markers,
    polylines: polyines,
  );
}
