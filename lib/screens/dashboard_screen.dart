import 'package:flutter/material.dart';
import 'package:pos_mobile_app/models/generic/dashboard_item_model.dart';
import 'package:pos_mobile_app/screens/list_template/dashboard_list_items.dart';


class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Text('Shift#: '),
          ],
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: DashboardItemModel().dashboardItemModel.length,
        shrinkWrap: true,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, position) {
          return DashboardListItem(
            dashboardItem : DashboardItemModel().dashboardItemModel[position],
             height : 250.0,
            width : 250.0,
                onTap : () {
              print(DashboardItemModel().dashboardItemModel[position].name);
            },
          );
        },
      ),
    );
  }
}
