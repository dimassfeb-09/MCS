import 'package:flutter/material.dart';
import 'package:mcs_bab_5/providers/app_provider.dart';
import 'package:mcs_bab_5/widget/custom_read_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Agro Tech", style: appProvider.whiteRoboto14Bold),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: appProvider.mainColor,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // TEMPERATUR FIELD
                CustomReadField(
                  result: appProvider.field1model!.field1,
                  borderColor: appProvider.mainColor,
                  image: appProvider.thermoMeterImage,
                ),

                const SizedBox(height: 20),

                // HUMADITY FIELD
                CustomReadField(
                  result: appProvider.field2model!.field2,
                  borderColor: appProvider.mainColor,
                  image: appProvider.humiditySensorImage,
                ),

                const SizedBox(height: 20),

                // SOIL MOISTURE FIELD
                CustomReadField(
                  result: appProvider.field3model!.field3,
                  borderColor: appProvider.mainColor,
                  image: appProvider.soilAnalysisImage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
