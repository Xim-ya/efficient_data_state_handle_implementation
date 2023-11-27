# Handling Asynchronous Data in Flutter with Generic Classes

![](https://velog.velcdn.com/images/ximya_hf/post/2bfbe6c3-bff8-43b1-b086-992d0123ce8e/image.png)

An implementation that defines data states using a generic class and returns widgets based on the current state.



### 1. Initial Data Declaration

```dart
Ds<Profile> profileInfo = Loading(); // or Loading<Profile>();
```

### 2. Fetching Data
```dart
Future<void> fetchData() async {  
  try {  
    profileInfo = Fetched(  
      User(  
        imgUrl: 'https://avatars.githubusercontent.com/u/75591730?v=4',  
        name: 'Ximya',  
        description:  
            'Lorem ipsum dolor sit amet, consectetur adipiscing ...',  
      ),  
    ); 
    log('Data successfully fetched');  
  } catch (e) {  
    profileInfo = Failed(e);  
    log('Data fetching failed. ${e}');  
  }  
}
```

### 3. Returning Widgets Based on States
```dart
final profile = controller.profileInfo;

return profile.onState(  
  fetched: (value) => ProfileCard(value),  
  failed: (e) => ErrorIndicator(e),  
  loading: () => CircularProgressIndicator(),  
);
```


## Basic Module

```dart
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

```

