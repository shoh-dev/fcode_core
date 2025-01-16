import 'package:myspace_core/src/data/dependency_injection/dependency_injection.dart';
import 'package:myspace_core/src/data/redux/middleware.dart';
import 'package:myspace_core/src/data/redux/reducer.dart';
import 'package:redux/redux.dart';

class AppStore<St> {
  final St initialState;
  final AppReducer<St> reducer;
  final AppMiddleware<St> _middleware;

  AppStore({
    required this.initialState,
    required this.reducer,
  }) : _middleware = AppMiddleware<St>();

  void register<T extends Object>(T di) {
    DependencyInjection.register<T>(di);
  }

  Store<St> createStore() {
    return Store<St>(
      (state, action) => reducer.reducer(state, action),
      distinct: true,
      initialState: initialState,
      middleware: [
        _middleware.call,
      ],
    );
  }
}
