class SeminarLibrary {
  final String name;
  final String initiator;
  final String description;

  SeminarLibrary({
    required this.name,
    required this.initiator,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'initiator': initiator,
      'description': description,
    };
  }

  factory SeminarLibrary.fromMap(Map<String, dynamic> map) {
    return SeminarLibrary(
        name: map['name'],
        initiator: map['initiator'],
        description: map['description']);
  }
}
