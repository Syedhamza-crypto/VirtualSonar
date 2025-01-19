// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'customize_screen.dart'; // Import the CustomizeScreen
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the package

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Virtual Sonar'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(202, 233, 208, 171),
//       ),
//       body: const HomeScreen(), // Show the HomeScreen directly
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         onPressed: () async {
//           const phoneNumber = '+923168547848'; // Your WhatsApp number
//           final Uri url = Uri.parse('https://wa.me/$phoneNumber');
//           if (await canLaunchUrl(url)) {
//             await launchUrl(url, mode: LaunchMode.externalApplication);
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Could not launch WhatsApp')),
//             );
//           }
//         },
//         child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Featured Jewelry Section
//           Container(
//             height: 150,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/ring.png'), // Replace with your image
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: const Center(
//               child: Text(
//                 'Customize Your Jewelry',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 10.0,
//                       color: Colors.black,
//                       offset: Offset(2.0, 2.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Jewelry Categories Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: _buildCategoryCard(
//                         context, 'Rings', 'assets/rings.png')),
//                 const SizedBox(width: 8),
//                 Expanded(
//                     child: _buildCategoryCard(
//                         context, 'Necklaces', 'assets/necklace.png')),
//                 const SizedBox(width: 8),
//                 Expanded(
//                     child: _buildCategoryCard(
//                         context, 'Earrings', 'assets/earring.png')),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryCard(
//       BuildContext context, String title, String imagePath) {
//     // Define the images for each category
//     List<String> images;
//     switch (title) {
//       case 'Rings':
//         images = [
//           'assets/r1.png',
//           'assets/r2.png',
//           'assets/r3.png',
//           'assets/r4.png',
//           'assets/r5.png',
//           'assets/r6.png',
//           'assets/r7.png',
//           'assets/r8.png',
//           'assets/r9.png',
//           'assets/r11.png',
//           'assets/r22.png',
//           'assets/r33.png',
//           'assets/r44.png',
//           'assets/r55.png',
//           'assets/r66.png',
//           'assets/r77.png',
//           'assets/r88.png',
//           'assets/r99.png',
//         ];
//         break;
//       case 'Necklaces':
//         images = [
//           'assets/necklaces/necklace.png',
//           'assets/necklaces/necklace.png',
//           'assets/necklaces/necklace.png',
//         ];
//         break;
//       case 'Earrings':
//         images = [
//           'assets/earrings/earring.png',
//           'assets/earrings/earring.png',
//           'assets/earrings/earring.png',
//         ];
//         break;
//       default:
//         images = [];
//     }

//     return GestureDetector(
//       onTap: () {
//         // Navigate to the respective customization screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CustomizeScreen(
//               title: title,
//               imagePaths: images,
//             ),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 5,
//         child: Column(
//           children: [
//             Image.asset(
//               imagePath,
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 title,
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'customize_screen.dart'; // Import the CustomizeScreen
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import the package
import 'image_picker_screen.dart'; // Import the new ImagePickerScreen

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Sonar'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(202, 233, 208, 171),
      ),
      body: const HomeScreen(), // Show the HomeScreen directly
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          const phoneNumber = '+923168547848'; // Your WhatsApp number
          final Uri url = Uri.parse('https://wa.me/$phoneNumber');
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not launch WhatsApp')),
            );
          }
        },
        child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Featured Jewelry Section
          Container(
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ring.png'), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'Customize Your Jewelry',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Jewelry Categories Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _buildCategoryCard(
                        context, 'Rings', 'assets/rings.png')),
                const SizedBox(width: 8),
                Expanded(
                    child: _buildCategoryCard(
                        context, 'Necklaces', 'assets/necklace.png')),
                const SizedBox(width: 8),
                Expanded(
                    child: _buildCategoryCard(
                        context, 'Earrings', 'assets/earring.png')),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // New button to navigate to the ImagePickerScreen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImagePickerScreen(),
                  ),
                );
              },
              child: const Text('Pick Images and Generate'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imagePath) {
    // Define the images for each category
    List<String> images;
    switch (title) {
      case 'Rings':
        images = [
          'assets/r1.png',
          'assets/r2.png',
          'assets/r3.png',
          'assets/r4.png',
          'assets/r5.png',
        ];
        break;
      case 'Necklaces':
        images = ['assets/necklaces/necklace.png'];
        break;
      case 'Earrings':
        images = ['assets/earrings/earring.png'];
        break;
      default:
        images = [];
    }

    return GestureDetector(
      onTap: () {
        // Navigate to the respective customization screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomizeScreen(
              title: title,
              imagePaths: images,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
