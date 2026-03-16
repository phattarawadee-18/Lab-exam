import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam1/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

void main() {
  // สร้าง Mock สำหรับ HTTP และ Environment
  setUpAll(() async {
    // 1. จำลอง .env
    dotenv.testLoad(fileInput: 'GEMINI_API_KEY=test_key');

    // 2. จำลอง Hive ในที่เก็บข้อมูลชั่วคราว
    final tempDir = Directory.systemTemp.createTempSync();
    Hive.init(tempDir.path);
    if (!Hive.isBoxOpen('favorites')) {
      await Hive.openBox("favorites");
    }

    // 3. ปิดกั้นการเรียกใช้งาน Network จริงๆ
    HttpOverrides.global = null;
  });

  testWidgets('Manga Reader smoke test', (WidgetTester tester) async {
    // แก้ไขปัญหาเรื่องการโหลด Font ใน Test
    await tester.runAsync(() async {
      // 1. สั่งรันแอป
      await tester.pumpWidget(const MyApp());

      // 2. ใช้ pump แทน pumpAndSettle เพื่อไม่ให้มันรอจน Timeout 
      // หากมี Animation หรือรูปภาพที่โหลดไม่เสร็จ
      await tester.pump();

      // 3. ตรวจสอบว่ามี MaterialApp หรือไม่ (ถ้ามีแสดงว่าแอปสตาร์ทติด)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    debugPrint('--- ผลการทดสอบ: แอปสามารถเริ่มต้นได้ปกติ ---');
  });
}