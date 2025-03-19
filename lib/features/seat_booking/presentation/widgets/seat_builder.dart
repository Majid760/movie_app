import 'package:flutter/material.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/widgets/seat_view.dart';

import '../../../../core/utils/enums/app_enums.dart';
import '../../data/models/layout_model.dart';
import '../../data/models/seat_model.dart';

class SeatLayoutWidget extends StatefulWidget {
  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI, SeatState currentState) onSeatStateChanged;
  final double maxScale;
  final double minScale;

  const SeatLayoutWidget({
    super.key,
    required this.stateModel,
    required this.onSeatStateChanged,
    this.maxScale = 5.0,
    this.minScale = 0.5,
  });

  @override
  _SeatLayoutWidgetState createState() => _SeatLayoutWidgetState();
}

class _SeatLayoutWidgetState extends State<SeatLayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      boundaryMargin: const EdgeInsets.all(8),
      constrained: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.stateModel.rows, (rowI) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row number
              SizedBox(
                width: 24,
                child: Text(
                  '${rowI + 1}',
                  style: const TextStyle(fontSize: 6, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              // Seats
              Row(
                children: _generateCenterFirstSeats(widget.stateModel, rowI),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Generate seats, starting from the center
  List<SeatWidget> _generateCenterFirstSeats(SeatLayoutStateModel stateModel, int rowI) {
    final int totalCols = stateModel.cols;
    final int centerCol = totalCols ~/ 2;
    List<SeatWidget> orderedSeats = [];

    for (int offset = 0; offset < (totalCols + 1) ~/ 2; offset++) {
      if (offset == 0 && totalCols % 2 == 1) {
        orderedSeats.add(_createSeatWidget(stateModel, rowI, centerCol));
      } else {
        final int leftCol = centerCol - offset;
        final int rightCol = centerCol + (totalCols % 2 == 0 ? offset : offset);

        if (leftCol >= 0) {
          orderedSeats.insert(0, _createSeatWidget(stateModel, rowI, leftCol));
        }
        if (rightCol < totalCols) {
          orderedSeats.add(_createSeatWidget(stateModel, rowI, rightCol));
        }
      }
    }
    return orderedSeats;
  }

  SeatWidget _createSeatWidget(SeatLayoutStateModel stateModel, int rowI, int colI) {
    return SeatWidget(
      model: SeatModel(
        seatState: stateModel.currentSeatsState[rowI][colI],
        rowI: rowI,
        colI: colI,
        seatSvgSize: stateModel.seatSvgSize,
        pathSelectedSeat: stateModel.pathSelectedSeat,
        pathDisabledSeat: stateModel.pathDisabledSeat,
        pathSoldSeat: stateModel.pathSoldSeat,
        pathUnSelectedSeat: stateModel.pathUnSelectedSeat,
      ),
      onSeatStateChanged: widget.onSeatStateChanged,
    );
  }
}
