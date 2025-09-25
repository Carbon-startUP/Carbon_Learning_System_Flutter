import 'package:equatable/equatable.dart';

class ChatFile extends Equatable {
  final String name;
  final String path;
  final String size;
  final String extension;

  const ChatFile({
    required this.name,
    required this.path,
    required this.size,
    required this.extension,
  });

  @override
  List<Object> get props => [name, path, size, extension];
}
