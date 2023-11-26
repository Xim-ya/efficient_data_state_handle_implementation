sealed class Ds<T> {
  Ds({required this.state, this.error, this.valueOrNull});

  T? valueOrNull;
  Object? error;
  DataState state;

  T get value => valueOrNull!;

  R onState<R>({
    required R Function(T data) fetched,
    required R Function(Object error) failed,
    required R Function() loading,
  }) {
    if (state.isFailed) {
      return failed(error!);
    } else if (state.isLoading) {
      return loading();
    } else {
      return fetched(valueOrNull as T);
    }
  }
}

class Fetched<T> extends Ds<T> {
  final T data;

  Fetched(this.data) : super(state: DataState.fetched, valueOrNull: data);
}

class Loading<T> extends Ds<T> {
  Loading() : super(state: DataState.loading);
}

class Failed<T> extends Ds<T> {
  final Object error;

  Failed(this.error) : super(state: DataState.failed, error: error);
}

enum DataState {
  fetched,
  loading,
  failed;

  bool get isFetched => this == DataState.fetched;

  bool get isLoading => this == DataState.loading;

  bool get isFailed => this == DataState.failed;
}
