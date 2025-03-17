import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seat_manager_state.dart';

class SeatManagerCubit extends Cubit<SeatManagerState> {
  SeatManagerCubit() : super(SeatManagerInitial());
}
