import 'dart:io';
import 'dart:convert';
import 'dart:math';

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
Stream<String> loadDictionary(String dictionaryFilename) {
  var dictionary = File(dictionaryFilename);
  Stream<List<int>> streamedDictionary = dictionary.openRead();
  var streamedDictionaryContents =
      utf8.decoder.bind(streamedDictionary).transform(const LineSplitter());
  return streamedDictionaryContents;
}

Future getDictionarySize(String dictionaryFilename) {
  var streamedDictionaryContents = loadDictionary(dictionaryFilename);
  return streamedDictionaryContents.length;
}

Future<String> getRandomWord(String dictionaryFilename) async {
  var streamedDictionaryContents = loadDictionary(dictionaryFilename);
  var random = Random();
  // Get a random number, from 0 to the dictionary size
  var indexOfWordToGet =
      random.nextInt(await getDictionarySize(dictionaryFilename));
  return streamedDictionaryContents.elementAt(indexOfWordToGet);
}

String getSeparator(bool randomize) {
  var indexOfSeparatorToGet = 0;
  if (randomize) {
    var random = Random();
    indexOfSeparatorToGet = random.nextInt(separatorsSize);
  }
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

Future<String> constructPassphrase(int length, bool randomizeSeparators,
    bool typoification, String dictionaryFilename) async {
  final passphraseBuffer = StringBuffer('');
  var nextWord = "";
  for (; length > 0; length--) {
    nextWord = await getRandomWord(dictionaryFilename);
    if (typoification) {
      nextWord = typoifyWord(nextWord);
    }
    passphraseBuffer.write(nextWord);
    //separator
    if (length > 1) {
      passphraseBuffer.write(getSeparator(randomizeSeparators));
    }
  }
  return passphraseBuffer.toString();
}
