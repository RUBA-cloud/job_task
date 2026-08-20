import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:job_task/core/theme/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.onMyOrders,
    required this.onSettings,
    required this.onAbout,
    required this.onBranches,
    required this.onLogout, required this.onHomePage,
  });

  final VoidCallback onMyOrders;
  final VoidCallback onSettings;
  final VoidCallback onAbout;
  final VoidCallback onBranches;
  final VoidCallback onLogout;
  final VoidCallback onHomePage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 30.h,
              ),
              decoration: const BoxDecoration(
                color: AppColors.ink,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: AppColors.surface,
                    child: Icon(
                      Icons.person,
                      size: 40.sp,
                      color: AppColors.ink,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color:  AppColors.surface,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Shopping App",
                    style: TextStyle(
                      color:  AppColors.surface,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            _drawerItem(
              icon: Icons.receipt_long_outlined,
              title: "Home Page",
              onTap: () {
                Navigator.pop(context);
                onMyOrders();
              },
            ),
            _drawerItem(
              icon: Icons.receipt_long_outlined,
              title: "My Orders",
              onTap: () {
                Navigator.pop(context);
                onMyOrders();
              },
            ),

            _drawerItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {
                Navigator.pop(context);
                onSettings();
              },
            ),

            _drawerItem(
              icon: Icons.info_outline,
              title: "About",
              onTap: () {
                Navigator.pop(context);
                onAbout();
              },
            ),

            _drawerItem(
              icon: Icons.support_agent_outlined,
              title: "Contact Us",
              onTap: () {
                Navigator.pop(context);
                onBranches();
              },
            ),

            const Spacer(),

            const Divider(),

            _drawerItem(
              icon: Icons.logout,
              iconColor: AppColors.redColor,
              textColor: Colors.red,
              title: "Logout",
              onTap: () {
                Navigator.pop(context);
                onLogout();
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.ink,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}