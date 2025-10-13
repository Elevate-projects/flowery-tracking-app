import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  provideDummy<OrderDetailsState>(const OrderDetailsState());
  provideDummy<UserAddressMapState>(const UserAddressMapState());

  late MockOrderDetailsCubit orderDetailsCubit;
  late MockUserAddressMapCubit userAddressMapCubit;

  group('UserAddressMapBody', () {
    late OrderEntity fakeOrderData;

    setUp(() {
      orderDetailsCubit = MockOrderDetailsCubit();
      userAddressMapCubit = MockUserAddressMapCubit();
      fakeOrderData = const OrderEntity();
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
