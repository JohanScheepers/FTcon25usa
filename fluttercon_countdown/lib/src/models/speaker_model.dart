/// Represents a speaker at the event.
class Speaker {
  /// The name of the speaker.
  final String name;

  /// A list of talks given by the speaker.
  final List<Talk> talks;

  /// Creates a [Speaker] instance.
  Speaker({required this.name, required this.talks});

  /// Creates a [Speaker] instance from a JSON object.
  factory Speaker.fromJson(Map<String, dynamic> json) {
    final talksList = json['talks'] as List<dynamic>? ?? [];
    final List<Talk> talks =
        talksList.map((i) => Talk.fromJson(i as Map<String, dynamic>)).toList();
    return Speaker(name: json['name'] as String, talks: talks);
  }
}

/// Represents a talk given by a speaker.
class Talk {
  /// The title of the talk.
  final String title;

  /// The details or description of the talk.
  final String details;

  /// Creates a [Talk] instance.
  Talk({required this.title, required this.details});

  /// Creates a [Talk] instance from a JSON object.
  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      title: json['title'] as String,
      details: json['details'] as String,
    );
  }
}
