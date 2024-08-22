import 'package:flutter/material.dart';
import 'package:navicode/constants/strings.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required FocusNode focusNode,
  }) : _focusNode = focusNode;

  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: mainSearchBar,
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: TextField(
          focusNode: _focusNode,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(15),
            isCollapsed: true,
            icon: Icon(Icons.search),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
