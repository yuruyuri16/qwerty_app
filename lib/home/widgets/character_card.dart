import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:shimmer/shimmer.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.character,
    super.key,
  });

  final Character character;

  static const statusColor = {
    CharacterStatus.alive: AppColors.green,
    CharacterStatus.dead: AppColors.red,
    CharacterStatus.unknown: AppColors.grey,
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(AppSpacing.sm),
            ),
            child: CachedNetworkImage(
              imageUrl: character.image,
              width: size.width * 0.3,
              height: size.width * 0.3,
              placeholder: (_, __) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey.shade100,
                  child: const ColoredBox(color: Colors.white),
                );
              },
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name, style: textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: statusColor[character.status],
                          shape: BoxShape.circle,
                        ),
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        character.status.name.capitalized,
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringX on String {
  ///
  String get capitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
