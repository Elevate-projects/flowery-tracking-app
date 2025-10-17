import 'package:flowery_tracking_app/presentation/auth/application_approved/views/widgets/application_approved_view_body.dart';
import 'package:flutter/material.dart';

class ApplicationApprovedView extends StatelessWidget {
  const ApplicationApprovedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ApplicationApprovedViewBody()));
  }
}
