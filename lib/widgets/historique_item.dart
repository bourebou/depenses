// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Historiqueitem extends StatelessWidget {
  final double montant;
  final String libelle;
  final String texteData;
  final IconData icone;

  const Historiqueitem({
    Key? key,
    required this.montant,
    required this.libelle,
    required this.texteData,
    required this.icone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),

      //permet de creer l espace avec l exterieur
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
          blurRadius: 4,//DEGRADE  DE L OMBRE
         offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            libelle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Gap(10),
          Row(
            children: [
              Text('\$$montant'),
              const Spacer(),
              Icon(icone),
              const Gap(16 / 2),
              Text(texteData),
              //espace autant que possible
            ],
          ),
        ],
      ),
    );
  }
}
