import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/novela_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_movil_ces/src/providers/main_provider.dart';
import 'package:app_movil_ces/src/theme/app_theme.dart';
import 'package:app_movil_ces/src/widgets/novela_details_widget.dart';
import 'package:provider/provider.dart';

class NovelaPage extends StatelessWidget {
  const NovelaPage({Key? key, required this.novela, required this.id})
      : super(key: key);
  final Novela novela;
  final String id;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);

    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(
      slivers: [
        SliverAppBar(
            iconTheme: mainProvider.mode
                ? const IconThemeData(color: Colors.black)
                : const IconThemeData(color: Palette.color),
            floating: true,
            pinned: true,
            elevation: 2,
            expandedHeight: 200.h,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(novela.portada ?? ""),
                      fit: BoxFit.cover)),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    alignment: Alignment.center,
                    color: mainProvider.mode
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.black.withOpacity(0.3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                            child: Image.network(novela.portada ?? "",
                                alignment: Alignment.bottomLeft,
                                fit: BoxFit.fitHeight)),
                        SizedBox(
                            width: 165.h,
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text("TÍTULO:"),
                                      subtitle: Text(novela.titulo ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    ListTile(
                                      title: const Text("AUTOR:"),
                                      subtitle: Text(novela.autor ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ))),
        SliverFillRemaining(child: NovelaDetailsWidget(novela: novela, id: id))
      ],
    )));
  }
}
