import 'package:flutter/material.dart';
import 'package:movie_app_assessment/core/theme/app_colors.dart';
import 'package:movie_app_assessment/core/theme/app_typography.dart';
import 'package:movie_app_assessment/core/utils/app_path.dart';

import '../../../../core/utils/app_strings.dart';

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key,
      this.onChanged,
      this.onSearch,
      this.autoFocus = true,
      this.showPrefixIcon = true,
      this.showSuffixIcon = true});
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSearch; // Callback for search icon click
  final bool autoFocus;
  final bool showPrefixIcon;
  final bool showSuffixIcon;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    // Add listener to rebuild when text changes
    _searchController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: _searchController,
        onChanged: widget.onChanged,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hintText: AppStrings.searchHint,
          hintStyle: AppTypography.titleSmall.copyWith(color: AppColors.textPrimary.withValues(alpha: 0.3)),
          prefixIcon: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(50), // Makes splash circular
              splashColor: Colors.grey.withValues(alpha: 0.3), // Splash effect
              highlightColor: Colors.grey.withValues(alpha: 0.2),
              onTap: _clearSearch,
              child: AppSvgWidget.searchIcon, // Clears the field
            ),
          ),
          suffixIcon: !widget.showSuffixIcon || _searchController.text.isEmpty
              ? null
              : Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50), // Makes splash circular
                    splashColor: Colors.grey.withValues(alpha: 0.3), // Splash effect
                    highlightColor: Colors.grey.withValues(alpha: 0.2),
                    onTap: _clearSearch,
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: AppColors.textPrimary,
                    ), // Clears the field
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.lightGray,
        ),
      ),
    );
  }
}
