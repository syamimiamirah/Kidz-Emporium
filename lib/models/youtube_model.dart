class VideoModel {
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String liveBroadcastContent; // Add this line with a default value

  VideoModel({
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    this.liveBroadcastContent = 'none', // Provide a default value
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final thumbnails = snippet['thumbnails'];
    final defaultThumbnail = thumbnails['default'];

    return VideoModel(
      videoId: json['id']['videoId'],
      title: snippet['title'],
      description: snippet['description'],
      thumbnailUrl: defaultThumbnail['url'],
      liveBroadcastContent: snippet['liveBroadcastContent'] ?? 'none', // Set the property with the default value
    );
  }
}
