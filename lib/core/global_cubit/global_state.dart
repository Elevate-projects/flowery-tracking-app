import 'package:flowery_tracking_app/core/exceptions/response_exception.dart';

sealed class GlobalState {}

final class GlobalInitial extends GlobalState {}

final class LoadedRedirectedScreen extends GlobalState {}

final class ChangeLanguageIndexState extends GlobalState {}

final class FetchDriverOrdersFailureState extends GlobalState {
  final ResponseException responseException;
  FetchDriverOrdersFailureState({required this.responseException});
}
