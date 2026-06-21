import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';
import 'package:tracking_app/core/router/nav_helper.dart';
import 'package:tracking_app/core/shared_widgets/custom_buttom_navigation_bar.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_events.dart';
import 'package:tracking_app/features/home/presentation/view_model/cubit/home_state.dart';
import 'package:tracking_app/features/home/presentation/widgets/home_order_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final orders = state.getPendingOrdersState.data;

            if (state.getPendingOrdersState.isLoading == true) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.getPendingOrdersState.errorMessage != null) {
              return Center(
                child: Text(state.getPendingOrdersState.errorMessage!),
              );
            }

            if (orders == null || orders.isEmpty) {
              return const Center(child: Text('No pending orders'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeCubit>().onEvent(GetPendingOrdersEvent());
              },

              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return HomeOrderContainer(
                    pickupImage: order.store?.image ?? '',
                    pickupName: order.store?.name ?? '',
                    pickupAddress: order.store?.address ?? '',
                    userImage: order.user?.photo ?? '',
                    userName:
                        '${order.user?.firstName ?? ''} ${order.user?.lastName ?? ''}',
                    userAddress:
                        '${order.shippingAddress?.street ?? ''}, ${order.shippingAddress?.city ?? ''}',
                    totalPrice: 0,
                  );
                },
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
