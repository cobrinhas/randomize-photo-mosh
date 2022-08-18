import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
import 'package:randomize_photo_mosh/automation/delays.dart';

Future<void> setDownloadFileId({
  required final String photoId,
  required final Page page,
}) {
  return page.evaluate(
    '() => {Date.prototype.getFullYear = function(){return "$photoId"}}',
  );
}

Future<File> waitForDownload({
  required final Directory outputDirectory,
  required final String photoId,
}) async {
  return Future(
    () async {
      while (true) {
        final existingFiles = outputDirectory.listSync();

        final moshedDownloadFiles = existingFiles.where(
          (f) => f.path.contains(photoId),
        );

        if (moshedDownloadFiles.isNotEmpty) {
          return moshedDownloadFiles.last as File;
        } else {
          await Future.delayed(waitForDownloadDuration);
        }
      }
    },
  ).timeout(waitTimeoutDuration);
}

Future<File> renameDownloadedFile({
  required final File downloadedFile,
  required final String fileName,
}) {
  return downloadedFile.rename(fileName);
}
