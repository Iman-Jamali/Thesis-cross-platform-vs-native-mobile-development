class Id {
    final String id;

    Id({required this.id});

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
  };
}