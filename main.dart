import 'package:flutter/material.dart';

void main() {
  runApp(const VaultApp());
}

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 100, color: Colors.blueGrey),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const VaultPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _coinInserted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: -150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _insertCoin() {
    if (!_coinInserted) {
      _controller.forward();
      setState(() {
        _coinInserted = true;
      });
    } else {
      _controller.reverse();
      setState(() {
        _coinInserted = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text("Vault"),
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Vault box
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueGrey, width: 6),
              ),
              child: const Center(
                child: Icon(Icons.savings, size: 80, color: Colors.blueGrey),
              ),
            ),
            const SizedBox(height: 50),
            // Coin animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child,
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow, // Changed to Yellow
                ),
                child: const Center(
                  child: Text(
                    "₹1",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _insertCoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Text("GO"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("About Us"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "👋 Hello! My name is Deepansh Singh Rajput.\n\n"
          "📍 I belong to Gonda District, Uttar Pradesh, India.\n\n"
          "🎓 Currently, I am a student of Class 12th (Commerce stream).\n\n"
          "💡 I am passionate about learning, technology, and building creative projects.\n\n"
          "📱 This app (a fun coin vault game) is one of my early projects, "
          "designed to showcase how ideas can be turned into working apps.\n\n"
          "🚀 I believe in constant growth, curiosity, and using technology to solve real-life problems.\n\n"
          "Thank you for trying out my app! 🙏",
          style: TextStyle(fontSize: 18, height: 1.6),
        ),
      ),
    );
  }
}