sealed class LoginEvents {
  const LoginEvents();
  factory LoginEvents.loginUserEvent({
    required String email,
    required String password,
  }) = LoginUserEvent;

  void when({required Function(String email, String password) loginUserEvent}) {
    switch (this) {
      case LoginUserEvent(:final email, :final password):
        loginUserEvent(email, password);
    }
  }
}

class LoginUserEvent extends LoginEvents {
  const LoginUserEvent({required this.email, required this.password});

  final String email;
  final String password;
}
