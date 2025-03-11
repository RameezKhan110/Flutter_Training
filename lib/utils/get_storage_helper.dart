
import 'package:get_storage/get_storage.dart';

class GetStorageHelper {

  GetStorage box = GetStorage("app_constants");

  void writeStorage(String key, dynamic value) {
    box.write(key, value);
  }

  dynamic readStorage(String key) {
    return box.read(key);
  }

}