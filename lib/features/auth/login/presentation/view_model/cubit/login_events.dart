sealed class LoginEvents {
  const LoginEvents();
  factory LoginEvents.loginUserEvent() = LoginUserEvent;

  void when({required Function() loginUserEvent}) {
    switch (this) {
      case LoginUserEvent():
        loginUserEvent();
    }
  }
}

class LoginUserEvent extends LoginEvents {
  const LoginUserEvent();
}
