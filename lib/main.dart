import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/controllers/location_controller.dart';
import 'package:flutter_security_workforce/app/core/network/socket_api.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(AppKeys.accessTokenKey) ?? '';


  if (token.isNotEmpty) {
    SocketApi.init(token);

    SocketApi.messageStream.listen(
      (data) {
        debugPrint('Global Socket Message: $data');
     
      },
      onError: (error) {
        debugPrint('Global Socket Error: $error');
      },
      onDone: () {
        debugPrint('Global Socket Closed');
      },
    );
  } else {
    debugPrint('Access token not found. SocketApi not initialized.');
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.put(LocationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashRoute,
        getPages: AppPages.pages,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryWhite,
          appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryWhite),
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}
