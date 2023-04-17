import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:panow_tech/ui/control_screen.dart';

class AuthProfile extends StatefulWidget {
  const AuthProfile({super.key});

  @override
  State<AuthProfile> createState() => _AuthProfileState();
}

class _AuthProfileState extends State<AuthProfile> {
  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider(create: (context) => AuthManager());
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        return Material(
          child: authManager.isAuth
              ? _buildProfile(authManager.authToken!.email, context, child)
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : AuthScreen();
                  }),
        );
      },
    );
  }

  Widget _buildProfile(email, context, child) {
    final deviceSize = MediaQuery.of(context).size;
    return Consumer<AuthManager>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(
              title: const Center(
            child: Text(
              'My Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: deviceSize.width * 0.9,
                child: Column(
                  children: [
                    _buildAvt(email),
                    _buildListProfile(email),
                    const SizedBox(height: 20),
                    _buildButtonLogOut(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvt(email) {
    return Column(
      children: [
        Center(
          child: email == 'admin@gmail.com' || email == 'panow@gmail.com'
              ? Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://res.cloudinary.com/dvbzja2gq/image/upload/v1678609678/motorcycle/avt/avt1_pzd4ef.png'),
                        fit: BoxFit.cover),
                  ),
                )
              : Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: primaryCorlor,
                    ),
                    borderRadius: BorderRadius.circular(80),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://res.cloudinary.com/dvbzja2gq/image/upload/v1678609679/motorcycle/avt/avt15_gcmlyg.png'),
                        fit: BoxFit.cover),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        Text(
          email,
          style: const TextStyle(
              // fontFamily: 'SFCompactRounded',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textCorlor),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildListProfile(email) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProductsManager(email, context),
              const SizedBox(height: 5),
              _buildOrdersManager(email, context),
              const SizedBox(height: 5),
              _buildSetting(),
              const SizedBox(height: 5),
              _buildIntroduction(),
              const SizedBox(height: 5),
              _buildHelp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsManager(email, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: email == 'admin@gmail.com' || email == 'panow@gmail.com'
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminProductsScreen()));
              },
              child: Row(
                children: [
                  const Icon(Icons.edit_rounded,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Product management',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteProductsScreen()));
              },
              child: Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Favorite product',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            ),
    );
  }

  Widget _buildOrdersManager(email, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: email == 'admin@gmail.com' || email == 'panow@gmail.com'
          ? GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_rounded,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Order management',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_rounded,
                      size: 20, color: primaryCorlor),
                  const SizedBox(width: 10),
                  const Text('Your order',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.all(3),
                      child: const Icon(Icons.keyboard_arrow_right_rounded,
                          size: 20, color: textCorlor))
                ],
              ),
            ),
    );
  }

  Widget _buildSetting() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Setting()));
        },
        child: Row(
          children: [
            const Icon(Icons.settings_rounded, size: 20, color: primaryCorlor),
            const SizedBox(width: 10),
            const Text('Setting',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 20, color: textCorlor))
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => AboutScren()));
        },
        child: Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                size: 20, color: primaryCorlor),
            const SizedBox(width: 10),
            const Text('About Panow Tech',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 20, color: textCorlor))
          ],
        ),
      ),
    );
  }

  Widget _buildHelp() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Help()));
        },
        child: Row(
          children: [
            const Icon(Icons.help_outline_rounded,
                size: 20, color: primaryCorlor),
            const SizedBox(width: 10),
            const Text('Help',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
                padding: const EdgeInsets.all(3),
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 20, color: textCorlor))
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogOut() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OnBoardScreen()),
        );
        context.read<AuthManager>().logout();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // button padding
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // text font weight
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout_rounded), // add an icon
          SizedBox(width: 10), // add spacing between icon and text
          Text(
            'Log out',
            style: TextStyle(fontFamily: 'SFCompactRounded'),
          ), // add text
        ],
      ),
    );
  }
}
