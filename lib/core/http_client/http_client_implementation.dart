import 'package:http/http.dart' as http;
import 'package:movie_searcher_flutter/core/http_client/http_client.dart';

class HttpClientImplementation implements HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));

    return HttpResponse(
      data: response.body, 
      statusCode: response.statusCode,
    );
  }
}