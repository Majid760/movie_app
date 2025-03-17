part of 'seat_manager_cubit.dart';

sealed class SeatManagerState extends Equatable {
  const SeatManagerState();
}

final class SeatManagerInitial extends SeatManagerState {
  @override
  List<Object> get props => [];
}
