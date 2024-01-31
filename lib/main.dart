import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/config/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        // colorScheme: ColorScheme.fromSwatch(
        //   backgroundColor: FoodAppColors.white,
        // ),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      // initialRoute: signInScreen,
    );
  }
}

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key, required this.title});
//   final String title;
//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends ConsumerState<HomePage> {
  // TextEditingController textEditingController = TextEditingController();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future add() async {
  //   final doc = firestore.collection("myCollections").doc();
  //   final user = UserModel(name: "Sharun");
  //   await doc.set(user.toJson());
  // }

  // Future<void> removeData({required String id}) async {
  //   print("object");

  //   DocumentReference doc = firestore.collection('myCollections').doc(id);
  //   await doc.delete();
  // }

  // @override
  // void initState() {
  //   WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
  //     // ref.read(userNotifierProvider.notifier).fetchData();
  //     // ref.read(firebaseStreamProvider);
  //   });

  //   super.initState();
  // }

//   @override
//   Widget build(BuildContext context) {
//     // final state = ref.watch(firebaseStreamProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const HomePage(
//                             title: "",
//                           )));
//             },
//             icon: const Icon(Icons.arrow_back)),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 add();
//               },
//               icon: const Icon(Icons.add))
//         ],
//       ),
//       body: Container(
//         color: Colors.red,
//         height: 500,
//         width: 500,
//         child: CustomPaint(
//           painter: Tripainter(),
//           child: const Center(child: Text("sss")),
//         ),
//       ),
//     );
//     // body: state.when(
//     //   data: (List<DocumentSnapshot> documents) {
//     //     // Data is available, display UI based on the data
//     //     return ListView.builder(
//     //       itemCount: documents.length,
//     //       itemBuilder: (context, index) {
//     //         final document = documents[index];
//     //         // Build UI using document data
//     //         return ListTile(
//     //           title: Text(document['name']),
//     //           // Other fields...
//     //         );
//     //       },
//     //     );
//     //   },
//     //   loading: () => const Center(child: CircularProgressIndicator()),
//     //   error: (error, stackTrace) => Center(child: Text('Error: $error')),
//     // ));
//   }
// }

// class Tripainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.yellow
//       ..strokeWidth = 2
//       ..style = PaintingStyle.fill;

//     // final c = Offset(size.width * 0.5, size.height * 0.5);
//     // canvas.drawCircle(c, size.width * .5, paint);

//     final line = Path();
//     line.moveTo(size.width * 0.5, size.height * 0.2);
//     line.lineTo(size.width * .2, size.height * .6);
//     line.lineTo(size.width * .8, size.height * .6);
//     line.close();

//     canvas.drawPath(
//       line,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// // class TriangularButtonPainter extends CustomPainter {
// //   TriangularButtonPainter();

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()..color = colorScheme.background;

// //     final path = Path();
// //     path.moveTo(size.width / 2, 0);
// //     path.lineTo(size.width, size.height);
// //     path.lineTo(0, size.height);
// //     path.close();
// //     canvas.drawPath(path, paint);
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }
