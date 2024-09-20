// ignore_for_file: prefer_const_constructors
import 'package:agenda_zen/widgets/compteur.dart';
import 'package:agenda_zen/widgets/Agenda-card.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgendaZen(),
    );
  }
}

final myController = TextEditingController();

class AgendaZen extends StatefulWidget {
  const AgendaZen({super.key});

  @override
  State<AgendaZen> createState() => _TodoAppState();
}

// Classe Task
class Task {
  String title;
  bool status;

  Task({
    required this.title,
    required this.status,
  });



}

class _TodoAppState extends State<AgendaZen> {
  List<Task> allTasks = [
Task(title: "Créer un formulaire d'inscription réactif", status: true),
    Task(title: "Implémenter une modal de confirmation de commande", status: true),
    Task(title: "Améliorer les performances de chargement de la page d'accueil", status: false),
    Task(title: "Développer une API REST pour gérer les utilisateurs", status: false),
    Task(title: "Intégrer un système de paiement en ligne", status: false),
    Task(title: "Optimiser la requête de base de données la plus lente", status: false),
    Task(title: " Migrer l'application vers un nouveau framework", status: false),
  ];




  void modifierElement(int index) {
    // Pré-remplir le champ de texte avec la valeur actuelle de la tâche à modifier
    element.text = allTasks[index].title;

    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11)),
            child: Container(
              padding: EdgeInsets.all(22),
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: element,
                    maxLength: 80,
                    decoration: InputDecoration(hintText: "Modifier l'élément"),
                  ),
                  SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: () {
                      // Modifier l'élément à l'index donné avec le nouveau titre
                      setState(() {
                        allTasks[index].title = element.text;
                      });
                      element.clear(); // Effacer le texte après modification

                      Navigator.pop(context); // Fermer la boîte de dialogue
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Text(
                      "MODIFIER",
                      style: TextStyle(fontSize: 22),
                    ),

                  ),

                ],
              ),
            ),
          );
        },
      );
    });
  }


  // Ajouter une tâche
  void ajouterElement() {
    setState(() {
      allTasks.add(Task(status: false, title: element.text));

    });
  }

  // Supprimer une tâche
  void supprimerElement(int i) {
    setState(() {
      allTasks.removeAt(i);

    });
  }

  // Supprimer toutes les tâches
  void supprimerToutesLesTaches() {
    setState(() {
      allTasks.clear(); // Effacer toutes les tâches

    });
  }



  changerElement(int i) {
    setState(() {
      allTasks[i].status = !allTasks[i].status;
    });
  }

  int nbrTrue() {
    int copTasck = 0;
    for (var item in allTasks) {
      if (item.status) {
        copTasck++;
      }
    }
    return copTasck;
  }



  final element = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11)),
                child: Container(
                  padding: EdgeInsets.all(22),
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ajuster la hauteur en fonction du contenu
                    children: [
                      TextField(
                          controller: element,
                          maxLength: 20,
                          decoration:
                              InputDecoration(hintText: "Ajouter un element")),
                      SizedBox(height: 22),
                      ElevatedButton(
                        onPressed: () {
                          ajouterElement();
                          element.clear();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.redAccent, // Bouton rouge pour contraste
                        ),
                        child: Text(
                          "AJOUTER",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
      backgroundColor:
          Color.fromRGBO(48, 63, 92, 1), // Fond plus foncé et subtil
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent, // Couleur plus vive pour la barre
        title: Center(
          child: Text(
            "AgendaZen",
            style: TextStyle(
              fontSize: 33,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Ajout du bouton delete dans la barre d'applications
        actions: [
          Tooltip(
            message: "Supprimer tous les tâches",
            child: IconButton(
              icon: Icon(Icons.delete_forever), // Icône de suppression
              color: Colors.white,
              // Couleur de l'icône
              onPressed: () {
                // Logique de suppression, par exemple pour tout effacer
                supprimerToutesLesTaches(); // Appel d'une fonction pour supprimer toutes les tâches
              },
            ),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16), // Padding autour des éléments
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Utilisation du widget Compteur

            Compteur(
              completedTasks: nbrTrue(),
              totalTasks: allTasks.length,
            ),
            // Ajout d'un fond pour les cartes

            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: allTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Todocard(
                      titre: allTasks[index].title,
                      etat: allTasks[index].status,
                      changer: changerElement,
                      supprimerElement: supprimerElement,
                      modifierElement: modifierElement,
                      i: index,
                    );
                  }),
            ),
          ],
        ),
      ),

    );
  }
}
