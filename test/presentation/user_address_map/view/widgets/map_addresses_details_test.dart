import 'package:flowery_tracking_app/presentation/order_details/views/widgets/order_details_address.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_state.dart';
import 'package:flowery_tracking_app/presentation/user_address_map/view/widgets/map_addresses_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_addresses_details_test.mocks.dart';

/// Fake models matching the widget structure
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

  _FakeShippingAddress({required this.city, required this.street});
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

@GenerateMocks([OrderDetailsCubit])
void main() {
  provideDummy<OrderDetailsState>(const OrderDetailsState());
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeOrderData fakeOrderData;
  late MockOrderDetailsCubit cubit;
  setUp(() {
    cubit = MockOrderDetailsCubit();
    fakeOrderData = _FakeOrderData(
      user: _FakeUser(
        firstName: 'John',
        lastName: 'Doe',
        photo: 'user_photo.png',
        phone: '+201234567890',
      ),
      shippingAddress: _FakeShippingAddress(
        city: 'Cairo',
        street: 'Tahrir Street',
      ),
      store: _FakeStore(
        name: 'Flower Store',
        image: 'store_photo.png',
        address: 'Nasr City, Cairo',
        phoneNumber: '+20987654321',
      ),
    );

    when(cubit.state).thenReturn(const OrderDetailsState());
    when(cubit.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) => BlocProvider<OrderDetailsCubit>.value(
          value: cubit,
          child: Scaffold(body: MapAddressesDetails(orderData: fakeOrderData)),
        ),
      ),
    );
  }

  testWidgets('renders user and pickup address sections correctly', (
    tester,
  ) async {
    // ARRANGE

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // ASSERT
    expect(find.textContaining('John Doe'), findsOneWidget);
    expect(find.textContaining('Cairo, Tahrir Street'), findsOneWidget);
    expect(find.textContaining('Flower Store'), findsOneWidget);
    expect(find.textContaining('Nasr City, Cairo'), findsOneWidget);

    // Two address widgets should be rendered
    expect(find.byType(OrderDetailsAddress), findsNWidgets(2));
  });
}
