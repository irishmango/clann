import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Function(int) onRouteTapped;
  final int selectedIndex;

  const NavBar({
    super.key,
    required this.onRouteTapped,
    this.selectedIndex = 2,
  });

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = Color.fromRGBO(101, 167, 130, 1);
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(120),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarButton(
            parent: this,
            selectedColor: selectedColor,
            icon: Icons.school,
            index: 0,
            label: "Learn",
          ),
          NavBarButton(
            parent: this,
            selectedColor: selectedColor,
            icon: Icons.menu_book_rounded,
            index: 1,
            label: "Dictionary",
          ),
          NavBarButton(
            parent: this,
            selectedColor: selectedColor,
            icon: Icons.home,
            index: 2,
            label: "Home",
          ),
          NavBarButton(
            parent: this,
            selectedColor: selectedColor,
            icon: Icons.favorite,
            index: 3,
            label: "Notes",
          ),
          NavBarButton(
            parent: this,
            selectedColor: selectedColor,
            icon: Icons.person,
            index: 4,
            label: "Profile",
          ),
        ],
      ),
            ),
    );
  }
}


class NavBarButton extends StatelessWidget {
  const NavBarButton({
    super.key,
    required this.parent,
    required this.selectedColor,
    required this.icon,
    required this.index,
    required this.label,
  });

  final NavBar parent;
  final Color selectedColor;
  final IconData icon;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color unselectedColor = Theme.of(context).colorScheme.onSurfaceVariant;
    final bool isSelected = parent.selectedIndex == index;
    return InkWell(
      onTap: () => parent.onRouteTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 52, minHeight: 90),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: isSelected ? selectedColor : unselectedColor,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
