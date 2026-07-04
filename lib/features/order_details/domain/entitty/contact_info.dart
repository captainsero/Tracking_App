class ContactInfo {
  final String name;
  final String address;
  final String? avatarUrl;
  final String phoneNumber;

  const ContactInfo({
    required this.name,
    required this.address,
    required this.phoneNumber,
    this.avatarUrl,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'phoneNumber': phoneNumber,
    'avatarUrl': avatarUrl,
  };
}
