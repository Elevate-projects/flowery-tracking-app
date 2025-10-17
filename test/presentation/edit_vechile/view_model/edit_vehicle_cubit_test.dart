import 'package:flowery_tracking_app/domain/use_cases/edit_vehicle/edit_vehicle_use_case.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_cubit.dart';
import 'package:flowery_tracking_app/presentation/edit_vechile/view_model/edit_vehicle_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'edit_vehicle_cubit_test.mocks.dart';
@GenerateMocks([EditVehicleUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late EditVehicleCubit cubit;
  late MockEditVehicleUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockEditVehicleUseCase();
    cubit = EditVehicleCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('EditVehicleCubit', () {
    test('initial state is correct (assuming no initial data)', () {
      expect(cubit.state.isFormValid, isFalse);
      expect(cubit.state.editVehicleStatus.isInitial, isTrue);
    });
    group('Form Validation', () {
      test('isFormValid becomes true when all fields are filled', () {
        // Arrange: Start with an invalid form
        expect(cubit.state.isFormValid, isFalse);
        // Act: Fill all controllers
        cubit.vehicleTypeController.text = 'Car';
        cubit.vehicleNumberController.text = '12345';
        cubit.vehicleLicenseController.text = 'LICENSE123';
        // Assert: The form should now be valid
        expect(cubit.state.isFormValid, isTrue);
      });
      test('isFormValid becomes false if a field is cleared', () {
        // Arrange: Start with a valid form
        cubit.vehicleTypeController.text = 'Car';
        cubit.vehicleNumberController.text = '12345';
        cubit.vehicleLicenseController.text = 'LICENSE123';
        expect(cubit.state.isFormValid, isTrue,);
        // Act: Clear one of the controllers
        cubit.vehicleNumberController.clear();
        // Assert: The form should now be invalid
        expect(cubit.state.isFormValid, isFalse);
      });
      test('will test doIntent method', () {
        cubit.onIntent(SubmitEditVehicle());
        expect(cubit.state.isFormValid, isFalse);
      });
    });
  });
}