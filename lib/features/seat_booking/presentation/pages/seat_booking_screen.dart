import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/presentation/widgets/app_button.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/pages/booking_payment_screen.dart';
import 'package:movie_app_assessment/features/seat_booking/presentation/widgets/movie_hall.dart';

import '../../../../core/utils/app_strings.dart';

class SeatBookingScreen extends StatelessWidget {
  const SeatBookingScreen({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mist,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              94,
              20,
              14,
            ),
            child: Text(
              AppStrings.date,
              style: AppTypography.titleMedium,
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              separatorBuilder: (_, __) => SizedBox(
                width: 12,
              ),
              itemBuilder: (context, index) {
                final isSelected = index == 0;
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.skyBlue
                          : AppColors.grey.withValues(
                              alpha: 0.1,
                            ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 21,
                            spreadRadius: 0,
                            color: Color(0x23AAEB45),
                          ),
                      ],
                    ),
                    child: Text(
                      "${index + 5} Mar",
                      style: AppTypography.labelLarge.copyWith(
                        color: isSelected ? AppColors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 244,
            child: ListView.separated(
              itemCount: 10,
              padding: EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(
                width: 10,
              ),
              itemBuilder: (context, _) {
                return MovieHall();
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(
          26,
        ),
        child: CustomButton(
          text: AppStrings.selectSeats,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BookingPaymentScreen(
                    title: title,
                    description: description,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
