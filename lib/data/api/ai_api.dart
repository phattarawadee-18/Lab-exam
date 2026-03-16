import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIAPI {
  Future<String> summarize(String text) async {
    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      
      // ตรวจสอบว่ามี API Key หรือไม่
      if (apiKey == null || apiKey.isEmpty) {
        return "Error: ไม่พบ API Key ในไฟล์ .env กรุณาตรวจสอบการตั้งค่า";
      }

      final url = Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": "Summarize this manga story shortly:\n$text"}
              ]
            }
          ]
        }),
      ).timeout(const Duration(seconds: 15)); // ป้องกันแอปค้างถ้าเน็ตช้า

      // 1. ตรวจสอบ HTTP Status (ต้องเป็น 200 ถึงจะทำงานต่อ)
      if (response.statusCode != 200) {
        return "Error: เซิร์ฟเวอร์ตอบกลับผิดพลาด (${response.statusCode})";
      }

      final data = jsonDecode(response.body);

      // 2. การตรวจสอบข้อมูลแบบ Safe Access (ป้องกัน Error ที่คุณเจอ)
      if (data != null && 
          data["candidates"] != null && 
          (data["candidates"] as List).isNotEmpty) {
        
        var firstCandidate = data["candidates"][0];
        if (firstCandidate["content"] != null && 
            firstCandidate["content"]["parts"] != null &&
            (firstCandidate["content"]["parts"] as List).isNotEmpty) {
          
          return firstCandidate["content"]["parts"][0]["text"];
        }
      }
      
      return "ไม่พบเนื้อหาที่สรุปได้จาก AI (ข้อมูลส่งมาไม่ครบ)";

    } catch (e) {
      // ดักจับ Error อื่นๆ เช่น เน็ตหลุด หรือรูปแบบ JSON ผิด
      return "เกิดข้อผิดพลาดในการเชื่อมต่อ: $e";
    }
  }
}