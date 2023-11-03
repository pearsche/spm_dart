import 'package:spm_dart/spm_dart.dart';
import 'package:test/test.dart';

void main() {
  test(
      'Construct a passphrase, randomized words without typoification, without randomized separators',
      () async {
    RegExp toMatch = RegExp(r'(\w+)-(\w+)-(\w+)');
    var passphrase =
        await constructPassphrase(3, false, false, "example-dictionary.txt");
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });

  test(
      'Construct a passphrase, randomized words without typoification, with randomized separators',
      () async {
    RegExp toMatch =
        RegExp(r'(\w+)(-|#|¬|_|~|\=|\*|\+|─)(\w+)(-|#|¬|_|~|\=|\*|\+|─)(\w+)');
    var passphrase =
        await constructPassphrase(3, false, false, "example-dictionary.txt");
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });

  test(
      'Construct a passphrase, randomized words with typoification, with randomized separators',
      () async {
    RegExp toMatch = RegExp(
        r'([a-zA-Z0-5!]*)(-|#|¬|_|~|\=|\*|\+|─)([a-zA-Z0-5!]*)(-|#|¬|_|~|\=|\*|\+|─)([a-zA-Z0-5!]*)');
    var passphrase =
        await constructPassphrase(3, false, false, "example-dictionary.txt");
    print(passphrase);
    RegExpMatch? match = toMatch.firstMatch(passphrase);
    expect(passphrase, match![0]);
  });
}
