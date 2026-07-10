import 'package:flutter/material.dart';
import 'package:job_task/core/theme/app_colors.dart';


mixin Utility {
  // ---------------- Navigation ----------------

  /// Push a new page on top of the current one.
  /// Usage: navigateTo(context, const CartPage());

  /// Usage:
  ///   navigateTo(context, const CartPage());                       // normal push
  ///   navigateTo(context, const HomePage(), isReplacement: true);  // replace current
  Future<T?> navigateTo<T>(
      BuildContext context,
      Widget page, {
        bool isReplacement = false,
      }) {
    final route = MaterialPageRoute<T>(builder: (_) => page);

    if (isReplacement) {
      return Navigator.of(context).pushReplacement<T, dynamic>(route);
    }
    return Navigator.of(context).push<T>(route);
  }


  /// Push a new page and clear the whole stack (e.g. logout -> login).
  Future<T?> navigateToAndClearStack<T>(BuildContext context, Widget page) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
          (route) => false,
    );
  }

  /// Go back, optionally returning a result to the previous page.
  void navigateBack<T>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  // ---------------- Error view ----------------

  Widget getErrorView({
    required String message,
    required Future<void> Function() onRetry,
  }) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: AppColors.textGrey),
            const SizedBox(height: 12),
            Text(message, style: const TextStyle(color: AppColors.textGrey)),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: AppColors.card,
              ),
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );

  // ---------------- AppBar ----------------

  PreferredSizeWidget buildAppBar({
    required BuildContext context,
    Widget? actionWidget,
    bool showBackButton = false,
    VoidCallback? onBack,
    String title = 'Discover',
    String subtitle = 'Find your favorite products',
  }) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleSpacing: showBackButton ? 0 : 20,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: AppColors.ink,
        ),
        onPressed: onBack ?? () => Navigator.pop(context),
      )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
        ],
      ),
      actions: [
        if (actionWidget != null)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: actionWidget,
          ),
      ],
    );
  }

  // ---------------- Button with badge ----------------

  Widget getButtonBadge({
    required int itemCount,
    required VoidCallback onTap,
    IconData icon = Icons.shopping_bag_outlined,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: AppColors.ink, size: 24),
              if (itemCount > 0)
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                    const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$itemCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.card,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  // ---------------- Empty view ----------------

  Widget getEmptyView({
    String title = 'Nothing here yet',
    String subtitle = 'Try adjusting your search or category',
    IconData icon = Icons.inventory_2_outlined,
  }) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.card,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppColors.ink.withOpacity(0.35),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textGreyLight,
              ),
            ),
          ],
        ),
      );
  void showSnack(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
  }
}