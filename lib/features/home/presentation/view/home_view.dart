import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/nav_helper.dart';
import 'package:tracking_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:tracking_app/features/home/presentation/widgets/home_order_container.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final List<HomeOrderContainer> orders = [
    HomeOrderContainer(
      pickupImage: '',
      pickupName: 'Flowery store',
      pickupAddress: '20th st, Sheikh Zayed, Giza',
      userImage: '',
      userName: 'Nour Mohamed',
      userAddress: '20th st, Sheikh Zayed, Giza',
      price: 3000,
    ),

    HomeOrderContainer(
      pickupImage: '',
      pickupName: 'Coffee House',
      pickupAddress: '6 October, Giza',
      userImage: '',
      userName: 'Ahmed Ali',
      userAddress: 'Dokki, Giza',
      price: 250,
    ),

    HomeOrderContainer(
      pickupImage: '',
      pickupName: 'Fresh Market',
      pickupAddress: 'Nasr City, Cairo',
      userImage: '',
      userName: 'Sara Mostafa',
      userAddress: 'Heliopolis, Cairo',
      price: 780,
    ),

    HomeOrderContainer(
      pickupImage: '',
      pickupName: 'Burger Town',
      pickupAddress: 'Madinaty, Cairo',
      userImage: '',
      userName: 'Mohamed Adel',
      userAddress: 'New Cairo',
      price: 430,
    ),

    HomeOrderContainer(
      pickupImage: '',
      pickupName: 'Electro Shop',
      pickupAddress: 'Mohandessin, Giza',
      userImage: '',
      userName: 'Youssef Samir',
      userAddress: 'Sheikh Zayed, Giza',
      price: 5200,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s30,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Text(
            "Flowery rider",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: FontConstants.imfEllEnglish,
              fontSize: FontSize.s20,
            ),
          ),
        ),
        leadingWidth: .infinity,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: AppPadding.p16,
          right: AppPadding.p16,
          left: AppPadding.p16,
        ),
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              //TODO: call orders again
            },
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return orders[index];
              },
            ),
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
