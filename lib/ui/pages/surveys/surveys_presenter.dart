import 'dart:async';

abstract class SurveysPresenter {
  Stream<bool> get isLoadingStream;

  Future<void> loadData();
}
