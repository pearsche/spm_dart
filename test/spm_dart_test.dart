import 'package:spm_dart/spm_dart.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test(
      'Construct a passphrase, randomized words without typoification, without randomized separators',
      () async {
    RegExp toMatch = RegExp(r'(\w+)-(\w+)-(\w+)');
    Future<String> dictionaryFile =
        File("example-dictionary.txt").readAsString();
    var passphrase = await constructPassphrase(3, false, false, dictionaryFile);
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });

  test(
      'Construct a passphrase, randomized words without typoification, with randomized separators',
      () async {
    RegExp toMatch =
        RegExp(r'(\w+)(-|#|¬|_|~|\=|\*|\+|─)(\w+)(-|#|¬|_|~|\=|\*|\+|─)(\w+)');
    Future<String> dictionaryFile =
        File("example-dictionary.txt").readAsString();
    var passphrase = await constructPassphrase(3, true, false, dictionaryFile);
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });

  test(
      'Construct a passphrase, randomized words with typoification, with randomized separators',
      () async {
    RegExp toMatch = RegExp(
        r'([a-zA-Z0-5!]*)(-|#|¬|_|~|\=|\*|\+|─)([a-zA-Z0-5!]*)(-|#|¬|_|~|\=|\*|\+|─)([a-zA-Z0-5!]*)');
    Future<String> dictionaryFile =
        File("example-dictionary.txt").readAsString();
    var passphrase = await constructPassphrase(3, true, true, dictionaryFile);
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });
}
