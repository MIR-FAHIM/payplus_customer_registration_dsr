import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';

class NIDParsed {
  final String? nid;
  final String? name;
  final String? dob;
  final String fullText;
  final double textAccuracy;
  final List<String> lines;

  const NIDParsed({
    required this.nid,
    required this.name,
    required this.dob,
    required this.fullText,
    required this.textAccuracy,
    required this.lines,
  });
}

class NIDOcrService {
  NIDOcrService({
    this.script = TextRecognitionScript.latin,
    this.clearThreshold = 0.2,
  });

  final TextRecognitionScript script;
  final double clearThreshold;

  Future<NIDParsed> readAndParseNid(
      File imageFile, {
        bool debugPrint = false,
      }) async {
    final textRecognizer = TextRecognizer(script: script);

    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await textRecognizer.processImage(inputImage);

      final fullText = recognizedText.text;

      final lines = <String>[];
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final text = line.text.trim();
          if (text.isNotEmpty) {
            lines.add(text);
          }
        }
      }

      if (debugPrint) {
        _printDebug(recognizedText: recognizedText, lines: lines);
      }

      final parsedFields = _parseBangladeshNIDFromLines(lines);
      final textAccuracy = calculateOcrAccuracy(fullText);

      return NIDParsed(
        nid: parsedFields.nid,
        name: parsedFields.name,
        dob: parsedFields.dob,
        fullText: fullText,
        textAccuracy: textAccuracy,
        lines: lines,
      );
    } finally {
      await textRecognizer.close();
    }
  }

  double calculateOcrAccuracy(String text) {
    if (text.isEmpty) {
      return 0.0;
    }

    final validCharRegex = RegExp(r'[A-Za-z0-9:\-/ ]');
    int validChars = 0;

    for (int i = 0; i < text.length; i++) {
      if (validCharRegex.hasMatch(text[i])) {
        validChars++;
      }
    }

    return validChars / text.length;
  }

  bool isClearByAccuracy(double accuracy) {
    return accuracy >= clearThreshold;
  }

  void _printDebug({
    required RecognizedText recognizedText,
    required List<String> lines,
  }) {
    print('================ FULL OCR TEXT ================');
    print(recognizedText.text);

    print('================ LINES ========================');
    for (final line in lines) {
      print('LINE: $line');
    }
    print('================================================');
  }

  _ParsedFields _parseBangladeshNIDFromLines(List<String> lines) {
    String? nid;
    String? dob;

    final name = extractNameFromLines(lines);

    for (final raw in lines) {
      final line = _normalizeOcr(raw);

      if (nid == null) {
        final compact = line.replaceAll(' ', '');

        final labelMatch = RegExp(
          r'(ID\s*NO|ID\s*NO\.|NID\s*NO|NID\s*No|National\s*ID|ND\s*NO)\s*[:\-]?\s*([0-9]{10,17})',
          caseSensitive: false,
        ).firstMatch(compact);

        if (labelMatch != null) {
          nid = labelMatch.group(2);
        } else {
          final anyDigits = RegExp(
            r'\b([0-9]{10}|[0-9]{13}|[0-9]{17})\b',
          ).firstMatch(compact);

          if (anyDigits != null) {
            nid = anyDigits.group(1);
          }
        }
      }

      dob ??= _extractDobFromAnyText(line);

      if (nid != null && dob != null) {
        break;
      }
    }

    if (nid != null) {
      nid = nid.replaceAll(RegExp(r'[^0-9]'), '');
      if (!(nid.length == 10 || nid.length == 13 || nid.length == 17)) {
        nid = null;
      }
    }

    return _ParsedFields(nid: nid, name: name, dob: dob);
  }

  String? extractNameFromLines(List<String> lines) {
    for (int i = 0; i < lines.length; i++) {
      final text = _normalizeOcr(lines[i]).toLowerCase();

      if (text == 'name' || text.contains('name')) {
        if (i + 1 < lines.length) {
          final candidate = _normalizeOcr(lines[i + 1]).trim();
          if (candidate.isNotEmpty && !_isHeaderText(candidate)) {
            return candidate;
          }
        }
      }
    }

    return null;
  }

  bool _isHeaderText(String text) {
    final headerWords = [
      'government',
      'bangladesh',
      'national',
      'id card',
      'nid',
      'date of birth',
      'birth',
      'identity',
    ];

    final lower = text.toLowerCase();

    for (final word in headerWords) {
      if (lower.contains(word)) {
        return true;
      }
    }

    return false;
  }

  String? _extractDobFromAnyText(String line) {
    final text = _normalizeOcr(line);

    final match = RegExp(
      r'\b(\d{1,2})\s+(Jan|Feb|Mar|March|Apr|April|May|Jun|June|Jul|July|Aug|Sep|Sept|September|Oct|Nov|Dec|December)\w*\s+((?:19|20)\d{2})\b',
      caseSensitive: false,
    ).firstMatch(text);

    if (match == null) {
      final numericMatch = RegExp(
        r'\b(\d{1,2})[\-/\.](\d{1,2})[\-/\.]((?:19|20)\d{2})\b',
      ).firstMatch(text);

      if (numericMatch == null) {
        return null;
      }

      final day = numericMatch.group(1)!;
      final month = numericMatch.group(2)!;
      final year = numericMatch.group(3)!;

      return _normalizeNumericDate(day: day, month: month, year: year);
    }

    final day = match.group(1)!;
    final month = match.group(2)!;
    final year = match.group(3)!;

    final month3 = _toMonth3(month);

    final parsed = DateFormat('d MMM yyyy').parseLoose('$day $month3 $year');
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String? _normalizeNumericDate({
    required String day,
    required String month,
    required String year,
  }) {
    final dayValue = int.tryParse(day);
    final monthValue = int.tryParse(month);
    final yearValue = int.tryParse(year);

    if (dayValue == null || monthValue == null || yearValue == null) {
      return null;
    }

    if (dayValue < 1 || dayValue > 31 || monthValue < 1 || monthValue > 12) {
      return null;
    }

    final parsed = DateTime(yearValue, monthValue, dayValue);
    return DateFormat('yyyy-MM-dd').format(parsed);
  }

  String _toMonth3(String month) {
    final lower = month.toLowerCase();

    if (lower.startsWith('jan')) return 'Jan';
    if (lower.startsWith('feb')) return 'Feb';
    if (lower.startsWith('mar')) return 'Mar';
    if (lower.startsWith('apr')) return 'Apr';
    if (lower.startsWith('may')) return 'May';
    if (lower.startsWith('jun')) return 'Jun';
    if (lower.startsWith('jul')) return 'Jul';
    if (lower.startsWith('aug')) return 'Aug';
    if (lower.startsWith('sep')) return 'Sep';
    if (lower.startsWith('oct')) return 'Oct';
    if (lower.startsWith('nov')) return 'Nov';

    return 'Dec';
  }

  String _normalizeOcr(String value) {
    var output = value.trim().replaceAll(RegExp(r'\s+'), ' ');

    output = output.replaceAllMapped(
      RegExp(r'(?<=\d)O|O(?=\d)'),
          (_) => '0',
    );

    return output;
  }
}

class _ParsedFields {
  final String? nid;
  final String? name;
  final String? dob;

  _ParsedFields({
    required this.nid,
    required this.name,
    required this.dob,
  });
}
