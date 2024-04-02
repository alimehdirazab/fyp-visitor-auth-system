import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey[200],
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: InputBorder.none,
                hintText: 'Search',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            CircleAvatar(
              radius: 25,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_alt_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
