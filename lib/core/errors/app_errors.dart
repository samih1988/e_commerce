abstract class AppErrors {
  String errorMessage;
  AppErrors({required this.errorMessage});
}
class ServerError extends AppErrors{
  ServerError({String message='Server is Down Up Please Try Again'}):super(errorMessage: message);
}
class NetworkError extends AppErrors{
  NetworkError({String message='No Internet Connection Please Try Again'}):super(errorMessage: message);
}
class UnknownError extends AppErrors{
  UnknownError({String message='Somethings went wrong Please Try Again'}):super(errorMessage: message);
}