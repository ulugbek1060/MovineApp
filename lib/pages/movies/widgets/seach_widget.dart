import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/theme/app_typography.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
      child: TextField(
        style: AppTypography.labelMedium,
        cursorColor: Colors.white.withOpacity(0.2),
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(4),
          fillColor: Theme.of(context).secondaryHeaderColor,
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
        ),
      ),
    );
  }
}
