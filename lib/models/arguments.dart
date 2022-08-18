import 'package:args/args.dart';
import 'arg_parser.dart';

class Arguments {
  final String inputFilePath;

  final String outputDirectoryPath;

  final String? outputFileName;

  final bool headless;

  const Arguments({
    required this.inputFilePath,
    required this.outputDirectoryPath,
    this.outputFileName,
    this.headless = true,
  });

  static Arguments? fromArgs(
    final List<String> args,
    final ArgParser parser,
  ) {
    try {
      if (args.where((x) => x.startsWith('-')).isEmpty && args.length >= 2) {
        return Arguments(
          inputFilePath: args[0],
          outputDirectoryPath: args[1],
          outputFileName: args.length > 2 ? args[2] : null,
        );
      } else {
        final parseResults = parser.parse(args);

        return Arguments(
          inputFilePath: parseResults.inputFilePath,
          outputDirectoryPath: parseResults.outputDirectoryPath,
          outputFileName: parseResults.outputFileName,
          headless: parseResults.headless,
        );
      }
    } on Object catch (_) {
      return null;
    }
  }
}
