import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_comics.dart';
import '../../domain/usecases/get_summary.dart'; // เพิ่ม import นี้
import 'comic_event.dart';
import 'comic_state.dart';

// ในไฟล์ comic_bloc.dart
class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final GetComics getComics;
  final GetSummary getSummary; // เปลี่ยนจาก Object เป็น GetSummary

  // แก้ไข Constructor
  ComicBloc(this.getComics, this.getSummary) : super(ComicLoading()) {
    // ... โค้ดส่วน on<LoadComics> ...
  

    on<LoadComics>((event, emit) async {
      emit(ComicLoading());
      try {
        final comics = await getComics();
        emit(ComicLoaded(comics));
      } catch (e) {
        // แนะนำให้เพิ่มการจัดการ error ด้วยครับ
        emit(ComicError(e.toString())); 
      }
    });
  }
}