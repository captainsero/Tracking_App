import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty || args.first.trim().isEmpty) {
    stderr.writeln('Usage: dart generate_feature.dart <feature_name>');
    exit(1);
  }

  final featureName = args.first.trim().toLowerCase();
  final featureClass = _toPascalCase(featureName);

  final baseDir = Directory('lib/features/$featureName');

  if (baseDir.existsSync()) {
    stdout.writeln('Feature "$featureName" already exists.');
    return;
  }

  final directories = [
    // API
    '${baseDir.path}/api/api_client',
    '${baseDir.path}/api/data_sources',

    // DATA
    '${baseDir.path}/data/data_sources',
    '${baseDir.path}/data/models',
    '${baseDir.path}/data/repo',

    // DOMAIN
    '${baseDir.path}/domain/entities',
    '${baseDir.path}/domain/repo',
    '${baseDir.path}/domain/use_cases',

    // PRESENTATION
    '${baseDir.path}/presentation/view',
    '${baseDir.path}/presentation/view_model',
    '${baseDir.path}/presentation/widgets',
  ];

  for (final path in directories) {
    Directory(path).createSync(recursive: true);
  }

  final files = <String, String>{
    // API
    '${baseDir.path}/api/api_client/${featureName}_api_client.dart':
        '// TODO: ${featureClass}ApiClient',

    '${baseDir.path}/api/data_sources/${featureName}_local_data_source_impl.dart':
        '// TODO: ${featureClass}LocalDataSourceImpl',

    '${baseDir.path}/api/data_sources/${featureName}_remote_data_source_impl.dart':
        '// TODO: ${featureClass}RemoteDataSourceImpl',

    // DATA
    '${baseDir.path}/data/data_sources/${featureName}_local_data_source_contract.dart':
        '// TODO: ${featureClass}LocalDataSourceContract',

    '${baseDir.path}/data/data_sources/${featureName}_remote_data_source_contract.dart':
        '// TODO: ${featureClass}RemoteDataSourceContract',

    '${baseDir.path}/data/repo/${featureName}_repo_impl.dart':
        '// TODO: ${featureClass}RepoImpl',

    // DOMAIN
    '${baseDir.path}/domain/repo/${featureName}_repo.dart':
        '// TODO: ${featureClass}Repo',

    // PRESENTATION
    '${baseDir.path}/presentation/view/${featureName}_view.dart': _generateView(
      featureClass,
    ),

    '${baseDir.path}/presentation/view_model/${featureName}_cubit.dart':
        '// TODO: ${featureClass}Cubit',

    '${baseDir.path}/presentation/view_model/${featureName}_event.dart':
        '// TODO: ${featureClass}Event',

    '${baseDir.path}/presentation/view_model/${featureName}_state.dart':
        '// TODO: ${featureClass}State',

    '${baseDir.path}/presentation/widgets/${featureName}_body.dart':
        '// TODO: ${featureClass}Body',
  };

  for (final entry in files.entries) {
    File(entry.key).writeAsStringSync('${entry.value}\n');
  }

  stdout.writeln('✅ Feature "$featureName" created successfully');
}

String _toPascalCase(String value) {
  return value
      .split('_')
      .where((e) => e.isNotEmpty)
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join();
}

String _generateView(String className) {
  return '''
import 'package:flutter/material.dart';

class ${className}View extends StatelessWidget {
  const ${className}View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('$className View'),
      ),
    );
  }
}
''';
}

// To run this script, use the command:
// dart lib/generate_feature.dart <feature_name>
// dart lib/generate_feature.dart <feature_name>
