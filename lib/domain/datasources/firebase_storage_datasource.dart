import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageDatasource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> getImageUrl(String imagePath) async {
    try {
      final ref = _storage.ref().child(imagePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error getting image URL: $e');
      return null;
    }
  }

  Future<String?> getVideoUrl(String videoPath) async {
    try {
      final ref = _storage.ref().child(videoPath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error getting video URL: $e');
      return null;
    }
  }

  Future<List<String>> listVideos() async {
    try {
      final List<String> videoUrls = [];
      final ListResult result = await _storage.ref().child('videos').listAll();

      // Iterar sobre los elementos del resultado
      await Future.forEach(result.items, (Reference ref) async {
        // Filtrar solo los elementos que son videos (puedes ajustar esta lógica según tus necesidades)
        if (ref.name.endsWith('.mp4') ||
            ref.name.endsWith('.avi') ||
            ref.name.endsWith('.mov')) {
          final url = await ref.getDownloadURL();
          videoUrls.add(url);
        }
      });

      return videoUrls;
    } catch (e) {
      print('Error listing videos: $e');
      return [];
    }
  }
}
