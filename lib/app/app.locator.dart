import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({String? environment, EnvironmentFilter? environmentFilter}) async {
  locator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);
  // locator.registerLazySingleton(() => Botto)
  locator.registerLazySingleton(() => NavigationService());
}