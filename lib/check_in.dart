// import 'package:flutter/material.dart';
// import 'package:flutter_demo_wireframe_design/appbar_main.dart';
// import 'package:flutter_demo_wireframe_design/input_name.dart';
// import 'package:flutter_demo_wireframe_design/user.dart';
// import 'package:flutter_demo_wireframe_design/user_provider.dart';
// import 'package:flutter_demo_wireframe_design/visit_purpose.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

// class CheckinScreen extends StatefulWidget {
//   _CheckinScreenState createState() => _CheckinScreenState();
// }

// class _CheckinScreenState extends State<CheckinScreen> {
//   @override
//   Widget build(BuildContext context) {
//     SwiperPluginConfig _config;
//     final _userBloc = UserProvider.of(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             AppBarMain(content: 'Check in', isImplyLeading: false,leadingText: '',),
//             Stack(
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height - 128,
//                   width: MediaQuery.of(context).size.width,
//                   color: Color(0xFFF68B1F),
//                   child: Swiper(
//                     itemCount: 2,
//                     index: 0,
//                     autoplay: false,
//                     loop: true,
//                     physics:
//                         ScrollPhysics(parent: NeverScrollableScrollPhysics()),
//                     onTap: (index) {
//                       FocusScope.of(context).requestFocus(new FocusNode());
//                     },
//                     scrollDirection: Axis.horizontal,
//                     controller: SwiperController(),
//                     pagination: SwiperCustomPagination(
//                       builder: (context, config) {
//                         _config = config;
//                         if (config.activeIndex == 0) {
//                           return stepSection(
//                               Color(0xFFBDBDBD), Color(0xFFBDBDBD));
//                         } else {
//                           return stepSection(
//                               Color(0xFFF15D03), Color(0xFFF15D03));
//                         }
//                       },
//                     ),
//                     itemBuilder: (context, index) {
//                       if (index == 0) {
//                         return InputName(
//                           config: _config,
//                         );
//                       } else {
//                         return StreamBuilder<User>(
//                           stream: _userBloc.user,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return VisitPurpose(userName: snapshot.data.name);
//                             } else {
//                               return Container();
//                             }
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
