import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_do/app/auth/data/datasources/auth_datasource.dart';
import 'package:simple_do/app/auth/data/repositories/auth_repository.dart';
import 'package:simple_do/app/auth/domain/repositories/base_auth_repository.dart';
import 'package:simple_do/app/auth/domain/usecases/get_me_usecase.dart';
import 'package:simple_do/app/auth/domain/usecases/login_usecase.dart';
import 'package:simple_do/app/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:simple_do/app/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_do/app/tasks/data/datasources/tasks_datasource.dart';
import 'package:simple_do/app/tasks/domain/usecases/add_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/update_task_usecase.dart';
import 'package:simple_do/app/tasks/domain/usecases/view_task_usecase.dart';
import 'package:simple_do/app/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:simple_do/src/core/data_sources/remote/services/tasks_services.dart';

import '../../app/tasks/data/datasources/local_tasks_datasource.dart';
import '../../app/tasks/data/repositories/tasks_repository.dart';
import '../../app/tasks/domain/repositories/base_tasks_repository.dart';
import '../../app/tasks/domain/usecases/delete_task_usecase.dart';
import '../../flavors.dart';
import '../core/data_sources/remote/services/auth_services.dart';
import '../core/data_sources/local/local_storage.dart';
import '../core/data_sources/remote/helpers/interceptor.dart';
import '../utils/dotenv_keys.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  static setup() async {
    setupFlavor();
    await _setupLocalStorage();
    _injectNetworkingDependencies();
    _injectDataSources();
    _injectRepositories();
    _injectUseCases();
    _injectBlocs();
  }

  static _injectDataSources() async {
    getIt.registerLazySingleton<BaseAuthDataSource>(
        () => AuthDataSource(service: getIt<AuthServices>()));
    getIt.registerLazySingleton<BaseTasksDataSource>(
        () => TasksDataSource(service: getIt<TasksServices>()));
    getIt.registerLazySingleton<BaseLocalTasksDataSource>(
        () => LocalTasksDataSource());
  }

  static _injectRepositories() {
    getIt.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepository(getIt()));
    getIt.registerLazySingleton<BaseTasksRepository>(() => TasksRepository(
          getIt(),
          getIt(),
        ));
  }

  static _injectUseCases() {
    // Auth
    getIt.registerLazySingleton(() => LoginUseCase(getIt()));
    getIt.registerLazySingleton(() => GetMeUsecase(getIt()));
    getIt.registerLazySingleton(() => RefreshTokenUsecase(getIt()));

    // Tasks
    getIt.registerLazySingleton(() => GetTasksUsecase(getIt()));
    getIt.registerLazySingleton(() => ViewTaskUsecase(getIt()));
    getIt.registerLazySingleton(() => AddTaskUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateTaskUsecase(getIt()));
    getIt.registerLazySingleton(() => DeleteTaskUsecase(getIt()));
  }

  static _injectBlocs() {
    getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<LoginUseCase>(),
        getIt<GetMeUsecase>(), getIt<RefreshTokenUsecase>()));
    getIt.registerFactory<TasksBloc>(() => TasksBloc(
          getIt<GetTasksUsecase>(),
          getIt<ViewTaskUsecase>(),
          getIt<AddTaskUsecase>(),
          getIt<UpdateTaskUsecase>(),
          getIt<DeleteTaskUsecase>(),
        ));
  }

  static Future _setupLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    getIt.registerSingleton<LocalStorage>(LocalStorage(pref));
  }

  static Dio _injectDio() {
    Dio dio = Dio();
    dio.interceptors.clear();
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.interceptors.add(RemoteInterceptor(getIt.get<LocalStorage>()));
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ));
    }
    getIt.registerSingleton<Dio>(dio);
    return dio;
  }

  static _injectApiServices(Dio dio, String baseUrl) {
    getIt.registerLazySingleton<AuthServices>(
        () => AuthServices(dio, baseUrl: baseUrl));
    getIt.registerLazySingleton<TasksServices>(
        () => TasksServices(dio, baseUrl: baseUrl));
  }

  static _injectNetworkingDependencies() {
    final dio = _injectDio();
    final String baseUrl = getIt.get<FlavorConfig>().baseUrl;
    _injectApiServices(dio, baseUrl);
  }

  static void setupFlavor() {
    late FlavorConfig flavorConfig;
    switch (F.appFlavor!) {
      case Flavor.dev:
        flavorConfig = FlavorConfig(
          flavor: Flavor.dev,
          baseUrl: dotenv.get(DotenvKeys.baseUrlDev),
        );
        break;
      case Flavor.production:
        flavorConfig = FlavorConfig(
          flavor: Flavor.production,
          baseUrl: dotenv.get(DotenvKeys.baseUrl),
        );
        break;
    }
    getIt.registerSingleton<FlavorConfig>(flavorConfig);
  }
}
