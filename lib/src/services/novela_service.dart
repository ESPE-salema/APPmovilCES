//import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
//import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
//import 'package:novelkaizen_project_lema_unda/src/models/novela_model.dart';

class NovelaService {
  NovelaService();

  /*Future<List<Novela>?> getNovelas() async {
    try {
      List<Novela> result = [];
      var url = Uri.parse('https://novelkaizen-backend.web.app/api/novelas');

      var response = await http.get(url);

      if (response.body.isEmpty) return result;

      List<dynamic> listResponse = json.decode(response.body);

      for (var item in listResponse) {
        var novela = Novela.fromJson(item);
        result.add(novela);
      }

      return result;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }

  Future<int> postNovela(Novela novela) async {
    try {
      var uri = Uri.parse("https://novelkaizen-backend.web.app/api/novela");
      String _novelaBody = novelaToJson(novela);
      final Map<String, String> _headers = {"content-type": "application/json"};
      var response =
          await http.post(uri, headers: _headers, body: _novelaBody);
      if (response.body.isEmpty) return 400;
      Map<String, dynamic> content = json.decode(response.body);
      int result = content["estado"];
      developer.log("Estado $result");
      return result;
    } catch (ex) {
      developer.log("Error $ex");
      return 500;
    }
  }*/

  Future<String> uploadImage(File image) async {
    final cloudinary = CloudinaryPublic('deqdp1jwi', 'dn1sgp7q', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      developer.log(e.message!);
      return "";
    }
  }
}
