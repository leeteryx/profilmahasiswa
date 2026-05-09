import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ── Palet Warna ─────────────────────────────────────────────
class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const secondary = Color(0xFFFF6584);
  static const bg = Color(0xFFF4F3FF);
  static const card = Colors.white;
  static const textDark = Color(0xFF2D2D2D);
  static const textGrey = Color(0xFF9E9E9E);
}

// ── Style teks terpusat (pakai font bawaan Flutter) ─────────
TextStyle _ts({
  double size = 14,
  FontWeight weight = FontWeight.normal,
  Color color = AppColors.textDark,
}) => TextStyle(fontSize: size, fontWeight: weight, color: color);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Halaman Login
// ══════════════════════════════════════════════════════════════
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  void _login() {
    if (_emailCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password harus diisi!')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfilPage()),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: _cardDeco(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _gradientIcon(Icons.school, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Profil Mahasiswa',
                  style: _ts(
                    size: 24,
                    weight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Silakan login untuk melanjutkan',
                  style: _ts(size: 13, color: AppColors.textGrey),
                ),
                const SizedBox(height: 28),
                _buildTextField(
                  controller: _emailCtrl,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: _inputDeco(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textGrey,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _gradientButton(
                  label: 'Login',
                  icon: Icons.login,
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Halaman Profil
// ══════════════════════════════════════════════════════════════
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});
  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String nama = 'Valisha';
  String nim = '187241012';
  String prodi = 'S1 Sistem Informasi - FST UNAIR';

  void _bukaEdit() async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilPage(nama: nama, nim: nim, prodi: prodi),
      ),
    );
    if (hasil != null)
      setState(() {
        nama = hasil['nama']!;
        nim = hasil['nim']!;
        prodi = hasil['prodi']!;
      });
  }

  void _konfirmasiLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Konfirmasi Logout',
          style: _ts(size: 17, weight: FontWeight.bold),
        ),
        content: Text('Apakah kamu yakin ingin logout?', style: _ts()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: _ts(color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Logout', style: _ts(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _gradientAppBar('Profil Mahasiswa'),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(28),
          decoration: _cardDeco(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar dengan gradient border
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.bg,
                  child: Icon(Icons.person, size: 56, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 20),
              _infoRow(Icons.badge_outlined, nama, bold: true, size: 20),
              const SizedBox(height: 10),
              _infoRow(Icons.tag, nim, color: AppColors.textGrey, size: 14),
              const SizedBox(height: 8),
              _infoRow(Icons.school_outlined, prodi, size: 14),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: _gradientButton(
                      label: 'Edit Profil',
                      icon: Icons.edit_outlined,
                      onPressed: _bukaEdit,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _konfirmasiLogout,
                      icon: const Icon(Icons.logout),
                      label: Text('Logout', style: _ts()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.secondary,
                        side: const BorderSide(
                          color: AppColors.secondary,
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Halaman Edit Profil
// ══════════════════════════════════════════════════════════════
class EditProfilPage extends StatefulWidget {
  final String nama, nim, prodi;
  const EditProfilPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
  });
  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController _namaCtrl;
  late TextEditingController _nimCtrl;
  late TextEditingController _prodiCtrl;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.nama);
    _nimCtrl = TextEditingController(text: widget.nim);
    _prodiCtrl = TextEditingController(text: widget.prodi);
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _nimCtrl.dispose();
    _prodiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_namaCtrl.text.trim().isEmpty ||
        _nimCtrl.text.trim().isEmpty ||
        _prodiCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field harus diisi!')));
      return;
    }
    Navigator.pop(context, {
      'nama': _namaCtrl.text.trim(),
      'nim': _nimCtrl.text.trim(),
      'prodi': _prodiCtrl.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _gradientAppBar('Edit Profil'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: _cardDeco(),
          child: Column(
            children: [
              _buildTextField(
                controller: _namaCtrl,
                label: 'Nama',
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nimCtrl,
                label: 'NIM',
                icon: Icons.tag,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _prodiCtrl,
                label: 'Program Studi',
                icon: Icons.school_outlined,
              ),
              const SizedBox(height: 28),
              _gradientButton(
                label: 'Simpan',
                icon: Icons.save_outlined,
                onPressed: _simpan,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Helper Functions
// ══════════════════════════════════════════════════════════════

BoxDecoration _cardDeco() => BoxDecoration(
  color: AppColors.card,
  borderRadius: BorderRadius.circular(24),
  boxShadow: [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
);

AppBar _gradientAppBar(String title) => AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
  title: Text(
    title,
    style: _ts(size: 18, weight: FontWeight.w600, color: Colors.white),
  ),
  centerTitle: true,
  backgroundColor: Colors.transparent,
  iconTheme: const IconThemeData(color: Colors.white),
);

Widget _gradientIcon(IconData icon, {double size = 40}) => Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [AppColors.primary, AppColors.secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Icon(icon, size: size, color: Colors.white),
);

Widget _gradientButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
}) => SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: onPressed,
    icon: Icon(icon, color: Colors.white, size: 18),
    label: Text(
      label,
      style: _ts(size: 15, weight: FontWeight.w600, color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
    ),
  ),
);

Widget _infoRow(
  IconData icon,
  String text, {
  bool bold = false,
  double size = 15,
  Color color = AppColors.textDark,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(icon, color: AppColors.primary, size: size + 4),
    const SizedBox(width: 8),
    Flexible(
      child: Text(
        text,
        style: _ts(
          size: size,
          weight: bold ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ],
);

InputDecoration _inputDeco({
  required String label,
  required IconData icon,
  Widget? suffix,
}) => InputDecoration(
  labelText: label,
  labelStyle: _ts(color: AppColors.textGrey),
  prefixIcon: Icon(icon, color: AppColors.primary),
  suffixIcon: suffix,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.primary, width: 2),
  ),
);

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
}) => TextField(
  controller: controller,
  keyboardType: keyboardType,
  decoration: _inputDeco(label: label, icon: icon),
);
