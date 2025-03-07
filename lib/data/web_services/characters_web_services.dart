import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    List<dynamic> characters = [];
    try {
      Response response = await dio.get('/character');
      characters = response.data['results'];
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return characters;
  }
}
