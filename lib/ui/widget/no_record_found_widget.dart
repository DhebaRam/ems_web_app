import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/base_components/base_assets.dart';
import '../../common/base_components/base_text.dart';
import '../../common/base_components/strings_class.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(BaseAssets.noRecordFoundImage),
        const BaseText(value: Strings.noEmployeeRecordsFound, fontSize: 19, fontWeight: FontWeight.w500, textAlign: TextAlign.center,)
      ],
    );
  }
}
