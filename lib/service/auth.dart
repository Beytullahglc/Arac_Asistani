import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Kullanıcı oluştur (Üye ol)
  Future<UserCredential?> createUser(String email, String password, String displayName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcıyı oluşturduktan sonra displayName ekliyoruz
      await credential.user?.updateProfile(displayName: displayName);
      return credential;
    } on FirebaseAuthException catch (e) {
      print("Kullanıcı oluşturma hatası: ${e.code}");
      return null;
    }
  }

  // Giriş yap
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      print("Giriş yapma hatası: ${e.code}");
      return null;
    }
  }

  // Şifreyi mevcut şifre ile değiştir
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return "Kullanıcı bulunamadı";
      }

      // Kullanıcının email adresi lazım
      String email = user.email!;

      // Mevcut şifreyi kullanarak kimlik doğrulama
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Yeni şifreyi güncelle
      await user.updatePassword(newPassword);

      return "success";
    } on FirebaseAuthException catch (e) {
      print("Şifre değiştirme hatası: ${e.code}");
      return "Hata: ${e.message}";
    } catch (e) {
      return "Bilinmeyen hata: ${e.toString()}";
    }
  }

  // Şifre güncelle (mevcut şifresiz, sadece yeni şifre)
  Future<bool> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      print("Şifre güncelleme hatası: ${e.code}");
      return false;
    }
  }

  // Kullanıcı adı (displayName) güncelleme
  Future<String> updateDisplayName(String displayName) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return "Kullanıcı bulunamadı";
      }

      // Kullanıcı profilini güncelliyoruz
      await user.updateProfile(displayName: displayName);
      return "success";
    } on FirebaseAuthException catch (e) {
      print("DisplayName güncelleme hatası: ${e.code}");
      return "Hata: ${e.message}";
    }
  }

  // Çıkış yap
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Mevcut kullanıcı
  User? get currentUser => _auth.currentUser;
}
