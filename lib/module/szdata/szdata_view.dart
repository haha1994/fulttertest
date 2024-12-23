
import 'package:flutter/material.dart';
import 'package:helloworld/module/szdata/szdata_api.dart';
import 'package:logger/logger.dart';

class SzDataView extends StatefulWidget {
  static const String name = "szDataView";
  const SzDataView({super.key});

  @override
  State<SzDataView> createState() => SzDataViewState();
}

class SzDataViewState extends State<SzDataView> {
  final Logger logger = Logger();

  int pageIndex = 0;
  int rowsPerPage = 10;

  //int sortColumnIndex;
  bool sortAscending = true;
  final data = [];
  int totalCount = 0;
  bool isLoading = false;

  final SzdataApi szApi = SzdataApi();

  /// todo
  void loadDataFromBackend(int offset, int limit) {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    int pageNumber = offset ~/ rowsPerPage;
    Map<String, dynamic> queryParameter = {'page': pageNumber, 'rows': limit};

    szApi.findSecondHandDeal(
        queryParameters: queryParameter,
        requestCallBack: (result) {
          setState(() {
            try {
              pageIndex = pageNumber;
              totalCount = result.total!;
              data.clear();
              data.insertAll(0, result.data as Iterable);
              // data.addAll(result.data as Iterable);
              isLoading = false;
            } catch (e) {
              logger.e(e);
            }
          });
        });
  }

  @override
  void initState() {
    super.initState();
    loadDataFromBackend(0, rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('view page'),
        ),
        body: SingleChildScrollView(
          child: PaginatedDataTable(
            source: SzDataSource(data, totalCount, rowsPerPage),
            rowsPerPage: rowsPerPage,
            initialFirstRowIndex: 0,
            availableRowsPerPage: const [10, 20, 50],
            onRowsPerPageChanged: (value) => setState(() {
              // todo
              if (value != null) {
                rowsPerPage = value;
                loadDataFromBackend(0, rowsPerPage);
              }
            }),
            onPageChanged: (index) {
              logger.i(index);
              //int offset = pageNumber * _rowsPerPage;
              loadDataFromBackend(index, rowsPerPage);
            },
            columns: const <DataColumn>[
              DataColumn(label: Text("区域")),
              DataColumn(label: Text("类型")),
              DataColumn(label: Text("成交套数")),
              DataColumn(label: Text("成交面积")),
              DataColumn(label: Text("提交时间")),
            ],
          ),
        ));
  }
}

class SzDataSource extends DataTableSource {
  final List<dynamic> sourceData;
  final int totalCount;
  final int rowsPerPage;

  SzDataSource(this.sourceData, this.totalCount, this.rowsPerPage);

  set rowsPerPage(int value) {
    rowsPerPage = value;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalCount;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    index = index % rowsPerPage;
    if (index >= sourceData.length) {
      return const DataRow(cells: [
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text("")),
        DataCell(Text(""))
      ]);
    }
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(sourceData[index].zone)),
      DataCell(Text(sourceData[index].houseUsage2)),
      DataCell(Text(sourceData[index].cjNum.toString())),
      DataCell(Text(sourceData[index].cjArea.toString())),
      DataCell(Text(sourceData[index].tjDate))
    ]);
  }
}
