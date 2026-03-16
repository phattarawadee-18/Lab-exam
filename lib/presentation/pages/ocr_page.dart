import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OCRPage extends StatefulWidget {
  const OCRPage({super.key});
  @override
  State<OCRPage> createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  final picker = ImagePicker();
  String recognizedText = "";
  bool isLoading = false;

  Future<void> pickAndScanImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      isLoading = true;
      recognizedText = "";
    });

    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer();
    final result = await textRecognizer.processImage(inputImage);

    setState(() {
      recognizedText = result.text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Scan Text from Image")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAndScanImage,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text("Pick Image and Scan"),
            ),
            const SizedBox(height: 16),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading && recognizedText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    recognizedText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}