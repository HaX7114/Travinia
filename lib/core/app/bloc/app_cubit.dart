import 'package:flutter/material.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/utils/app_color.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/models/create_booking_model.dart';
import 'package:travinia/models/facility_model.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/models/profile_model.dart';
import 'package:travinia/models/register_model.dart';
import 'package:travinia/presentation/auth/bloc/auth_cubit.dart';
import 'package:travinia/presentation/auth/profile_info/profile_info_screen.dart';
import 'package:travinia/presentation/test/widgets/homeWidget.dart';
import 'package:travinia/services/repositories/repository.dart';

import '../../utils/routes.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repository;

  AppCubit({required this.repository}) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  RegisterModel? registerModel;
  Color primaryColor = AppColors.primaryColor;
  Color secondaryColor = AppColors.secondaryColor;
  double colorOpacity = 1.0;
  ThemeData currentAppTheme = AppThemes.lightTheme;

  void changeAppThemeColor() {
    if (currentAppTheme == AppThemes.lightTheme) {
      primaryColor = AppColors.primaryDarkColor;
      secondaryColor = AppColors.secondaryDarkColor;
      currentAppTheme = AppThemes.darkTheme;
      colorOpacity = 0.2;
    } else {
      primaryColor = AppColors.primaryColor;
      secondaryColor = AppColors.secondaryColor;
      currentAppTheme = AppThemes.lightTheme;
      colorOpacity = 1.0;
    }
    emit(AppThemeColorChangedState());
  }

  ProfileModel? profileModel;

  List<HotelModel> hotels = [];

  void getHotels() async {
    emit(HotelsLoadingState());

    final response = await repository.getHotels(
      page: 1,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        hotels = r.data!.data;

        emit(HotelsSuccessState());
      },
    );
  }

  ///Error in Facility Model >>>>>>
  List<FacilityModel> facilities = [];

  void getFacilities() async {
    emit(FacilitiesLoadingState());

    final response = await repository.getFacilities();

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        facilities = r.facilities;
        debugPrint(facilities.toString());
        Future.delayed(Duration(seconds: 1));
        emit(FacilitiesSuccessState());
      },
    );
  }

  Create_BookingModel? create_BookingModel;

  void userCreate_Booking(
      {required BuildContext context,
      required int userId,
      required int hotelId}) async {
    emit(UserProfileLoadingState());
    final response = await repository.create_Booking(
      token: AuthCubit.get(context).userToken,
      user_id: userId,
      hotel_id: hotelId,
    );

    response.fold(
      (l) {
        emit(ErrorState(exception: l));
      },
      (r) {
        create_BookingModel = r;

        emit(CreatBookingSuccessState());
      },
    );
  }

  int currentIndex = 0;

  changeNavBar({required BuildContext context, required int index}) {
    if (index == 0) {
      currentIndex = index;
    } else if (index == 2) {
      AuthCubit.get(context).userProfile();
      // Navigator.pushNamed(context, Routes.profileInfo);
      currentIndex = index;
    }
    emit(changeNavBarState());
  }

  homeNavWidget() {
    if (currentIndex == 0) {
      return HomeWidget();
    } else if (currentIndex == 1) {
      ///TODO tripsScreen
      // return tripsScreen
    } else if (currentIndex == 2) {
      return ProfileInfoWidget();
    }
  }
}
