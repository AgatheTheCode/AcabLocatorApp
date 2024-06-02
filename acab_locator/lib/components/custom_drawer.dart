import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the logout method within the build method to access the context
    void logOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }

    return Drawer(
      child: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to resolve, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            // User is logged in
            final User user = snapshot.data!;
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user.displayName ?? 'User'),
                  accountEmail: Text(user.email ?? 'No email'),
                  currentAccountPicture: CircleAvatar(
                    child: Text(user.email?.substring(0, 1).toUpperCase() ?? 'U'),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: logOut, // Call the logOut method on tap
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera Page'),
                  onTap: () {
                    Navigator.pushNamed(context, '/camera_page');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pushNamed(context, '/gallery');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Map'),
                  onTap: () {
                    Navigator.pushNamed(context, '/map');
                  },
                ),
              ],
            );
          } else {
            // User is not logged in
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                  ),
                  child: Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth/login');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.app_registration),
                  title: const Text('Register'),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth/register');
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
