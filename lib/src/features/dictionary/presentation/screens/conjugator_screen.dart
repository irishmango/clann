import 'package:clann/src/features/dictionary/presentation/widgets/conjugator.dart';
import 'package:clann/src/features/dictionary/presentation/widgets/conjugator_chip.dart';
import 'package:flutter/material.dart';

class ConjugatorScreen extends StatefulWidget {
  const ConjugatorScreen({super.key});

  @override
  State<ConjugatorScreen> createState() => _ConjugatorScreenState();
}

class _ConjugatorScreenState extends State<ConjugatorScreen> {
  int selected = 0;

  // Placeholder data for one sample verb ("rith" - to run). Real implementation would fetch/generate.
  late final List<ConjugationData> tenses = [
    ConjugationData(
      title: 'Present Tense (An Aimsir Láithreach)',
      ga: [
        'rithim',
        'ritheann tú',
        'ritheann sé/sí',
        'rithimid',
        'ritheann sibh',
        'ritheann siad',
      ],
      en: [
        'I run',
        'you run',
        'he/she runs',
        'we run',
        'you (plural) run',
        'they run',
      ],
    ),
    ConjugationData(
      title: 'Past Tense (An Aimsir Chaite)',
      ga: [
        'Rith mé',
        'Rith tú',
        'Rith sé/sí',
        'Ritheamar',
        'Rith sibh',
        'Rith siad',
      ],
      en: [
        'I ran',
        'you ran',
        'he/she ran',
        'we ran',
        'you (plural) ran',
        'they ran',
      ],
    ),
    ConjugationData(
      title: 'Future Tense (An Aimsir Fháistinach)',
      ga: [
        'Rithfidh mé',
        'Rithfidh tú',
        'Rithfidh sé/sí',
        'Rithfimid',
        'Rithfidh sibh',
        'Rithfidh siad',
      ],
      en: [
        'I will run',
        'you will run',
        'he/she will run',
        'we will run',
        'you (plural) will run',
        'they will run',
      ],
    ),
    ConjugationData(
      title: 'Conditional (An Modh Coinníollach)',
      ga: [
        'Rithfinn',
        'Rithfeá',
        'Rithfeadh sé/sí',
        'Rithfimis',
        'Rithfeadh sibh',
        'Rithfidís',
      ],
      en: [
        'I would run',
        'you would run',
        'he/she would run',
        'we would run',
        'you (plural) would run',
        'they would run',
      ],
    ),
    ConjugationData(
      title: 'Imperative (An Modh Ordaitheach)',
      ga: [
        '—',
        'Rith',
        'Ritheadh sé/sí',
        'Rithimis',
        'Rithigí',
        'Ritheadh siad',
      ],
      en: [
        '—',
        'Run (you)',
        'Let him/her run',
        "Let's run",
        'Run (you plural)',
        'Let them run',
      ],
    ),
    ConjugationData(
      title: 'Verbal Noun / Adjective',
      ga: ['Rith', 'Rith (VN)', 'Rithe (Adj Participle)'],
      en: ['Run (verb root)', 'Running', 'Run / Running (adj)'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 18),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: tenses.length,
            itemBuilder: (context, index) {
              return ConjugatorChip(
                label: tenses[index].title.split('(').first.trim(),
                selected: selected == index,
                onSelected: () {
                  setState(() => selected = index);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        Conjugator(data: tenses[selected]),
      ],
    );
  }
}
