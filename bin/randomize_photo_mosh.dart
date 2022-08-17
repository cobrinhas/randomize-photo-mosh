import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
import 'package:randomize_photo_mosh/randomize_photo_mosh.dart';

void main() async {
  // Download the Chromium binaries, launch it and connect to the "DevTools"
  final browser = await puppeteer.launch(
    headless: true,
  );

  final inputFile = File(
    'example/input/eevee.png',
  );

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
    downloadPath: '/example/output',
  );

  final saveButtonElement = await myPage.$(
    saveButtonSelectorExpression,
  );

  // Click save button
  print('Clicking save button...');
  await saveButtonElement.click();

  // Gracefully close the browser's process
  await browser.close();
}
