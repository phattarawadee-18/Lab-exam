import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/ai_api.dart';
import 'summary_event.dart';
import 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final AIAPI _aiApi;

  SummaryBloc(this._aiApi) : super(SummaryInitial()) {
    on<GetSummary>((event, emit) async {
      emit(SummaryLoading());
      try {
        final summary = await _aiApi.summarize(event.synopsis);
        emit(SummaryLoaded(summary));
      } catch (e) {
        emit(SummaryError('Failed to get summary: ${e.toString()}'));
      }
    });
  }
}