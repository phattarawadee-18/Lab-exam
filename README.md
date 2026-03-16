# 📚 Manga Reader App (Exam 1)

แอปพลิเคชันสำหรับอ่านมังงะและสรุปเนื้อเรื่องด้วย AI พัฒนาด้วย **Flutter** โดยเน้นโครงสร้างที่สะอาดและการจัดการสถานะที่มีประสิทธิภาพ

## 🚀 คุณสมบัติของแอป (Features)
* **Manga List & Details:** แสดงรายการมังงะและรายละเอียดเนื้อเรื่อง
* **AI Summary:** สรุปเนื้อเรื่องมังงะสั้นๆ โดยใช้ **Google Gemini Pro API**
* **Favorites System:** บันทึกมังงะเรื่องโปรดไว้ในเครื่องด้วย **Hive (NoSQL)**
* **Responsive UI:** รองรับการแสดงผลทั้ง Mobile และ Web (Chrome)

## 🛠 เทคโนโลยีที่ใช้ (Tech Stack)
* **State Management:** [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
* **Database:** [Hive](https://pub.dev/packages/hive) (Local Storage)
* **Networking:** [HTTP](https://pub.dev/packages/http) & [Dio](https://pub.dev/packages/dio)
* **Environment:** [Flutter Dotenv](https://pub.dev/packages/flutter_dotenv) (สำหรับเก็บ API Key)
* **AI Integration:** Google Generative AI (Gemini Pro)

---

## 📦 การติดตั้งและเริ่มต้นใช้งาน (Getting Started)

### 1. เตรียมความพร้อม
* ติดตั้ง [Flutter SDK](https://docs.flutter.dev/get-started/install) (เวอร์ชัน ^3.x.x)
* มี **Gemini API Key** (ขอได้ที่ [Google AI Studio](https://aistudio.google.com/))

### 2. ตั้งค่า Environment
สร้างไฟล์ `.env` ที่ Root ของโปรเจกต์ และเพิ่ม API Key ของคุณ:
```env
GEMINI_API_KEY=your_api_key_here