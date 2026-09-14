import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = FPlatformVariant.android;
    final FThemeData brightnessTheme = platform.desktop
        ? FTheme.neutral.light.desktop
        : FTheme.neutral.light.touch;

    return MaterialApp(
      title: 'ForUI Auth Demo',
      debugShowCheckedModeBanner: false,
      home: FTheme(
        data: brightnessTheme,
        platform: platform,
        child: const LoginPage(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// LOGIN PAGE
// ═══════════════════════════════════════════════════════════════
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fillDemoCredentials() {
    setState(() {
      _usernameController.text = 'admin@gmail.com';
      _passwordController.text = 'password';
      _rememberMe = true;
    });
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Error', 'Username dan password tidak boleh kosong!');
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      }
    });
  }

  void _showErrorDialog(String title, String message) {
    showFDialog(
      context: context,
      builder: (context, style, animation) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(message),
              ),
              const SizedBox(height: 16),
              FButton(
                onPress: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Masuk untuk melanjutkan',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 32),

              FCard(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Username'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan username',
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Password'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan password',
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 16),

                      FCheckbox(
                        value: _rememberMe,
                        onChange: (v) => setState(() => _rememberMe = v),
                        label: const Text('Remember me'),
                      ),
                      const SizedBox(height: 24),

                      FButton(
                        onPress: _isLoading ? null : _login,
                        size: FButtonSizeVariant.lg,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Masuk'),
                      ),
                      const SizedBox(height: 12),

                      FButton(
                        onPress: _fillDemoCredentials,
                        variant: FButtonVariant.outline,
                        child: const Text('Isi Demo'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Belum punya akun? Daftar di sini',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DASHBOARD PAGE (After Login)
// ═══════════════════════════════════════════════════════════════
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Dashboard'),
        suffixes: [
          FHeaderAction(
            icon: const Icon(Icons.notifications_none),
            onPress: () {},
          ),
          FHeaderAction(
            icon: const Icon(Icons.settings),
            onPress: () {},
          ),
        ],
      ),
      footer: FBottomNavigationBar(
        index: 0,
        onChange: (index) {},
        children: [
          FBottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(Icons.menu_book),
            label: const Text('Books'),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: const Text('Profile'),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Anda berhasil login sebagai admin@gmail.com',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text('Statistik'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FCard(
                    child: Column(
                      children: [
                        const Text('12',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Proyek',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FCard(
                    child: Column(
                      children: [
                        const Text('5',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Tugas',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FCard(
                    child: Column(
                      children: [
                        const Text('8',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('File',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.6))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Widget Showcase'),
            const SizedBox(height: 8),

            FAlert(
              variant: FAlertVariant.primary,
              title: const Text('Info'),
              subtitle: const Text('Dashboard menggunakan ForUI widgets!'),
            ),
            const SizedBox(height: 12),

            FButton(
              onPress: () {
                showFDialog(
                  context: context,
                  builder: (context, style, animation) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Dashboard Info',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Ini adalah dashboard yang dibangun dengan ForUI.'),
                          ),
                          const SizedBox(height: 16),
                          FButton(
                            onPress: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              variant: FButtonVariant.secondary,
              child: const Text('Lihat Dialog'),
            ),
            const SizedBox(height: 12),

            FButton(
              onPress: () {
                Navigator.pop(context);
              },
              variant: FButtonVariant.destructive,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
