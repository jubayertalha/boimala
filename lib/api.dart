import 'dart:io';
import 'dart:convert';

class Api{

  final String baseUrl = 'http://10.0.2.2:3005/api';

  const Api();

  login(String email,String pass) async{
    String url = '/login';
    Map body = {
      "email":"$email",
      "pass":"$pass"
    };
    return await apiRequest(baseUrl+url, body);
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }
}