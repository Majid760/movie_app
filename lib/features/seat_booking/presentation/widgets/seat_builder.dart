import 'package:flutter/material.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/widgets/seat_view.dart';

import '../../../../core/utils/enums/app_enums.dart';
import '../../data/models/layout_model.dart';
import '../../data/models/seat_model.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI, SeatState currentState) onSeatStateChanged;

  const SeatLayoutWidget({
    super.key,
    required this.stateModel,
    required this.onSeatStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      minScale: 0.8,
      boundaryMargin: const EdgeInsets.all(8),
      constrained: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List<int>.generate(stateModel.rows, (rowI) => rowI).map<Widget>(
            (rowI) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row number on the left side
                SizedBox(
                  width: 24,
                  child: Text(
                    '${rowI + 1}', // Add 1 to start from 1 instead of 0
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Add some spacing between row number and seats
                SizedBox(width: 16),

                // Seats section - rearranged to start from center
                Row(
                  children: _generateCenterFirstSeats(stateModel, rowI),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper method to generate seats starting from the center
  List<SeatWidget> _generateCenterFirstSeats(SeatLayoutStateModel stateModel, int rowI) {
    final int totalCols = stateModel.cols;
    final int centerCol = totalCols ~/ 2; // Integer division to find center

    // This will hold our seats in the desired order
    List<SeatWidget> orderedSeats = [];

    // Start from the center and expand outward
    for (int offset = 0; offset < (totalCols + 1) ~/ 2; offset++) {
      // Add center seat first
      if (offset == 0) {
        // If there's an odd number of columns, add the exact middle seat
        if (totalCols % 2 == 1) {
          orderedSeats.add(_createSeatWidget(stateModel, rowI, centerCol));
        }
      } else {
        // Add the pair of seats (one left of center, one right of center)
        final int leftCol = centerCol - offset;
        final int rightCol = centerCol + (totalCols % 2 == 0 ? offset : offset);

        // Check if these columns are valid
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

  // Helper method to create a single seat widget
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
      onSeatStateChanged: onSeatStateChanged,
    );
  }
}
