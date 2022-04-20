class Translate {
  final String text;
  final String to;

  Translate({
    required this.text,
    required this.to,
  });

  factory Translate.fromJson(Map<String, dynamic> json) => Translate(
        text: json["text"],
        to: json["to"],
      );
}
