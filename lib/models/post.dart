class Post {
  final int price;
  final String site, location, imageurl;
  final List categoryIds;
  final List images;

  Post({
    //this.id,
    this.price,
    this.site,
    this.location,
    this.imageurl,
    this.categoryIds,
    this.images,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      //id: json['id'],
      price: json['price'],
      site: json['site'],
      location: json['location'],
      imageurl: json['imageurl'],
      //categoryIds: json['categoryIds'],
      //images: json['images'],
    );
  }
}
// class Post {
//   final int price;
//   final String id, title, subtitle, image;
//   final List categoryIds;
//   final List images;

//   Post({
//     this.id,
//     this.price,
//     this.title,
//     this.subtitle,
//     this.image,
//     this.categoryIds,
//     this.images,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       price: json['price'],
//       title: json['title'],
//       subtitle: json['subtitle'],
//       image: json['image'],
//       categoryIds: json['categoryIds'],
//       images: json['images'],
//     );
//   }
// }
