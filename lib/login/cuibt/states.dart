abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}
class ChangeSuffixIconState extends LoginStates {}
class GetUsersLoadingState extends LoginStates {}
class GetUsersSuccessState extends LoginStates {}
class GetUsersErrorState extends LoginStates {}

class LoginSuccessState extends LoginStates {}
class LoginVerifyState extends LoginStates {}

class LoginErrorState extends LoginStates {

  final error;


  LoginErrorState(this.error);
}