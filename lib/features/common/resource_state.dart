enum ApiStatus {
  initial, loading, error, success
}

class ResourceState<T> {
  String? errorMessage;
  ApiStatus? status;
  T? data;

  ResourceState({this.status, this.errorMessage, this.data});

  ResourceState.initial() {
    status = ApiStatus.initial;
  }

  ResourceState.error({this.errorMessage}) {
    status = ApiStatus.error;
  }

  ResourceState.loading() {
    status = ApiStatus.loading;
  }

  ResourceState.success({this.data}) {
    status = ApiStatus.success;
  }

  bool get isSuccess => status == ApiStatus.success;
  bool get isLoading => status == ApiStatus.loading;
  bool get isError => status == ApiStatus.error;
  bool get isInitial => status == ApiStatus.initial;
}