import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

/// Represents a track from iTunes search results
class Track {
  final int trackId;
  final String artistName;
  final String trackName;
  final String collectionName;
  final String artworkUrl100;
  final String previewUrl;
  final int trackTimeMillis;
  final String primaryGenreName;
  final String releaseDate;
  final double? trackPrice;
  final String? currency;

  Track({
    required this.trackId,
    required this.artistName,
    required this.trackName,
    required this.collectionName,
    required this.artworkUrl100,
    required this.previewUrl,
    required this.trackTimeMillis,
    required this.primaryGenreName,
    required this.releaseDate,
    this.trackPrice,
    this.currency,
  });

  /// Creates a Track instance from JSON
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      trackId: json['trackId'] ?? 0,
      artistName: json['artistName'] ?? '',
      trackName: json['trackName'] ?? '',
      collectionName: json['collectionName'] ?? '',
      artworkUrl100: json['artworkUrl100'] ?? '',
      previewUrl: json['previewUrl'] ?? '',
      trackTimeMillis: json['trackTimeMillis'] ?? 0,
      primaryGenreName: json['primaryGenreName'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      trackPrice: json['trackPrice']?.toDouble(),
      currency: json['currency'],
    );
  }

  /// Converts Track instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'trackId': trackId,
      'artistName': artistName,
      'trackName': trackName,
      'collectionName': collectionName,
      'artworkUrl100': artworkUrl100,
      'previewUrl': previewUrl,
      'trackTimeMillis': trackTimeMillis,
      'primaryGenreName': primaryGenreName,
      'releaseDate': releaseDate,
      'trackPrice': trackPrice,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return 'Track{trackId: $trackId, artistName: $artistName, trackName: $trackName}';
  }
}

/// Represents the search response from iTunes API
class SearchResponse {
  final int resultCount;
  final List<Track> results;

  SearchResponse({
    required this.resultCount,
    required this.results,
  });

  /// Creates a SearchResponse instance from JSON
  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> resultsJson = json['results'] ?? [];
    final List<Track> tracks = resultsJson
        .map((trackJson) => Track.fromJson(trackJson as Map<String, dynamic>))
        .toList();

    return SearchResponse(
      resultCount: json['resultCount'] ?? 0,
      results: tracks,
    );
  }

  /// Converts SearchResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'resultCount': resultCount,
      'results': results.map((track) => track.toJson()).toList(),
    };
  }
}

/// Custom exceptions for iTunes search
class SearchTrackException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  SearchTrackException(this.message, {this.statusCode, this.originalError});

  @override
  String toString() {
    return 'iTunesSearchException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}

/// Service class for searching iTunes tracks
class SearchTrackService {
  static const String _baseUrl = 'https://itunes.apple.com/search';
  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _client;

  SearchTrackService({http.Client? client}) : _client = client ?? http.Client();

  /// Searches for tracks on iTunes
  ///
  /// [query] - The search term
  /// [limit] - Maximum number of results (default: 1, max: 200)
  ///
  /// Returns a [SearchResponse] containing the search results
  /// Throws [SearchTrackException] on error
  Future<SearchResponse> searchTracks(String query, {int limit = 1}) async {
    // Validate input
    if (query.trim().isEmpty) {
      return SearchResponse(resultCount: 0, results: []);
    }

    if (limit < 1 || limit > 200) {
      throw SearchTrackException('Limit must be between 1 and 200');
    }

    try {
      // Build query parameters
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'term': query.trim(),
        'media': 'music',
        'entity': 'song',
        'limit': limit.toString(),
      });

      developer.log('Searching iTunes for tracks with query: $query');

      // Make HTTP request
      final response = await _client
          .get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      )
          .timeout(_timeout);

      // Check response status
      if (response.statusCode != 200) {
        throw SearchTrackException(
          'API request failed',
          statusCode: response.statusCode,
        );
      }

      // Parse JSON response
      final Map<String, dynamic> jsonData;
      try {
        jsonData = json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw SearchTrackException(
          'Failed to parse response JSON',
          originalError: e,
        );
      }

      // Convert to SearchResponse
      final searchResponse = SearchResponse.fromJson(jsonData);

      developer.log('Found ${searchResponse.resultCount} tracks');

      return searchResponse;

    } on SearchTrackException {
      // Re-throw our custom exceptions
      rethrow;
    } catch (e) {
      // Handle all other exceptions
      String errorMessage = 'Unknown error occurred while searching tracks';

      if (e is http.ClientException) {
        errorMessage = 'Network error: ${e.message}';
      } else if (e is FormatException) {
        errorMessage = 'Invalid response format';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timed out';
      }

      developer.log('Error searching tracks: $e');

      throw SearchTrackException(
        errorMessage,
        originalError: e,
      );
    }
  }

  /// Disposes of the HTTP client
  void dispose() {
    _client.close();
  }
}

/// Example usage and helper functions
class iTunesSearchHelper {
  static final SearchTrackService _service = SearchTrackService();

  /// Convenience method for quick track search
  static Future<List<Track>> quickSearch(String query, {int limit = 10}) async {
    try {
      final response = await _service.searchTracks(query, limit: limit);
      return response.results;
    } catch (e) {
      developer.log('Quick search failed: $e');
      return [];
    }
  }

  /// Search for a single track
  static Future<Track?> searchSingleTrack(String query) async {
    try {
      final response = await _service.searchTracks(query, limit: 1);
      return response.results.isNotEmpty ? response.results.first : null;
    } catch (e) {
      developer.log('Single track search failed: $e');
      return null;
    }
  }

  /// Dispose resources
  static void dispose() {
    _service.dispose();
  }
}