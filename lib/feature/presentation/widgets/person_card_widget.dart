import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';

import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

/// Класс отображения персонажей, UI
class PersonCard extends StatelessWidget {
  final PersonEntities person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            child: PersonCacheImage(
                imageUrl: person.image, height: 160, widht: 160),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  person.name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                      child: person.status != 'Alive'
                          ? const Icon(
                              Icons.sentiment_very_dissatisfied_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.sentiment_very_satisfied_outlined,
                              color: Colors.green,
                            ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text('${person.status} - ${person.species}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Last known Location',
                  style: TextStyle(color: AppColors.greyBackground),
                ),
                const SizedBox(height: 4),
                Text(
                  person.location!.name,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Origin',
                  style: TextStyle(color: AppColors.greyBackground),
                ),
                const SizedBox(height: 4),
                Text(
                  person.origin!.name,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
    );
  }
}
