import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_leadvision/data/model/Album.dart';
import 'package:task_leadvision/utils/constants.dart';

class AlbumRepository{
  Future<List<Album>> fetchAlbums(int page) async{
    final response = await http.get(Uri.parse('${Constants.baseUrl}${Constants.endpoint}?_page=$page&_limit=${Constants.pagesLimit}'));
    if(response.statusCode == 200){
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}