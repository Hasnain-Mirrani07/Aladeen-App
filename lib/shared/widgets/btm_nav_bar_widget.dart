
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CstmBtmNavBar extends StatelessWidget {
//   const CstmBtmNavBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final btmNavProvider =
//         Provider.of<BottomNavbarProvider>(context, listen: true);
//     final sizedBox = SizedBox(
//       height: 8.h,
//     );
//     return BottomNavigationBar(
//       backgroundColor: whiteColor,
//       onTap: (index) {
//         btmNavProvider.updateIndex(index);
//       },
//       type: BottomNavigationBarType.fixed,
//       selectedLabelStyle: TextStyle(color: lightBluishColor, fontSize: 0.sp),
//       unselectedLabelStyle: TextStyle(color: Colors.yellow, fontSize: 0.sp),
//       items: [
//         BottomNavigationBarItem(
//           icon: Column(
//             children: [
//               Image(
//                 width: 16.5.w,
//                 height: 17.h,
//                 image: AssetImage(
//                   btmNavProvider.getCurrentIndex == 0
//                       ? activeHomeIcon
//                       : inactiveHomeIcon,
//                 ),
//               ),
//               sizedBox,
//               Container(
//                 width: 3.w,
//                 height: 3.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: btmNavProvider.getCurrentIndex == 0
//                       ? lightBluishColor
//                       : Colors.transparent,
//                 ),
//               )
//             ],
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           label: '',
//           icon: Column(
//             children: [
//               Image(
//                 width: 16.5.w,
//                 height: 17.h,
//                 image: AssetImage(
//                   btmNavProvider.getCurrentIndex == 1
//                       ? activeCategotyIcon
//                       : inactiveCategotyIcon,
//                 ),
//               ),
//               sizedBox,
//               Container(
//                 width: 3.w,
//                 height: 3.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: btmNavProvider.getCurrentIndex == 1
//                       ? lightBluishColor
//                       : Colors.transparent,
//                 ),
//               )
//             ],
//           ),
//         ),
//         BottomNavigationBarItem(
//           icon: Column(
//             children: [
//               Image(
//                 width: 16.5.w,
//                 height: 17.h,
//                 image: AssetImage(
//                   btmNavProvider.getCurrentIndex == 2
//                       ? activeNotificationIcon
//                       : inactiveNotificationIcon,
//                 ),
//               ),
//               sizedBox,
//               Container(
//                 width: 3.w,
//                 height: 3.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: btmNavProvider.getCurrentIndex == 2
//                       ? lightBluishColor
//                       : Colors.transparent,
//                 ),
//               )
//             ],
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Column(
//             children: [
//               Image(
//                 width: 16.5.w,
//                 height: 17.h,
//                 image: AssetImage(
//                   btmNavProvider.getCurrentIndex == 3
//                       ? activeSettingIcon
//                       : inactiveSettingIcon,
//                 ),
//               ),
//               sizedBox,
//               Container(
//                 width: 3.w,
//                 height: 3.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: btmNavProvider.getCurrentIndex == 3
//                       ? lightBluishColor
//                       : Colors.transparent,
//                 ),
//               )
//             ],
//           ),
//           label: '',
//         ),
//       ],
//     );
//   }
// }
