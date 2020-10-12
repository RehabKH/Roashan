import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roashan/provider/cart.dart';
import 'package:roashan/provider/favoriteProvider.dart';
import 'package:roashan/ui/splash.dart';

void main() {
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        
        ListenableProvider(
          create: (context) => FavoriteProvider(),
         ),
      ],
       child: MyApp(),
  ));
    // ChangeNotifierProvider(
    //   create: (context) => Cart(),
    //   child: MyApp(),
    // ),

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
    primaryColor: Colors.amber,
    accentColor: Colors.amber
        ),
        home: Splash(),
      );
    // MultiProvider(
    //       providers:[
    //         ChangeNotifierProvider(create: (_)=> Cart())
    //       ],
    //       child: MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //     home: Splash(),
    //   ),
    // );
  }
}
//  {
// runApp(
//     MultiProvider(
//           providers: [
//             ChangeNotifierProvider(
//               builder: (_) => Cart(),
//               create: MaterialApp(
//         home: Splash(),
//         debugShowCheckedModeBanner: false,
//       ),,
//             )
//           ],
//           // child:
//     ),
//   );
// }
