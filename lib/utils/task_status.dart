
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