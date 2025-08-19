import 'package:geolocator/geolocator.dart';
import '../vo/PositionVO.dart';

class LocationService {

  Future<PositionVO> getCurrentPosition() async {
    Position? position = await _determinePosition();
    double latitude = 0.0;
    double longitude = 0.0;

    if (position != null) {
      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      latitude = -1;
      longitude = -1;
    }

    return PositionVO(latitude, longitude);
  }

  Future<Position?> _determinePosition() async {
    try {
      await checkIsLocationServiceEnabled();
      await checkPermission();

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print("There was a problem with the internet connection $e");
    }
    return null;
  }

// Location 서비스 사용가능 여부 확인
  Future<void> checkIsLocationServiceEnabled() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disabled.");
    }
  }

// Location Permission 체크 및 요청
  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions.");
    }
  }
}
