import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:purpleplane_test_app/models/post.dart';

class ApiProvider {
  final String baseApi = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<Post>> getPosts() async{

    final response = await http.get(baseApi);
    
    if(response.statusCode == 200){
      final List<dynamic> userJson = json.decode(response.body);
      return userJson.map((json) => Post.fromJson(json)).toList();
    }else{
        throw Exception('Error fetching posts');
    }
  }


}
