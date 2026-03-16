import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIAPI {
  final Dio dio;

  AIAPI(this.dio);

  Future<String> summarizeText(String text) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      throw Exception("OpenAI API Key not found");
    }

    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        options: Options(headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        }),
        data: {
          "model": "gpt-4o-mini",
          "messages": [
            {"role": "user", "content": "Summarize this comic story:\n$text"}
          ],
        },
      );

      return response.data["choices"][0]["message"]["content"];
    } catch (e) {
      throw Exception("AI Summary failed: $e");
    }
  }
}