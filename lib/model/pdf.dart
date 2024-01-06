class Pdf {
  int id;
  String seminar;
  String path;

  Pdf({required this.id, required this.seminar, required this.path});

  Map<String, dynamic> toJson() {
    return {'seminar': seminar, 'path': path};
  }
}
