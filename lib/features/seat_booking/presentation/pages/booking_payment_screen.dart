import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/core/utils/app_path.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/widgets/seat_type_widget.dart';

import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/utils/app_strings.dart';
import '../widgets/round_button.dart';

class BookingPaymentScreen extends StatelessWidget {
  const BookingPaymentScreen({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

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
              title,
              style: AppTypography.titleMedium,
            ),
            SizedBox(
              height: 6,
            ),
            Hero(
              tag: "theater",
              child: Text(
                description,
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
          children: [
            Container(
              color: AppColors.mist,
              width: double.infinity,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(
                5,
                60,
                23,
                7,
              ),
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.seatMapWide,
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
                  Container(
                    height: 5,
                    margin: EdgeInsets.only(
                      left: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: AppColors.textPrimary.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 21,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SeatTypeWidget(
                      color: AppColors.gold,
                      label: AppStrings.selected,
                    ),
                  ),
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.notAvailable,
                      color: AppColors.grey.withValues(
                        alpha: 0.7,
                      ),
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
                      color: AppColors.purple,
                      label: AppStrings.vip,
                    ),
                  ),
                  Expanded(
                    child: SeatTypeWidget(
                      label: AppStrings.regular,
                      color: AppColors.skyBlue,
                    ),
                  ),
                ],
              ),
            ),
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
