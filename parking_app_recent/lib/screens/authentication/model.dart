class UserModeltwo {
 final String uid;
 final String email;
 final String image;
 final String name;

  UserModeltwo( {this.uid, this.email, this.name, this.image,});

  // receiving data from server
  factory UserModeltwo.fromMap(map) {
    return UserModeltwo(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
    };
  }
}
