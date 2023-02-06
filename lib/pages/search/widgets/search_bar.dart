import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_typography.dart';

class SearchBar extends StatefulWidget {
  final void Function(String? value) onSubmitText;
  final void Function() onCleared;

  const SearchBar({
    Key? key,
    required this.onSubmitText,
    required this.onCleared,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textController;
  bool _textIsEmpty = true;

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  void _clearText() {
    widget.onCleared();
    _textController.clear();
    setState(() {
      _textIsEmpty = !_textIsEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _textIsEmpty = value.isEmpty;
          });
        },
        controller: _textController,
        style: AppTypography.labelMedium,
        onSubmitted: widget.onSubmitText,
        cursorColor: Colors.white.withOpacity(0.2),
        decoration: InputDecoration(
          filled: true,
          hoverColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(4),
          fillColor: AppColors.onSurfaceColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          hintStyle: AppTypography.labelMedium.copyWith(
            color: Colors.grey,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: SvgPicture.asset('assets/images/ic-search.svg'),
          ),
          hintText: 'Search...',
          suffixIcon: _textIsEmpty
              ? null
              : IconButton(
                  style: IconButton.styleFrom(
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: _clearText,
                  icon: const Icon(Icons.clear),
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
