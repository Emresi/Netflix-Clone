enum Genres {
  action('Action', 'Aksiyon Filmleri'),
  adventure('Adventure', 'Macera Filmleri'),
  animation('Animation', 'Animasyon Filmleri'),
  comedy('Comedy', 'Komedi Filmleri'),
  crime('Crime', 'Suç Filmleri'),
  drama('Drama', 'Drama Filmleri'),
  family('Family', 'Aile Filmleri'),
  fantasy('Fantasy', 'Fantastik Filmler'),
  history('History', 'Tarihi Filmler'),
  horror('Horror', 'Korku Filmleri'),
  music('Music', 'Müzik ve Müzikaller'),
  romance('Romance', 'Romantik Filmler'),
  scienceFiction('Science Fiction', 'Bilim Kurgu Filmleri'),
  thriller('Thriller', 'Gerilim Filmleri'),
  western('Western', 'Batı Temalı Filmler');

  const Genres(this.english, this.turkish);
  final String english;
  final String turkish;
}
