import 'package:flutter/material.dart';

class Todocard extends StatelessWidget {
  final String titre;
  final bool etat;
  final Function changer;
  final Function supprimerElement;
  final Function modifierElement;
  final int i;
  const Todocard(
      {super.key,
      required this.titre,
      required this.etat,
      required this.changer,
      required this.i,
      required this.supprimerElement, required this.modifierElement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changer(i);
      },
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(22),
          decoration: BoxDecoration(
              color: Color.fromRGBO(209, 224, 224, 0.2),
              borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  titre,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Row(children: [
                Tooltip(
                message: etat ? "Tâche complétée" : "Tâche non complétée",
                  child: Icon(
                    etat ? Icons.check : Icons.close,
                    color: etat ? Colors.green : Colors.red,
                  ),
                ),
                Tooltip(
                  message: "Modifier ",
                  child: IconButton(
                    icon: Icon(
                      Icons.update, // Icône de modification
                      color:
                      Colors.white, // Couleur blanche pour la modification
                    ),
                    onPressed: () {

                      modifierElement(i);
                    },
                  ),
                ),
                Tooltip(
                  message: "Supprimer tâche",
                  child: IconButton(
                    icon: Icon(
                      Icons.delete, // Icône de suppression
                      color:
                          Colors.white, // Couleur blanche pour la suppression
                    ),
                    onPressed: () {

                      supprimerElement(i);
                    },
                  ),
                ),

              ])
            ],
          ),
        ),
      ),
    );
  }
}
