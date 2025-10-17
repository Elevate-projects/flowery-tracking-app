import 'package:equatable/equatable.dart';
import 'package:flowery_tracking_app/core/state_status/state_status.dart';
import 'package:flowery_tracking_app/domain/entities/driver_data/driver_data_entity.dart';
 import 'package:flowery_tracking_app/presentation/profile/views_model/profile_cubit.dart';

class ProfileState extends Equatable{

    final StateStatus<DriverDataEntity?> profileStatus;
    final StateStatus<void>logoutStatus;
    final Languages selectedLanguage;
    const ProfileState({
    this.profileStatus = const StateStatus.initial(),
    this.logoutStatus = const StateStatus.initial(),
    this.selectedLanguage = Languages.english,
  });

    ProfileState copyWith({
        StateStatus<DriverDataEntity?>? profileStatus,
        StateStatus<void>?logoutStatus,
      Languages?selectedLanguage,}){
      return ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        logoutStatus: logoutStatus ?? this.logoutStatus,
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      );
    }
  @override
  List<Object?> get props => [profileStatus, logoutStatus,
    selectedLanguage
  ];
}