abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class ChangeSuffixIconState extends RegisterStates {}

class ToastState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}
class OnStepContinueState extends RegisterStates {}
class OnStepCancelState extends RegisterStates {}
class OnStepTapState extends RegisterStates {}
class DropChangeState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}
class CreateUserLoadingState extends RegisterStates {}
class CreateUserSucceedState extends RegisterStates {
  final String uId;
  CreateUserSucceedState(this.uId);
}

class RegisterErrorState extends RegisterStates {
  final error;

  RegisterErrorState(this.error);
}

