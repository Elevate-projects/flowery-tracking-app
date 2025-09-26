sealed class LoginIntent {}

final class InitializeLoginFormIntent extends LoginIntent {}

final class ToggleObscurePasswordIntent extends LoginIntent {}

final class ToggleRememberMeIntent extends LoginIntent {}

final class LoginWithEmailAndPasswordIntent extends LoginIntent {}

final class CheckFieldsValidationIntent extends LoginIntent {}

final class EnableValidationIntent extends LoginIntent {}
