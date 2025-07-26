
enum Mood {
  happy,
  sad,
  excited,
  relaxed,
  nostalgic,
  adventurous,
  romantic,
  angry,
  surprised,
  peaceful,
}

enum Genre {
  pop,
  rock,
  hiphop,
  jazz,
  classical,
  electronic,
  country,
  reggae,
}


enum TaskStatus {
  // default state for initializing
  initial,

  // picture has started uploading
  uploading,

  // picture has uploaded, so the processing has begun
  processing,

  // songs have been populated
  complete,

  // error
  error,

  // curating
  curating,
}