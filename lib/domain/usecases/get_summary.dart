import 'package:dio/dio.dart';

class GetSummary {
  final Dio dio;

  GetSummary(this.dio);

  Future<String> call(String text) async {
    final response = await dio.post(
      "https://api.openai.com/v1/chat/completions",
      options: Options(headers: {
        "Authorization": "Bearer YOUR_API_KEY",
        "Content-Type": "application/json",
      }),
      data: {
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "user", "content": "Summarize this comic story:\n$text"}
        ]
      },
    );

    return response.data["choices"][0]["message"]["content"];
  }
}