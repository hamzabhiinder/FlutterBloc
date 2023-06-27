import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class ImageDownloader extends StatefulWidget {
  @override
  _ImageDownloaderState createState() => _ImageDownloaderState();
}

class _ImageDownloaderState extends State<ImageDownloader> {
  String csvFile =
      'assets/csvfile/countries.csv'; // Replace with the path to your CSV file

  @override
  void initState() {
    super.initState();
    downloadImagesFromCsv();
  }

  // Future<void> downloadImagesFromCsv() async {
  //   final csvData = await rootBundle.loadString(csvFile);
  //   final List<List<dynamic>> rows =
  //       const CsvToListConverter().convert(csvData);

  //   final Directory? outputDirectory = await getExternalStorageDirectory();
  //   final String outputPath = outputDirectory!.path;

  //   for (var row in rows) {
  //     final imageUrl = row[7]; // Assuming the image URL is in the 8th column
  //     log("imageUrl $imageUrl");
  //     final imageName =
  //         row[1] + '.png'; // Assuming the country name is in the 2nd column
  //     log("imageName $imageName");

  //     final imagePath = '$outputPath/$imageName';

  //     log("imagePath $imagePath");
  //     await downloadImage(imageUrl, imagePath);
  //   }
  // }

  Future<void> downloadImagesFromCsv() async {
    final csvData = await rootBundle.loadString(csvFile);
    final List<List<dynamic>> rows =
        const CsvToListConverter().convert(csvData);

    final Directory? outputDirectory = await getExternalStorageDirectory();
    final String outputPath = outputDirectory!.path;
    for (int i = 188; i < rows.length; i++) {
      final row = rows[i];
      final imageUrl = row[7]; // Assuming the image URL is in the 8th column
      log("imageUrl $imageUrl");
      final imageName =
          row[1] + '.png'; // Assuming the country name is in the 2nd column
      log("imageName $imageName");

      final imagePath = '$outputPath/$imageName';

      log("imagePath $imagePath");
      await downloadImage(imageUrl, imagePath);
    }
  }

  Future<void> downloadImage(String url, String destination) async {
    Future.delayed(const Duration(seconds: 5));

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(destination);
      log("File  is $file");
      await file.writeAsBytes(response.bodyBytes);
    } else {
      log("ERROR: ${response.statusCode}");
      throw Exception('Failed to download image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Downloader'),
      ),
      body: Center(
        child: Text('Downloading images...'),
      ),
    );
  }
}
