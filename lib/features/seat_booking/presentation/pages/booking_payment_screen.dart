import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/core/utils/app_path.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/widgets/seat_type_widget.dart';

import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/presentation/widgets/custom_snackbar.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums/app_enums.dart';
import '../../data/models/layout_model.dart';
import '../../data/models/number_model.dart';
import '../widgets/round_button.dart';
import '../widgets/seat_builder.dart';

class BookingPaymentScreen extends StatefulWidget {
  const BookingPaymentScreen({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  Set<SeatNumber> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 76,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.title,
              style: AppTypography.titleMedium,
            ),
            SizedBox(
              height: 6,
            ),
            Hero(
              tag: "theater",
              child: Text(
                widget.description,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.skyBlue,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: AppColors.mist,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppSvgWidget.screenShape,
                      Text(
                        AppStrings.screen,
                        style: AppTypography.labelMedium.copyWith(color: AppColors.gray, height: 1.6, fontSize: 8),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // seat view of the cinema hall
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      child: SeatLayoutWidget(
                        onSeatStateChanged: (rowI, colI, seatState) {
                          AppSnackBar.show(
                            context: context,
                            type: SnackBarType.info,
                            message: seatState == SeatState.selected
                                ? "Selected Seat[$rowI][$colI]"
                                : "De-selected Seat[$rowI][$colI]",
                          );
                          if (seatState == SeatState.selected) {
                            selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                          } else {
                            selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                          }
                        },
                        stateModel: SeatLayoutStateModel(
                            pathDisabledSeat: AppAssets.seatDisabled,
                            pathSelectedSeat: AppAssets.seatSelect,
                            pathSoldSeat: AppAssets.seatBooked,
                            pathUnSelectedSeat: AppAssets.seatUnselected,
                            rows: 10,
                            cols: 23,
                            seatSvgSize: 15,
                            currentSeatsState: [
                              [
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.disabled,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.disabled,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                              ],
                              [
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.sold,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.unselected,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                                SeatState.empty,
                              ],
                            ]),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 135),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        icon: Icons.add,
                      ),
                      RoundButton(
                        icon: Icons.remove,
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  // Container(
                  //   height: 5,
                  //   margin: EdgeInsets.only(
                  //     left: 16,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(
                  //       100,
                  //     ),
                  //     color: AppColors.textPrimary.withValues(
                  //       alpha: 0.3,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),
            // seat type section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 21,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.selected,
                      assetPath: AppAssets.seatSelect,
                    ),
                  ),
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.notAvailable,
                      assetPath: AppAssets.seatBooked,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 21,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.vip,
                      assetPath: AppAssets.seatDisabled,
                    ),
                  ),
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.regular,
                      assetPath: AppAssets.seatUnselected,
                    ),
                  ),
                ],
              ),
            ),
            // seat selection section
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("4 / 3 row"),
                    const SizedBox(
                      width: 22,
                    ),
                    Icon(
                      Icons.clear,
                      size: 20,
                      color: AppColors.textPrimary,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 106,
        padding: EdgeInsets.all(
          26,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppStrings.totalPrice,
                        style: AppTypography.bodyMedium,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "\$ 50",
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: CustomButton(
                text: AppStrings.selectSeats,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
