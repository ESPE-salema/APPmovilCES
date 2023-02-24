import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_movil_ces/src/models/capitulo_model.dart';
import 'package:app_movil_ces/src/widgets/capitulo_card.dart';
import 'package:app_movil_ces/src/widgets/capitulo_firebase_form_widget.dart';

class CapituloWidget extends StatefulWidget {
  const CapituloWidget({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  // ignore: library_private_types_in_public_api
  _CapituloWidgetState createState() => _CapituloWidgetState();
}

class _CapituloWidgetState extends State<CapituloWidget> {
  late Stream<QuerySnapshot> _capitulosRef;

  @override
  void initState() {
    super.initState();
    _capitulosRef = FirebaseFirestore.instance
        .collection('novelas')
        .doc(widget.id)
        .collection('capitulos')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _capitulosRef,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Un error ha ocurrido"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox.square(
                  dimension: 50.0, child: CircularProgressIndicator()));
        }

        return Scaffold(
            body: snapshot.data == null
                ? const Center(
                    child: SizedBox.square(
                        dimension: 50.0, child: CircularProgressIndicator()))
                : snapshot.data!.docs.isEmpty
                    ? const Center(child: Text("No hay capitulos que mostrar"))
                    : ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          Capitulo model = Capitulo.fromJson(data);
                          return CapituloCard(model: model);
                        }).toList(),
                      ),
            floatingActionButton: FloatingActionButton(
              elevation: 4,
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CapituloFirebaseFormWidget(
                            id: widget.id, size: snapshot.data!.size),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ));
      },
    );
  }
}
