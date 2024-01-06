class Text {
  int id;
  String seminar;
  String path;

  Text({required this.id, required this.seminar, required this.path});
  Map<String, dynamic> toJson() {
    return {'seminar': seminar, 'path': path};
  }
}
