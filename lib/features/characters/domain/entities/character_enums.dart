enum CharacterStatus { 
  all(''), alive('alive'), dead('dead'), unknown('unknown');
  final String value;
  const CharacterStatus(this.value);
}

enum CharacterGender {
  all(''), female('female'), male('male'), genderless('genderless'), unknown('unknown');
  final String value;
  const CharacterGender(this.value);
}