import 'package:flowery_tracking_app/domain/entities/country/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryItem extends StatelessWidget {
  const CountryItem({super.key, required this.countryData});
  final CountryEntity countryData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(countryData.flag),
        const RSizedBox(width: 8),
        Text(
          countryData.countryName,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
