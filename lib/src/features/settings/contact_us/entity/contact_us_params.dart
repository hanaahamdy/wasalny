import 'package:flutter/widgets.dart';

import '../../../../core/extensions/form_mixin.dart';

class ContactUsParams with FormMixin {
  final TextEditingController messageController = TextEditingController();

  void dispose() {
    messageController.dispose();
  }

  Map<String, dynamic> toJson() {
    return {'subject': 'Contact us', 'message': messageController.text.trim()};
  }
}
