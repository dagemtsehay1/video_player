class Video {
  final String? videoTitle;
  final String? videoThumbnail;
  final String? videoUrl;
  final String? videoDescription;

  Video({
    required this.videoTitle,
    required this.videoThumbnail,
    required this.videoUrl,
    required this.videoDescription,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoTitle: json['videoTitle'] as String?,
      videoThumbnail: json['videoThumbnail'] as String?,
      videoUrl: json['videoUrl'] as String?,
      videoDescription: json['videoDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoTitle': videoTitle,
      'videoThumbnail': videoThumbnail,
      'videoUrl': videoUrl,
      'videoDescription': videoDescription,
    };
  }
}
