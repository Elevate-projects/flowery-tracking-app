
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';
import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flowery_tracking_app/domain/entities/vehicle/vehicle_entity.dart';
import 'package:flowery_tracking_app/domain/use_cases/apply/apply_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/country/get_all_countries_use_case.dart';
import 'package:flowery_tracking_app/domain/use_cases/vehicle/get_all_vehicles_use_case.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_cubit.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_intent.dart';
import 'package:flowery_tracking_app/presentation/auth/apply/view_model/apply_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as p;

import '../../../fake_form_state.dart';
import 'apply_cubit_test.mocks.dart';
@GenerateMocks([GetAllCountriesUseCase, GetAllVehiclesUseCase, ApplyUseCase])
void main (){
 TestWidgetsFlutterBinding.ensureInitialized();
 late MockGetAllCountriesUseCase mockGetAllCountriesUseCase;
 late MockGetAllVehiclesUseCase mockGetAllVehiclesUseCase;
 late MockApplyUseCase mockApplyUseCase;
 late ApplyCubit applyCubit;
 late Result<List<CountryEntity>> expectedCountrySuccessResult;
 late Failure<List<CountryEntity>> expectedCountryFailureResult;
 late Result<void> expectedApplySuccessResult;
 late Failure<void> expectedApplyFailureResult;
 late Result<List<VehicleEntity>> expectedVehicleSuccessResult;
 late Failure<List<VehicleEntity>> expectedVehicleFailureResult;
 late Directory tempDir;
late File nidFile;
late File licenseFile;
 setUpAll((){
   mockApplyUseCase = MockApplyUseCase();
   mockGetAllCountriesUseCase = MockGetAllCountriesUseCase();
   mockGetAllVehiclesUseCase = MockGetAllVehiclesUseCase();

     tempDir = Directory.systemTemp.createTempSync();
     nidFile = File(p.join(tempDir.path, 'nid.jpg'))
      ..writeAsStringSync('dummy');
     licenseFile = File(p.join(tempDir.path, 'license.jpg'))
      ..writeAsStringSync('dummy');

    addTearDown(() {
      tempDir.deleteSync(recursive: true);
    });
   
    final VehicleEntity vehicleEntity = const VehicleEntity(id: '1', type: 'Car');
    final CountryEntity countryEntity= const CountryEntity(
      countryName: 'USA',
      flag: 'US',
    );
    expectedCountrySuccessResult = Success<List<CountryEntity>>([countryEntity]);
    expectedCountryFailureResult = Failure(responseException: const ResponseException(message: 'Failed to fetch countries'));
    expectedApplySuccessResult = Success<void>(null);
    expectedApplyFailureResult = Failure(responseException: const ResponseException(message: 'Apply failed'));
    expectedVehicleSuccessResult = Success<List<VehicleEntity>>([vehicleEntity]);
    expectedVehicleFailureResult = Failure(responseException: const ResponseException(message: 'Failed to fetch vehicles'));
    provideDummy<Result<List<VehicleEntity>>>(expectedVehicleSuccessResult);
    provideDummy<Result<List<VehicleEntity>>>(expectedVehicleFailureResult);
    provideDummy<Result<List<CountryEntity>>>(expectedCountrySuccessResult);
    provideDummy<Result<List<CountryEntity>>>(expectedCountryFailureResult);
    provideDummy<Result<void>>(expectedApplySuccessResult);
    provideDummy<Result<void>>(expectedApplyFailureResult);
  });
  setUp((){
    when(mockGetAllCountriesUseCase.invoke())
      .thenAnswer((_) async => expectedCountrySuccessResult);
    when(mockGetAllVehiclesUseCase.invoke())
      .thenAnswer((_) async => expectedVehicleSuccessResult);
    applyCubit = ApplyCubit(
      mockGetAllCountriesUseCase,
      mockGetAllVehiclesUseCase,
      mockApplyUseCase,
    );
     applyCubit.emit(
      applyCubit.state.copyWith(
        idImage: XFile(nidFile.path),
        vehicleLicenseImage: XFile(licenseFile.path),
      ),
    );
    applyCubit.doIntent(intent:  const ApplyInitializationIntent());
    applyCubit.applyFormKey =FakeGlobalKey(FakeFormState());
  });
  group('ApplyCubit', (){
    blocTest<ApplyCubit,ApplyState>('emits [loading,success] when apply is successful', 
    build:(){

     when(mockApplyUseCase.invoke(request: anyNamed('request')))
        .thenAnswer((_) async => expectedApplySuccessResult);
      return applyCubit;
    },act:(cubit) =>[
       cubit.doIntent(intent: const ApplyFormIntent())],
    expect: ()=>[
      isA<ApplyState>().having((state)=>state.applyStatus.isLoading, 
      'isLoading', equals(true)),
      isA<ApplyState>().having((state)=>state.applyStatus.isSuccess, 
      'isSuccess', equals(true)),
    ],
    verify: (cubit){
      verify(mockApplyUseCase.invoke(request: anyNamed('request'))).called(1);
    });

    blocTest<ApplyCubit,ApplyState>('emits [loading,failure] when apply is unsuccessful', 
    build:(){

     when(mockApplyUseCase.invoke(request: anyNamed('request')))
        .thenAnswer((_) async => expectedApplyFailureResult);
      return applyCubit;
    },act:(cubit) =>[
       cubit.doIntent(intent: const ApplyFormIntent())],
    expect: ()=>[
      isA<ApplyState>().having((state)=>state.applyStatus.isLoading, 
      'isLoading', equals(true)),
      isA<ApplyState>().having((state)=>state.applyStatus.isFailure, 
      'isFailure', equals(true)),
    ],
    verify: (cubit){
      verify(mockApplyUseCase.invoke(request: anyNamed('request'))).called(1);
    });
  });

  group('ApplyCubit - Countries', () {
    
  blocTest<ApplyCubit, ApplyState>(
    'emits [loading,success] when fetching countries is successful',
    setUp: () {
      // Reset mocks to clear previous calls
      reset(mockGetAllCountriesUseCase);
      reset(mockGetAllVehiclesUseCase);
    },
    build: () {
      when(mockGetAllCountriesUseCase.invoke())
          .thenAnswer((_) async => expectedCountrySuccessResult);
      when(mockGetAllVehiclesUseCase.invoke())
          .thenAnswer((_) async => expectedVehicleSuccessResult);
      return ApplyCubit(
        mockGetAllCountriesUseCase,
        mockGetAllVehiclesUseCase,
        mockApplyUseCase,
      );
    },
    act: (cubit) => cubit.doIntent(intent: const ApplyInitializationIntent()),
    skip: 2, // Skip the first 2 emissions (countries loading, vehicles loading)
    expect: () => [
      isA<ApplyState>()
          .having((state) => state.countryStatus.isSuccess, 'isSuccess',
              equals(true))
          .having((state) => state.countryStatus.data!.length, 'countries length',
              equals(1))
          .having((state) => state.countryStatus.data!.first.countryName,
              'first country name', equals('USA')),
      isA<ApplyState>()
          .having((state) => state.vehicleStatus.isSuccess, 'isSuccess',
              equals(true))
          .having(
              (state) => state.vehicleStatus.data!.length, 'vehicles length', equals(1))
          .having((state) => state.vehicleStatus.data!.first.type, 'first vehicle type',
              equals('Car')),
    ],
    verify: (cubit) {
      verify(mockGetAllCountriesUseCase.invoke()).called(1);
      verify(mockGetAllVehiclesUseCase.invoke()).called(1);
    },
  );

  blocTest<ApplyCubit, ApplyState>(
    'emits [loading,failure] when fetching countries is unsuccessful',
     setUp: () {
      reset(mockGetAllCountriesUseCase);
      reset(mockGetAllVehiclesUseCase);
    },
    build: () {
      when(mockGetAllCountriesUseCase.invoke())
          .thenAnswer((_) async => expectedCountryFailureResult);
      when(mockGetAllVehiclesUseCase.invoke())
          .thenAnswer((_) async => expectedVehicleSuccessResult);
      return ApplyCubit(
        mockGetAllCountriesUseCase,
        mockGetAllVehiclesUseCase,
        mockApplyUseCase,
      );
    },
    act: (cubit) => cubit.doIntent(intent: const ApplyInitializationIntent()),
    skip: 2, // Skip the first 2 emissions (countries loading, vehicles loading)
    expect: () => [
      isA<ApplyState>()
          .having((state) => state.countryStatus.isFailure, 'isFailure',
              equals(true))
          .having((state) => state.countryStatus.data, 'countries', isNull),
      isA<ApplyState>()
          .having((state) => state.vehicleStatus.isSuccess, 'isSuccess',
              equals(true)),
    ],
    verify: (cubit) {
      verify(mockGetAllCountriesUseCase.invoke()).called(1);
      verify(mockGetAllVehiclesUseCase.invoke()).called(1);
    },
  );
});

group('ApplyCubit - Vehicles', () {
  blocTest<ApplyCubit, ApplyState>(
    'emits [loading,success] when fetching vehicles is successful',
     setUp: () {
      reset(mockGetAllCountriesUseCase);
      reset(mockGetAllVehiclesUseCase);
    },
    build: () {
      when(mockGetAllCountriesUseCase.invoke())
          .thenAnswer((_) async => expectedCountrySuccessResult);
      when(mockGetAllVehiclesUseCase.invoke())
          .thenAnswer((_) async => expectedVehicleSuccessResult);
      return ApplyCubit(
        mockGetAllCountriesUseCase,
        mockGetAllVehiclesUseCase,
        mockApplyUseCase,
      );
    },
    act: (cubit) => cubit.doIntent(intent: const ApplyInitializationIntent()),
    skip: 2, // Skip the first 2 emissions (countries loading, vehicles loading)
    expect: () => [
      isA<ApplyState>()
          .having((state) => state.countryStatus.isSuccess, 'isSuccess',
              equals(true)),
      isA<ApplyState>()
          .having((state) => state.vehicleStatus.isSuccess, 'isSuccess',
              equals(true))
          .having(
              (state) => state.vehicleStatus.data!.length, 'vehicles length', equals(1))
          .having((state) => state.vehicleStatus.data!.first.type, 'first vehicle type',
              equals('Car')),
    ],
    verify: (cubit) {
      verify(mockGetAllCountriesUseCase.invoke()).called(1);
      verify(mockGetAllVehiclesUseCase.invoke()).called(1);
    },
  );

  blocTest<ApplyCubit, ApplyState>(
    'emits [loading,failure] when fetching vehicles is unsuccessful',
     setUp: () {
      reset(mockGetAllCountriesUseCase);
      reset(mockGetAllVehiclesUseCase);
    },
    build: () {
      when(mockGetAllCountriesUseCase.invoke())
          .thenAnswer((_) async => expectedCountrySuccessResult);
      when(mockGetAllVehiclesUseCase.invoke())
          .thenAnswer((_) async => expectedVehicleFailureResult);
      return ApplyCubit(
        mockGetAllCountriesUseCase,
        mockGetAllVehiclesUseCase,
        mockApplyUseCase,
      );
    },
    act: (cubit) => cubit.doIntent(intent: const ApplyInitializationIntent()),
    skip: 2, // Skip the first 2 emissions (countries loading, vehicles loading)
    expect: () => [
      isA<ApplyState>()
          .having((state) => state.countryStatus.isSuccess, 'isSuccess',
              equals(true)),
      isA<ApplyState>()
          .having((state) => state.vehicleStatus.isFailure, 'isFailure',
              equals(true))
          .having((state) => state.vehicleStatus.data, 'vehicles', isNull),
    ],
    verify: (cubit) {
      verify(mockGetAllCountriesUseCase.invoke()).called(1);
      verify(mockGetAllVehiclesUseCase.invoke()).called(1);
    },
  );
});
}