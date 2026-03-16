abstract class SummaryState {}

class SummaryInitial extends SummaryState {}

class SummaryLoading extends SummaryState {}

class SummaryLoaded extends SummaryState {
  final String summary;
  SummaryLoaded(this.summary);
}

class SummaryError extends SummaryState {
  final String message;
  SummaryError(this.message);
}