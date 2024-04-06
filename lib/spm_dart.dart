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

Future<List<String>> loadDictionary(Future<String> dictionaryFile) async {
  List<String> dictionary = List.empty(growable: true);
  await dictionaryFile.asStream().forEach((element) {
    dictionary = element.split('\n');
  });
  return dictionary;
}

Future getDictionarySize(Future<String> dictionaryFile) async {
  var dictionary = await loadDictionary(dictionaryFile);
  return dictionary.length;
}

Future<String> getRandomWord(Future<String> dictionaryFile) async {
  var dictionary = await loadDictionary(dictionaryFile);
  var random = Random();
  // Get a random number, from 0 to the dictionary size
  var indexOfWordToGet =
      random.nextInt(await getDictionarySize(dictionaryFile));
  return dictionary.elementAt(indexOfWordToGet);
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

// FIXME: maybe don't do this, make the file be loaded somewhere else
Future<String> constructPassphrase(int length, bool randomizeSeparators,
    bool typoification, Future<String> dictionaryFile) async {
  final passphraseBuffer = StringBuffer('');
  var nextWord = "";
  for (; length > 0; length--) {
    nextWord = await getRandomWord(dictionaryFile);
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
