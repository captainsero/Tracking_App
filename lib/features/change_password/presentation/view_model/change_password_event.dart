import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';

class ChangePasswordEvent {
  final ChangePasswordRequest passwords;

  ChangePasswordEvent({required this.passwords});
}
