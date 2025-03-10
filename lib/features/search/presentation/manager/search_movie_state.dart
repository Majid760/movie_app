import 'package:equatable/equatable.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
  });
  final SearchStatus status;

  SearchState copyWith({
    SearchStatus? status,
  }) {
    return SearchState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
