import 'dart:convert';

import 'package:flutter/foundation.dart';

class Board {
  String? boardId;
  String title;
  final String uid;
  final String image;
  final List<String> favorites;
  final int followers;
  final String description;
  final List<String> posts;
  final List<String> tags;

  Board({
    this.boardId,
    required this.title,
    required this.image,
    required this.favorites,
    required this.uid,
    this.followers = 0,
    this.description = "",
    this.posts = const [],
    this.tags = const [],
  });

  Board copyWith(
      {String? boardId,
      String? title,
      String? image,
      List<String>? favorites,
      int? followers,
      String? description,
      List<String>? posts,
      List<String>? tags,
      String? uid}) {
    return Board(
      uid: uid ?? this.uid,
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      image: image ?? this.image,
      favorites: favorites ?? this.favorites,
      followers: followers ?? this.followers,
      description: description ?? this.description,
      posts: posts ?? this.posts,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boardId': boardId,
      'title': title,
      'image': image,
      'description': description,
      'posts': posts,
      'favorites': favorites,
      'tags': tags,
      'uid': uid,
    };
  }

  factory Board.fromMap(Map<String, dynamic> map) {
    return Board(
      boardId: map['boardId'],
      uid: map['uid'],
      title: map['title'],
      image: map['image'],
      description: map['description'],
      posts: List<String>.from(map['posts']),
      favorites: List<String>.from(map['favorites']),
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Board.fromJson(String source) => Board.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Board(boardId: $boardId, title: $title, image: $image, description: $description, posts: $posts, favorites: $favorites, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Board &&
        other.boardId == boardId &&
        other.title == title &&
        other.image == image &&
        other.description == description &&
        listEquals(other.posts, posts) &&
        // listEquals(other.favorites, favorites) &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return boardId.hashCode ^
        title.hashCode ^
        image.hashCode ^
        description.hashCode ^
        posts.hashCode ^
        favorites.hashCode ^
        tags.hashCode;
  }
}
