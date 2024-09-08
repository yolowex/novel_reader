import 'dart:io';
import 'dart:async';

class PdfService{
  // Private constructor
  PdfService._();

  // Static instance of the class
  static final PdfService _instance = PdfService._();

  // Factory constructor to return the same instance
  factory PdfService() {
    return _instance;
  }

  Future<String> extractTextFromPdf(String pdfPath, int pageNumber) async {
    // Prepare the command to run
    final command = [
      'pdftotext',
      '-f',
      pageNumber.toString(),
      '-l',
      pageNumber.toString(),
      pdfPath,
      '-'
    ];

    try {
      // Run the command
      final result = await Process.run(command[0], command.sublist(1));

      // Check if the command was successful
      if (result.exitCode == 0) {
        // Return the output as a string
        return result.stdout as String;
      } else {
        // Handle the error
        print('Error: ${result.stderr}');
        return '';
      }
    } catch (e) {
      print('Exception: $e');
      return '';
    }
  }

  Future<int> getTotalPages(String pdfPath) async {
    // Prepare the command to run
    final command = ['pdfinfo', pdfPath];

    try {
      // Run the command
      final result = await Process.run(command[0], command.sublist(1));

      // Check if the command was successful
      if (result.exitCode == 0) {
        // Parse the output to find the number of pages
        final output = result.stdout as String;
        final regex = RegExp(r'Pages:\s+(\d+)');
        final match = regex.firstMatch(output);

        if (match != null && match.groupCount > 0) {
          return int.parse(match.group(1)!);
        }
      } else {
        // Handle the error
        print('Error: ${result.stderr}');
      }
    } catch (e) {
      print('Exception: $e');
    }

    // Return 0 if unable to get the number of pages
    return -1;
  }
}