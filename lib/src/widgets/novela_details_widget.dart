import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/novela_model.dart';
import 'package:app_movil_ces/src/theme/app_theme.dart';
import 'package:app_movil_ces/src/widgets/capitulo_widget.dart';

import 'novela_details_content_widget.dart';

class NovelaDetailsWidget extends StatefulWidget {
  const NovelaDetailsWidget({Key? key, required this.novela, required this.id})
      : super(key: key);
  final Novela novela;
  final String id;

  @override
  // ignore: library_private_types_in_public_api
  _NovelaDetailsWidgetState createState() => _NovelaDetailsWidgetState();
}

class _NovelaDetailsWidgetState extends State<NovelaDetailsWidget>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    const Tab(text: "Detalles"),
    const Tab(text: "Capítulos"),
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TabBar(
            indicatorColor: Palette.color,
            tabs: _tabs,
            controller: _tabController),
        body: TabBarView(controller: _tabController, children: [
          NovelaDetailsContentWidget(novela: widget.novela),
          CapituloWidget(id: widget.id)
        ]));
  }
}
