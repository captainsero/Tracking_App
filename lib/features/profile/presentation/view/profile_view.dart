// profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/core/locale/locale_cubit.dart';
import 'package:tracking_app/core/router/route_path.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:tracking_app/features/profile/presentation/widgets/error_info_card.dart';
import 'package:tracking_app/features/profile/presentation/widgets/language_picker_sheet.dart';
import 'package:tracking_app/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:tracking_app/features/profile/presentation/widgets/profile_appbar.dart';
import 'package:tracking_app/features/profile/presentation/widgets/profile_card.dart';
import 'package:tracking_app/features/profile/presentation/widgets/options_section.dart';
import 'package:tracking_app/features/profile/presentation/widgets/settings_tile.dart';
import 'package:tracking_app/features/profile/presentation/widgets/vehicle_card.dart';
import 'package:tracking_app/generated/l10n.dart';

import '../../../../core/router/nav_helper.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().onEvent(ProfileEvent.loadProfileData());
  }

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      appBar: const ProfileAppbar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) =>
            previous.profileDataState != current.profileDataState,
        builder: (context, state) {
          final profileDataState = state.profileDataState;

          if (profileDataState.isLoading ?? false) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = profileDataState.data;
          final hasError = profileDataState.errorMessage != null;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              // ── Profile Card ──────────────────────────────────────
              if (hasError)
                ErrorInfoCard(
                  onRetry: () => context.read<ProfileCubit>().onEvent(
                    ProfileEvent.loadProfileData(),
                  ),
                )
              else if (data != null)
                ProfileCard(data: data),

              const SizedBox(height: 12),

              // ── Vehicle Card ──────────────────────────────────────
              const VehicleCard(),

              const SizedBox(height: 24),

              // ── Options Section ──────────────────────────────────
              OptionsSection(
                children: [
                  // Language tile — reacts to locale changes
                  BlocBuilder<LocaleCubit, Locale>(
                    builder: (ctx, locale) {
                      final isArabic = locale.languageCode == 'ar';
                      final currentLangLabel = isArabic ? 'العربية' : 'English';

                      return SettingsTile(
                        icon: Icons.language_outlined,
                        label: S.current.language,
                        trailing: Text(
                          currentLangLabel,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => showLanguagePickerSheet(context),
                      );
                    },
                  ),

                  SettingsTile(
                    icon: Icons.person_outline,
                    label: S.current.editProfile,
                    onTap: () {
                      context.go(RoutePath.profileEdit);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.logout_outlined,
                    label: S.current.logout,
                    iconColor: Colors.redAccent,
                    labelColor: Colors.redAccent,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: const LogoutDialog(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
