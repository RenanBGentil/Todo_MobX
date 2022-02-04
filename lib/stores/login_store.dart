import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  // _LoginStore(){
  //   autorun((_){
  //     print(isEmailValid);
  //     print(isPasswordValid);
  //     print(email);
  //     print(password);
  //     print(isFormValid);
  //     print(passwordVisible);
  //     print(togglePasswordVisibility);
  //   });
  // }

  @observable
  String email = "";

  @action
  setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @observable
  bool loading = false;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @observable
  bool loggedIn = false;

  @computed
  bool get isEmailValid => RegExp(
          r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)")
      .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  VoidCallback? get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @action
  void logout() {
    loggedIn = false;
  }
}
