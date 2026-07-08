import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure_dependency.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
