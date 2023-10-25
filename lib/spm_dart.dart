import 'dart:io';
import 'dart:convert';
import 'dart:math';

int calculate() {
  return 6 * 7;
}

final separators = "-#¬_~=*+─";
final separatorsSize = separators.length;
final typoCharacters = {
  'a': "4",
  'e': "3",
  'i': "1",
  'o': "0",
  'l': "!",
  's': "5"
};
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

String getRandomSeparator() {
  var random = Random();
  var indexOfSeparatorToGet = random.nextInt(separatorsSize);
  return separators[indexOfSeparatorToGet];
}

String typoifyWord(String inputWord) {
  var random = Random();
  var stringBuffer = StringBuffer();
  if (random.nextBool()) {
    for (final character in inputWord.split('')) {
      if (typoCharacters[character] != null) {
        stringBuffer.write(typoCharacters[character]);
      } else {
        stringBuffer.write(character);
      }
    }
  } else {
    stringBuffer.write(inputWord);
  }
  return stringBuffer.toString();
}

Future<String> constructPassphrase(int length) async {
  final passphraseBuffer = StringBuffer('');
  for (; length > 0; length--) {
    passphraseBuffer.write(typoifyWord(await getRandomWord()));
    //separator
    if (length > 1) {
      passphraseBuffer.write(getRandomSeparator());
    }
  }
  return passphraseBuffer.toString();
}
