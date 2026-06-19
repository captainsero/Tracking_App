import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  static Future<String?> pickFromCamera() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    return file?.path;
  }
}