// ignore_for_file: constant_identifier_names

abstract class BaseBloc {
  void init();
  void dispose();
}

enum UIState { LOADING, SUCCESS, ERROR, UPDATED, NONE }
