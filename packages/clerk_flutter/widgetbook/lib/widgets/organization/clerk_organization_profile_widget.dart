import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/use_case_frame.dart';

@widgetbook.UseCase(name: 'Organization', type: ClerkOrganizationProfileWidget)
Widget buildClerkOrganizationProfileWidgetUseCase(BuildContext context) {
  return const UseCaseFrame(
    child: ClerkOrganizationProfileWidget(),
  );
}
