import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/category_card.dart';
import '../widgets/search_field.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      'https://static.wikia.nocookie.net/disney/images/3/35/Url.jpg/revision/latest?cb=20240930141217',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfoRDr2z3LbyyLJ9hkyAare8t0uk5fjNT214ci86Ly8xL8maipg7gwhq4woMDQVV6l11c&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4giSvRs3R5_6N4FfJtEehYOMXJ16NhfhrKyos5G8nThBir6u0uAw72nUpDxULYDCeJ8Y&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP6FbAyPFb2xZetNfdd1QpCLC_QQnzoYusQ0ATXxKmQrqEY25DEBB19ePgLq0HI0TEsjM&usqp=CAU',
    ];
    return Scaffold(
      backgroundColor: AppColors.mist,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 8, 20, 25),
            decoration: BoxDecoration(color: Colors.white),
            child: SearchField(
              onChanged: (value) {},
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xFFEFEFEF),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: urls.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.63, //163/100
              ),
              itemBuilder: (context, index) {
                return CategoryCard(title: "Comdeian", imageUrl: urls[index], onTap: () {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
