import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/translate_model.dart';

class TranslateService {
  Future<List<Translate>> getTranslate(String message) async {
    final _movieController = Get.put<MovieController>(MovieController());
    print("başladım");

    final uri =
        Uri.parse('https://microsoft-translator-text.p.rapidapi.com/translate')
            .replace(queryParameters: <String, String>{
      if (_movieController.movieLanguage == "")
        'to': 'tr'
      else
        'to': '${_movieController.movieLanguage}',
      'api-version': '3.0',
      'profanityAction': 'NoAction',
      'textType': 'plain',
    });
    final response = await http.post(uri,
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Host': 'microsoft-translator-text.p.rapidapi.com',
          'X-RapidAPI-Key': '8ad5d90d72msh7bf606d6993cb80p1f5a9fjsn1242d0cc7448'
        },
        body: message == ""
            ? '[{"Text":"İstediğiniz dilde yazabilirsiniz , yapay zeka yazdığınız dili algılar ve seçtiğiniz dile çevirir, Hadi Bir şeyler Yazın..!"}]'
            : '[{"Text":"$message"}]');
    if (response.statusCode == 200) {
      final post = jsonDecode(response.body);
      final post2 = post[0]["translations"] as List;
      final json = post2.map((e) => Translate.fromJson(e)).toList();
      return json;
    } else {
      throw Exception('Failed to load translate');
    }
  }
}
