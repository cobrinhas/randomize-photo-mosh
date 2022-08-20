import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
import 'package:randomize_photo_mosh/randomize_photo_mosh.dart';

void main(final List<String> args) async {
  final parser = programArgParser();

  final arguments = Arguments.fromArgs(args, parser);

  if (arguments == null) {
    print(
      'Welcome to randomize-photo-mosh! Below are the mandatory arguments you need to specify.',
    );
    print(parser.usage);
  } else {
    // Download the Chromium binaries, launch it and connect to the "DevTools"
    final browser = await puppeteer.launch(
      headless: arguments.headless,
    );

    final inputFile = File(
      arguments.inputFilePath,
    );

    final outputFolder = Directory(
      arguments.outputDirectoryPath,
    );

    final outputFileName = arguments.outputFileName;

    final outputMode = arguments.outputMode;

    final photoId = DateTime.now().millisecondsSinceEpoch.toString();

    // Open a new tab
    print('Starting browser engine...');
    final myPage = await browser.newPage();

    // Go to a page and wait to be fully loaded
    print('Loading $photoMoshUrl in a new tab...');
    await myPage.goto(photoMoshUrl, wait: Until.networkIdle);

    final loadFileElement = await myPage.$(
      loadFileSelectorExpression,
    );

    // Click load file
    print('Clicking load file button...');
    await loadFileElement.click();

    final fileInputElement = await myPage.$(
      fileInputSelectorExpression,
    );

    // Upload file to file input
    print('Uploading ${inputFile.path} to input file box...');
    await fileInputElement.uploadFile(
      [inputFile],
    );

    final moshButtonElement = await myPage.$(
      moshButtonSelectorExpression,
    );

    // Click mosh button
    print('Clicking mosh button...');
    await moshButtonElement.click();

    await myPage.devTools.browser.setDownloadBehavior(
      'allow',
      downloadPath: outputFolder.path,
    );

    await setDownloadFileId(
      photoId: photoId,
      page: myPage,
    );

    await saveMoshedPhoto(
      page: myPage,
      outputMode: outputMode,
    );

    print('Waiting for moshed photo to be downloaded...');
    final downloadedFile = await waitForDownload(
      outputDirectory: outputFolder,
      photoId: photoId,
    );

    print('Downloaded.');

    if (outputFileName != null) {
      print('Renaming output file name of moshed photo...');

      final renamedFile = await renameDownloadedFile(
        downloadedFile: downloadedFile,
        fileName: outputFileName,
      );

      print('Renamed (${renamedFile.path})');
    }

    print('All done. Closing browser engine and exiting.');
    // Gracefully close the browser's process
    await browser.close();
  }
}

Future<void> saveMoshedPhoto({
  required final Page page,
  required OutputMode outputMode,
}) async {
  switch (outputMode) {
    case OutputMode.webm:
      final webmOptionElement = await page.$(
        webmOptionSelectorExpression,
      );

      // Click webm option
      print('Clicking webm option...');
      await webmOptionElement.click();
      break;
    case OutputMode.gif:
      final gifOptionElement = await page.$(
        gifOptionSelectorExpression,
      );

      // Click gif option
      print('Clicking gif option...');
      await gifOptionElement.click();
      break;
    case OutputMode.jpeg:
    default:
      break;
  }

  final saveButtonElement = await page.$(
    saveButtonSelectorExpression,
  );

  // Click save button
  print('Clicking save button...');
  await saveButtonElement.click();
}
