abstract class SummaryEvent {}

class GetSummary extends SummaryEvent {
  final String synopsis;
  GetSummary(this.synopsis);
}