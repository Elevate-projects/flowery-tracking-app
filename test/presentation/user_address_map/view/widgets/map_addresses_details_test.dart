import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
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

@GenerateMocks([OrderDetailsCubit])
void main() {
  provideDummy<OrderDetailsState>(const OrderDetailsState());
  TestWidgetsFlutterBinding.ensureInitialized();

  late OrderEntity fakeOrderData;
  late MockOrderDetailsCubit cubit;
  setUp(() {
    cubit = MockOrderDetailsCubit();
    fakeOrderData = const OrderEntity(
      user: UserEntity(
        firstName: 'John',
        lastName: 'Doe',
        phone: '+201234567890',
        photo: 'user_photo.png',
      ),
      shippingAddress: ShippingAddressEntity(
        city: 'Cairo',
        street: 'Tahrir Street',
      ),
      store: StoreEntity(
        name: 'Flower Store',
        image: 'store_photo.png',
        address: 'Nasr City, Cairo',
        phoneNumber: '+20987654321',
      ),
      // add other required fields from your OrderEntity constructor if any
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
