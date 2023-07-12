import 'package:dio/dio.dart';
import 'package:dio_authentication_client/dio_authentication_client.dart';
import 'package:dio_qwerty_api_client/dio_qwerty_api_client.dart';
import 'package:qwerty_app/app/app.dart';
import 'package:qwerty_app/bootstrap.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(() async {
    const secureStorage = SecureStorage();
    const tokenStorage = TokenStorage(storage: secureStorage);
    final httpClient = Dio(BaseOptions(baseUrl: 'http://127.0.0.1:5000'));
    final authenticationClient = DioAuthenticationClient(
      tokenStorage: tokenStorage,
      httpClient: httpClient,
    );
    final apiClient = DioQwertyApiClient(httpClient: httpClient);
    final userRepository = UserRepository(
      authenticationClient: authenticationClient,
      apiClient: apiClient,
    );
    final rickAndMortyRepository = RickAndMortyRepository(
      apiClient: apiClient,
    );
    final user = await userRepository.user.first;
    return App(
      userRepository: userRepository,
      rickAndMortyRepository: rickAndMortyRepository,
      user: user,
    );
  });
}
