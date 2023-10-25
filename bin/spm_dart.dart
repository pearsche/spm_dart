import 'package:spm_dart/spm_dart.dart' as spm_dart;

void main(List<String> arguments) async {
  //print('Hello world: ${spm_dart.calculate()}!');
  var randomWord = await spm_dart.getRandomWord();
  print(randomWord);

  print(await spm_dart.constructPassphrase(3));
}
