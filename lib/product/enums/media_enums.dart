enum MediaType {
  movie('Movies'),
  tv('Tv Series');

  const MediaType(this.text);
  final String text;
}

enum TimeWindow { day, week }
