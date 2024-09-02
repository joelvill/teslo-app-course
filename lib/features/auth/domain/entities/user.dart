// {
//   "id": "8025e089-633c-4ae0-a0bf-1ed598e4088b",
//   "email": "test1@google.com",
//   "fullName": "Juan Carlos",
//   "isActive": true,
//   "roles": [
//     "admin"
//   ],
//   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjgwMjVlMDg5LTYzM2MtNGFlMC1hMGJmLTFlZDU5OGU0MDg4YiIsImlhdCI6MTcyNTI5NzAwMCwiZXhwIjoxNzI1MzA0MjAwfQ.FEtxMTVFAgoesryIeLbghz55pAERcaBDxwY-fDrC7mI"
// }

class User {
  final String id;
  final String email;
  final String fullName;
  final bool isActive;
  final List<String> roles;
  final String token;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.isActive,
    required this.roles,
    required this.token,
  });

  bool get isAdmin => roles.contains('admin');
}
