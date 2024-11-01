import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:spot_movie/core/theme/app_dimensions.dart';
import 'package:spot_movie/features/movie/domain/entities/movie_entity.dart';
import '../../../../core/theme/app_colors.dart';

class AutoCompleteSearchWidget extends StatefulWidget {
  const AutoCompleteSearchWidget({
    required this.suggestionsCallback,
    required this.textController,
    this.onClearTap,
    this.onSelected,
    super.key,
  });
  final FutureOr<List<MovieEntity>?> Function(String) suggestionsCallback;
  final void Function(TextEditingController controller)? onClearTap;
  final void Function(MovieEntity)? onSelected;
  final TextEditingController textController;

  @override
  State<AutoCompleteSearchWidget> createState() =>
      _AutoCompleteSearchWidgetState();
}

class _AutoCompleteSearchWidgetState extends State<AutoCompleteSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final textFieldBorder = BorderSide(
      color: AppColors.borderColor,
      width: 1.5,
    );
    return TypeAheadField<MovieEntity>(
      controller: widget.textController,
      suggestionsCallback: widget.suggestionsCallback,
      onSelected: widget.onSelected,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          onTapOutside: (_) {
            focusNode.unfocus();
          },
          decoration: InputDecoration(
            hintText: 'Search movie',
            contentPadding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
            fillColor: const Color(0xFF1E1D1D).withOpacity(0.97),
            filled: true,
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.largeRadius),
              ),
              borderSide: textFieldBorder,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.largeRadius),
              ),
              borderSide: textFieldBorder,
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.largeRadius),
              ),
              borderSide: textFieldBorder,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(AppDimensions.largeRadius),
              ),
              borderSide: textFieldBorder,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                widget.onClearTap?.call(controller);
              },
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ),
        );
      },
      decorationBuilder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: child,
        );
      },
      itemBuilder: (context, suggestion) {
        return ColoredBox(
          color: const Color(0xFF1E1D1D).withOpacity(0.97),
          child: ListTile(
            leading: const Icon(Icons.movie_rounded),
            title: Text(suggestion.title),
            subtitle: suggestion.locations != null
                ? Text(suggestion.locations ?? '')
                : null,
          ),
        );
      },
      loadingBuilder: (context) => const SizedBox(),
      emptyBuilder: (context) => const SizedBox(),
    );
  }
}