import 'package:args/args.dart';

const _kInputFilePathArgumentName = 'input';
const _kInputFilePathArgumentAbbreviation = 'i';
const _kInputFilePathArgumentHelp =
    'Specifies the file path of the .jpeg/.png to mosh';

const _kOutputDirectoryPathArgumentName = 'output';
const _kOutputDirectoryPathArgumentAbbreviation = 'o';
const _kOutputDirectoryPathArgumentHelp =
    'Specifies the output directory path where the moshed photo will appear';

const _kOutputFileNameArgumentName = 'name';
const _kOutputFileNameArgumentAbbreviation = 'n';
const _kOutputFileNameArgumentHelp =
    'Specifies the file name of the moshed photo';

const _kHeadfulArgumentName = 'headful';
const _kHeadfulArgumentAbbreviation = 'h';
const _kHeadfulArgumentNameHelp =
    'Specifies whether the automation should run in headful or headless mode. (defaults to headless)';

ArgParser programArgParser() {
  final parser = ArgParser();

  parser.addOption(
    _kInputFilePathArgumentName,
    abbr: _kInputFilePathArgumentAbbreviation,
    help: _kInputFilePathArgumentHelp,
    mandatory: true,
  );

  parser.addOption(
    _kOutputDirectoryPathArgumentName,
    abbr: _kOutputDirectoryPathArgumentAbbreviation,
    help: _kOutputDirectoryPathArgumentHelp,
    mandatory: true,
  );

  parser.addOption(
    _kOutputFileNameArgumentName,
    abbr: _kOutputFileNameArgumentAbbreviation,
    help: _kOutputFileNameArgumentHelp,
    mandatory: false,
  );

  parser.addFlag(
    _kHeadfulArgumentName,
    abbr: _kHeadfulArgumentAbbreviation,
    help: _kHeadfulArgumentNameHelp,
    defaultsTo: false,
  );

  return parser;
}

extension ArgResultsExtension on ArgResults {
  String get inputFilePath => this[_kInputFilePathArgumentName];

  String get outputDirectoryPath => this[_kOutputDirectoryPathArgumentName];

  String? get outputFileName => this[_kOutputFileNameArgumentName];

  bool get headless => !this[_kHeadfulArgumentName];
}
