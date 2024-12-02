import 'package:flutter/material.dart';
import 'package:helloworld/module/setting/section_card_with_heading.dart';

class SettingsAccountSection extends StatefulWidget {

  const SettingsAccountSection({super.key});

  @override
  State<SettingsAccountSection> createState() => SettingsAccountSectionState();

}

class SettingsAccountSectionState extends State<SettingsAccountSection> {

  @override
  Widget build(BuildContext context) {
    return const SectionCardWithHeading(
        heading: "账户",
        children: []
    );
  }

}