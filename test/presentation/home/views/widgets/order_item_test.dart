import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/constants/app_text.dart';
import 'package:flowery_tracking_app/core/di/di.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/accept_order_button.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/address_item.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/order_item.dart';
import 'package:flowery_tracking_app/presentation/home/views/widgets/reject_order_button.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_cubit.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_intent.dart';
import 'package:flowery_tracking_app/presentation/home/views_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_item_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Arrange
  late MockHomeCubit mockHomeCubit;
  setUp(() {
    mockHomeCubit = MockHomeCubit();
    getIt.registerFactory<HomeCubit>(() => mockHomeCubit);
    provideDummy<HomeState>(const HomeState());
    when(mockHomeCubit.state).thenReturn(const HomeState());
    when(
      mockHomeCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const HomeState()]));
  });

  final orderData = const OrderEntity(
    id: "order_1",
    user: UserEntity(
      id: "user_1",
      firstName: "Ahmed",
      lastName: "Tarek",
      email: "ahmed@example.com",
    ),
    orderItems: [
      OrderItemEntity(
        id: "item_1",
        product: ProductEntity(
          id: "prod_1",
          description: "A beautiful bouquet of red roses",
          price: 200,
        ),
        price: 200,
        quantity: 1,
      ),
    ],
    totalPrice: 200,
    shippingAddress: ShippingAddressEntity(city: "Cairo"),
    paymentType: "Cash",
    isPaid: false,
    isDelivered: false,
    state: "Processing",
    orderNumber: "ORD-001",
    store: StoreEntity(name: "Flowery Store", address: "Downtown Cairo"),
  );

  Widget prepareWidget({required OrderEntity order}) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: BlocProvider<HomeCubit>.value(
            value: mockHomeCubit
              ..doIntent(intent: const HomeInitializationIntent()),
            child: OrderItem(orderData: order),
          ),
        );
      },
    );
  }

  testWidgets("Verifying OrderItem Widgets", (tester) async {
    // Act
    await tester.pumpWidget(prepareWidget(order: orderData));
    // Assert
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.margin is REdgeInsets &&
            widget.padding is REdgeInsets &&
            widget.child is Column,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.crossAxisAlignment == CrossAxisAlignment.start &&
            widget.children.first is Text &&
            widget.children.length == 11,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.flowerOrder.tr(),
      ),
      findsOneWidget,
    );
    expect(find.byType(RSizedBox), findsNWidgets(14));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.pickupAddress.tr(),
      ),
      findsOneWidget,
    );
    expect(find.byType(AddressItem), findsNWidgets(2));

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data == AppText.userAddress.tr(),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Row && widget.children.length == 5,
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && widget.data!.contains(AppText.egp.tr()),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is RejectOrderButton,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Expanded && widget.child is AcceptOrderButton,
      ),
      findsOneWidget,
    );
  });
}
