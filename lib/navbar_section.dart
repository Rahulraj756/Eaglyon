import 'package:flutter/material.dart';
import 'package:my_practice_app/Data_Model/site_data.dart';
import 'package:my_practice_app/Themes_Data/themes_colors.dart';

class NavbarSection extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onMenuSelected;
  final VoidCallback onAdminPressed;

  const NavbarSection({
    super.key,
    required this.onMenuSelected,
    required this.onAdminPressed,
    required Null Function() onAdminClosed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20.0),
      decoration: const BoxDecoration(color: AppColors.backgroundDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. LEFT: Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.pets,
                    size: 20,
                    color: AppColors.primaryGold,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                SiteData.logoText,
                style: const TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),

          // 2. CENTER: Nav Links (Desktop) with Hover Widget
          if (isDesktop)
            Row(
              children: [
                NavItemHover(
                  title: 'Home',
                  onTap: () => onMenuSelected('Home'),
                ),
                const SizedBox(width: 24),
                NavItemHover(
                  title: 'About',
                  onTap: () => onMenuSelected('About'),
                ),
                const SizedBox(width: 24),
                NavItemHover(
                  title: 'Services',
                  onTap: () => onMenuSelected('Services'),
                ),
                const SizedBox(width: 24),
                NavItemHover(
                  title: 'Projects',
                  onTap: () => onMenuSelected('Projects'),
                ),
                const SizedBox(width: 24),
                NavItemHover(
                  title: 'Pricing',
                  onTap: () => onMenuSelected('Pricing'),
                ),
                const SizedBox(width: 24),
                NavItemHover(
                  title: 'Contact',
                  onTap: () => onMenuSelected('Contact'),
                ),
              ],
            ),

          // 3. RIGHT: Admin Button / Hamburger Menu (Mobile)
          if (isDesktop)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onAdminPressed,
              icon: const Icon(Icons.admin_panel_settings, size: 18),
              label: const Text(
                'Admin Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            )
          else
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: AppColors.textWhite,
                  size: 28,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
        ],
      ),
    );
  }
}

// Dedicated Hover Widget taaki state properly update ho sake
class NavItemHover extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const NavItemHover({super.key, required this.title, required this.onTap});

  @override
  State<NavItemHover> createState() => _NavItemHoverState();
}

class _NavItemHoverState extends State<NavItemHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isHovered ? AppColors.primaryGold : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}

// Mobile End Drawer
class MobileEndDrawer extends StatelessWidget {
  final Function(String) onMenuSelected;
  final VoidCallback onAdminPressed;

  const MobileEndDrawer({
    super.key,
    required this.onMenuSelected,
    required this.onAdminPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Navigation',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textWhite),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(color: AppColors.borderSubtle, height: 30),
            _drawerItem(
              context,
              'Home',
              Icons.home,
              () => onMenuSelected('Home'),
            ),
            _drawerItem(
              context,
              'About',
              Icons.person,
              () => onMenuSelected('About'),
            ),
            _drawerItem(
              context,
              'Services',
              Icons.design_services,
              () => onMenuSelected('Services'),
            ),
            _drawerItem(
              context,
              'Projects',
              Icons.folder,
              () => onMenuSelected('Projects'),
            ),
            _drawerItem(
              context,
              'Pricing',
              Icons.price_change,
              () => onMenuSelected('Pricing'),
            ),
            _drawerItem(
              context,
              'Contact',
              Icons.mail,
              () => onMenuSelected('Contact'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onAdminPressed();
                },
                icon: const Icon(Icons.admin_panel_settings, size: 18),
                label: const Text(
                  'Admin Panel',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGold, size: 20),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textWhite, fontSize: 16),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
