import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'package:loans/3_utils/bloc_observer.dart';
import 'package:loans/app.dart';
import 'package:loans/injection_container.dart';

final _logger = Logger('main');

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Configurar HydratedBloc para persistencia de estado
      final documentsDir = await getApplicationDocumentsDirectory();
      final storage = await HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory(documentsDir.path),
      );
      HydratedBloc.storage = storage;

      // Configurar logging
      _setupLogging();

      // Configurar BlocObserver para monitorear eventos de BLoC
      Bloc.observer = MyLendsBlocObserver();

      // Manejar errores globales de Flutter
      FlutterError.onError = (errorDetails) {
        _logger.severe(
          'FlutterError',
          errorDetails.exception,
          errorDetails.stack,
        );
      };

      // Manejar errores que no son capturados por Flutter
      PlatformDispatcher.instance.onError = (error, stack) {
        _logger.severe('PlatformDispatcher error', error, stack);
        return true;
      };

      // Configurar todas las dependencias
      await setupServiceLocator();
      runApp(const MyLendsApp());
    },
    (error, stack) {
      _logger.severe('Uncaught exception', error, stack);
    },
  );
}

void _setupLogging() {
  // Configurar el sistema de logging
  hierarchicalLoggingEnabled = true;

  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;

  Logger.root.onRecord.listen((record) {
    final message = '''
[${record.time}] ${record.level.name}: ${record.loggerName}
${record.message}
${record.error != null ? 'Error: ${record.error}\n' : ''}
${record.stackTrace != null ? 'Stack: ${record.stackTrace}' : ''}
''';

    // En debug, imprimir en consola
    if (kDebugMode) {
      print(message);
    }
  });
}
