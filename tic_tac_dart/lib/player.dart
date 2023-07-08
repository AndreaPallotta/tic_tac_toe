class Player {
  final String name;
  final String mark;

  Player(this.name, this.mark);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Player &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          mark == other.mark;

  @override
  int get hashCode => name.hashCode ^ mark.hashCode;
}
