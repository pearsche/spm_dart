import 'dart:io';
import 'dart:convert';
import 'dart:math';

int calculate() {
  return 6 * 7;
}

Stream<String> loadDictionary() {
  var dictionaryFilename = File('english-dictionary.txt');
  Stream<List<int>> streamedDictionary = dictionaryFilename.openRead();
  var streamedDictionaryContents =
      utf8.decoder.bind(streamedDictionary).transform(const LineSplitter());
  return streamedDictionaryContents;
}

Future getDictionarySize() {
  var streamedDictionaryContents = loadDictionary();
  return streamedDictionaryContents.length;
}

Future<String> getRandomWord() async {
  var streamedDictionaryContents = loadDictionary();
  var random = Random();
  // Get a random number, from 0 to the dictionary size
  var indexOfWordToGet = random.nextInt(await getDictionarySize());
  return streamedDictionaryContents.elementAt(indexOfWordToGet);
}

Future<String> constructPassphrase(int length) async {
  final passphraseBuffer = StringBuffer('');
  while (length > 0) {
    length -= 1;
    passphraseBuffer.write(await getRandomWord());
    //separator
    if (length >= 1) {
      passphraseBuffer.write("-");
    }
  }
  return passphraseBuffer.toString();
}
