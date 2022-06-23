import 'package:admin/models/RecentReport.dart';
import 'package:admin/screens/view_report/view/view_report_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class RecentReports extends StatelessWidget {
  const RecentReports({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Reports",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("File Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
              ],
              rows: List.generate(
                demoRecentReports.length,
                (index) =>
                    recentReportDataRow(context, demoRecentReports[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentReportDataRow(BuildContext context, RecentReport fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
        onTap: () => _onRecentReportDataRowTapped(context, fileInfo),
      ),
      DataCell(
        Text(fileInfo.date!),
        onTap: () => _onRecentReportDataRowTapped(context, fileInfo),
      ),
    ],
  );
}

void _onRecentReportDataRowTapped(BuildContext context, RecentReport fileInfo) {
  Navigator.of(context).push(
    ViewReportPage.route(fileInfo: fileInfo),
  );
}
