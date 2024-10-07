class Post {
  final String description; // Description of the post
  final bool found; // Indicates if the pet is found
  final String? image; // Image of the pet (nullable)
  final String location; // Location where the pet was lost
  final String ownerId; // Owner's unique ID
  final String petName; // Name of the pet
  final String postId; // Unique ID for the post
  final String reward; // Reward offered for finding the pet

  Post({
    required this.description,
    required this.found,
    required this.image,
    required this.location,
    required this.ownerId,
    required this.petName,
    required this.postId,
    required this.reward,
  });
}