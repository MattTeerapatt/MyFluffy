import 'dart:html';
import 'dart:typed_data';

void pickImage(Function(Uint8List) onImagePicked) {
  FileUploadInputElement uploadInput = FileUploadInputElement();
  uploadInput.accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((e) async {
    final files = uploadInput.files;
    if (files!.isEmpty) return;

    final reader = FileReader();
    reader.readAsArrayBuffer(files[0]);
    reader.onLoadEnd.listen((e) async {
      onImagePicked(reader.result as Uint8List); // Pass image data back
    });
  });
}
