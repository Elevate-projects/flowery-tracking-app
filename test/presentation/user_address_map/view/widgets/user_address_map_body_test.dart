import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_addresses_details.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_section.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/user_address_map_body.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_cubit.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view_model/user_address_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../order_details/views/widgets/order_details_address_test.mocks.dart';
import 'map_section_test.mocks.dart';

// 🧩 Fake Models with all required fields

class _FakeUser {
  final String firstName;
  final String lastName;
  final String photo;
  final String phone;

  _FakeUser({
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.phone,
  });
}

class _FakeShippingAddress {
  final String city;
  final String street;
  final double lat;
  final double long;

  _FakeShippingAddress({
    required this.city,
    required this.street,
    required this.lat,
    required this.long,
  });
}

class _FakeStore {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;

  _FakeStore({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
  });
}

class _FakeOrderData {
  final _FakeUser user;
  final _FakeShippingAddress shippingAddress;
  final _FakeStore store;

  _FakeOrderData({
    required this.user,
    required this.shippingAddress,
    required this.store,
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  provideDummy<OrderDetailsState>(const OrderDetailsState());

  late MockOrderDetailsCubit orderDetailsCubit;
  late MockUserAddressMapCubit userAddressMapCubit;

  group('UserAddressMapBody', () {
    late _FakeOrderData fakeOrderData;

    setUp(() {
      orderDetailsCubit = MockOrderDetailsCubit();
      userAddressMapCubit = MockUserAddressMapCubit();
      fakeOrderData = _FakeOrderData(
        user: _FakeUser(
          firstName: 'John',
          lastName: 'Doe',
          photo: 'https://example.com/photo.jpg',
          phone: '+201001234567',
        ),
        shippingAddress: _FakeShippingAddress(
          city: 'Cairo',
          street: 'Tahrir Street',
          lat: 30.0444,
          long: 31.2357,
        ),
        store: _FakeStore(
          name: 'Flower Store',
          image: 'https://example.com/store.jpg',
          address: 'Giza, Egypt',
          phoneNumber: '+201009998877',
        ),
      );
      when(orderDetailsCubit.state).thenReturn(const OrderDetailsState());
      when(orderDetailsCubit.stream).thenAnswer((_) => const Stream.empty());
      when(userAddressMapCubit.state).thenReturn(const UserAddressMapState());
      when(userAddressMapCubit.stream).thenAnswer((_) => const Stream.empty());
      when(userAddressMapCubit.mapController).thenReturn(MapController());
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) => MultiBlocProvider(
            providers: [
              BlocProvider<UserAddressMapCubit>.value(
                value: userAddressMapCubit,
              ),
              BlocProvider<OrderDetailsCubit>.value(value: orderDetailsCubit),
            ],
            child: Scaffold(body: UserAddressMapBody(orderData: fakeOrderData)),
          ),
        ),
      );
    }

    testWidgets('renders MapSection and MapAddressesDetails in main Stack', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(MapSection), findsOneWidget);
      expect(find.byType(MapAddressesDetails), findsOneWidget);
    });
  });
}
