import 'package:shopapp/models/registermodel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorsState extends RegisterStates {}

class RegisterDoneState extends RegisterStates {
  RegisterParse? registerFromApi;
  RegisterDoneState({this.registerFromApi});
}

class ChangeEyeState extends RegisterStates {}
