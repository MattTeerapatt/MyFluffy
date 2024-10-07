import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(Function(Uint8List) onImagePicked) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    final Uint8List imageData = await image.readAsBytes();
    onImagePicked(imageData); // Pass image data back
  }
}
