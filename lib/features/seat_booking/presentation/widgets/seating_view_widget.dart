import 'package:flutter/material.dart';
import 'package:seatsio/seatsio.dart';

class SeatView extends StatefulWidget {
  const SeatView({super.key});

  @override
  State<SeatView> createState() => _SeatViewState();
}

class _SeatViewState extends State<SeatView> {
  SeatsioWebViewController? _seatsioController;
  final List<String> selectedObjectLabels = ['Try to click a seat object'];

  late SeatingChartConfig _chartConfig;

  @override
  void initState() {
    super.initState();

    _chartConfig = SeatingChartConfig.init().rebuild((b) => b
      ..workspaceKey = 'YourWorkspaceKey'
      ..eventKey = 'YourEventKey'
      ..session = "start");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 300,
          child: _buildSeatsioView(),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
              itemCount: selectedObjectLabels.length, itemBuilder: (_, index) => Text(selectedObjectLabels[index])),
        )
      ],
    );
  }

  Widget _buildSeatsioView() {
    return SeatsioWebView(
      onWebViewCreated: (controller) {
        _seatsioController = controller;
        _loadSeatsio();
      },
      onChartRendered: (_) => print("[Seatsio]->[example]-> onChartRendered"),
      onChartRenderingFailed: () => print("[Seatsio]->[example]-> onChartRenderingFailed"),
      onObjectSelected: (object, type) {
        print("[Seatsio]->[example]-> onObjectSelected, label: ${object.label}");
        _selectSeat(object);
      },
      onObjectDeselected: (object, type) {
        print("[Seatsio]->[example]-> onObjectDeselected, label: ${object.label}");
        _deselectSeat(object);
      },
      onHoldSucceeded: (objects, ticketTypes) {
        print("[Seatsio]->[example]-> onObjectSelected, objects: $objects | ticket types: $ticketTypes");
      },
      onHoldTokenExpired: () {
        print("[Seatsio]->[example]-> onHoldTokenExpired");
      },
      onSessionInitialized: (holdToken) {
        print("[Seatsio]->[example]-> onSessionInitialized, holdToken: $holdToken");
      },
    );
  }

  void _selectSeat(SeatsioObject object) {
    setState(() {
      selectedObjectLabels.add(object.label);
    });
  }

  void _deselectSeat(SeatsioObject object) {
    if (selectedObjectLabels.contains(object.label)) {
      setState(() {
        selectedObjectLabels.remove(object.label);
      });
    }
  }

  void _loadSeatsio() {
    final newChartConfig = _chartConfig.rebuild((b) => b..showLegend = false);
    _seatsioController?.reload(newChartConfig);
  }
}
