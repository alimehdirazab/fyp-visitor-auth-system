import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';

class SearchableDropdownButton extends StatefulWidget {
  final List<String> items;
  final String topValue;
  const SearchableDropdownButton(
      {Key? key, required this.items, required this.topValue})
      : super(key: key);

  @override
  State<SearchableDropdownButton> createState() =>
      _SearchableDropdownButtonState();
}

class _SearchableDropdownButtonState extends State<SearchableDropdownButton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: [
                const Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    widget.topValue,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: widget.items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
          ),
        ),
      ),
    );
  }
}
