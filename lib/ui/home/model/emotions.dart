class Emotion {
  final String mapName;
  final String asset;
  final String name;

  Emotion(this.mapName, this.asset, this.name);
}

List<Emotion> emotions = [
  Emotion('angry', 'assets/emotions/angry.gif', '화남'),
  Emotion('glad', 'assets/emotions/glad.gif', '기쁨'),
  Emotion('grieved', 'assets/emotions/grieved.gif', '슬픔'),
  Emotion('amazed', 'assets/emotions/amazed.gif', '놀람')
];
