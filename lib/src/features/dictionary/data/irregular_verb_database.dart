/// Irish Irregular Verb Database (initial draft)
/// --------------------------------------------------------------
/// This file defines a lightweight in-memory dataset of the core
/// Irish irregular verbs and their main synthetic/person forms
/// across common simple tenses. It mirrors the 6-line layout
/// already used in the temporary `ConjugationData` structure:
///   0: 1st person singular (mé)
///   1: 2nd person singular (tú)
///   2: 3rd person singular (sé/sí)
///   3: 1st person plural synthetic form where it exists (muid / -mid)
///   4: 2nd person plural (sibh)
///   5: 3rd person plural (siad)

enum IrishTense {
  present,
  past,
  future,
  conditional,
  imperative,
  verbalNoun,
  verbalAdjective,
}

/// Container for an irregular verb.
class IrregularVerb {
  final String lemma; // Dictionary (citation) form (usually root / imperative)
  final String english; // Core English meaning
  final Map<IrishTense, List<String>>
  forms; // 6 person forms or single-item list for VN/Adj
  final List<String> altLemmas; // Alternate dictionary headwords (optional)

  const IrregularVerb({
    required this.lemma,
    required this.english,
    required this.forms,
    this.altLemmas = const [],
  });

  List<String> personForms(IrishTense tense) => forms[tense] ?? const [];
}

/// Helper to build the 6-person list.
List<String> six(String a, String b, String c, String d, String e, String f) =>
    [a, b, c, d, e, f];

/// Core irregular verbs (11 standard irregulars + 'bí').
/// Source: Standard school paradigms (compiled manually). Some plural synthetic
/// or imperative variants are simplified; feel free to refine.
final List<IrregularVerb> irregularVerbs = [
  IrregularVerb(
    lemma: 'bí',
    english: 'to be',
    altLemmas: ['tá', 'bhí', 'beidh', 'bheadh'],
    forms: {
      IrishTense.present: six(
        'táim / tá mé',
        'tá tú',
        'tá sé/sí',
        'táimid',
        'tá sibh',
        'tá siad',
      ),
      IrishTense.past: six(
        'bhí mé',
        'bhí tú',
        'bhí sé/sí',
        'bhíomar',
        'bhí sibh',
        'bhí siad',
      ),
      IrishTense.future: six(
        'beidh mé',
        'beidh tú',
        'beidh sé/sí',
        'beimid',
        'beidh sibh',
        'beidh siad',
      ),
      IrishTense.conditional: six(
        'bheadh mé',
        'bheadh tú',
        'bheadh sé/sí',
        'bheimis',
        'bheadh sibh',
        'bheidhís',
      ),
      IrishTense.imperative: six(
        '-',
        'bí',
        'bí sé/sí',
        'bímis',
        'bígí',
        'bí siad',
      ),
      IrishTense.verbalNoun: ['bheith'],
      IrishTense.verbalAdjective: ['-'],
    },
  ),
  IrregularVerb(
    lemma: 'abair',
    english: 'to say',
    altLemmas: ['deir', 'dúirt', 'déarfaidh', 'déarfadh'],
    forms: {
      IrishTense.present: six(
        'deirim',
        'deir tú',
        'deir sé/sí',
        'deirimid',
        'deir sibh',
        'deir siad',
      ),
      IrishTense.past: six(
        'dúirt mé',
        'dúirt tú',
        'dúirt sé/sí',
        'dúramar',
        'dúirt sibh',
        'dúirt siad',
      ),
      IrishTense.future: six(
        'déarfaidh mé',
        'déarfaidh tú',
        'déarfaidh sé/sí',
        'déarfaimid',
        'déarfaidh sibh',
        'déarfaidh siad',
      ),
      IrishTense.conditional: six(
        'déarfainn',
        'déarfá',
        'déarfadh sé/sí',
        'déarfaimis',
        'déarfadh sibh',
        'déarfaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'abair',
        'abraíodh sé/sí',
        'abraímis',
        'abraigí',
        'abraídís',
      ),
      IrishTense.verbalNoun: ['rá'],
      IrishTense.verbalAdjective: ['ráite'],
    },
  ),
  IrregularVerb(
    lemma: 'beir',
    english: 'to catch / to grab',
    altLemmas: ['rug', 'béarfaidh', 'bhéarfaí'],
    forms: {
      IrishTense.present: six(
        'beirim',
        'beireann tú',
        'beireann sé/sí',
        'beirimid',
        'beireann sibh',
        'beireann siad',
      ),
      IrishTense.past: six(
        'rug mé',
        'rug tú',
        'rug sé/sí',
        'rugamar',
        'rug sibh',
        'rug siad',
      ),
      IrishTense.future: six(
        'béarfaidh mé',
        'béarfaidh tú',
        'béarfaidh sé/sí',
        'béarfaimid',
        'béarfaidh sibh',
        'béarfaidh siad',
      ),
      IrishTense.conditional: six(
        'bhéarainn',
        'bhéarfa',
        'bhéarfadh sé/sí',
        'bhéarfaimis',
        'bhéarfadh sibh',
        'bhéarfaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'beir',
        'béire sé/sí',
        'béirimis',
        'béirigí',
        'béire siad',
      ),
      IrishTense.verbalNoun: ['breith'],
      IrishTense.verbalAdjective: ['beirthe / rugtha'],
    },
  ),
  IrregularVerb(
    lemma: 'clois',
    english: 'to hear',
    altLemmas: ['cloiseann', 'chuala', 'cloisfidh'],
    forms: {
      IrishTense.present: six(
        'cloisim',
        'cloiseann tú',
        'cloiseann sé/sí',
        'cloisimid',
        'cloiseann sibh',
        'cloiseann siad',
      ),
      IrishTense.past: six(
        'chuala mé',
        'chuala tú',
        'chuala sé/sí',
        'chualamar',
        'chuala sibh',
        'chuala siad',
      ),
      IrishTense.future: six(
        'cloisfidh mé',
        'cloisfidh tú',
        'cloisfidh sé/sí',
        'cloisfimid',
        'cloisfidh sibh',
        'cloisfidh siad',
      ),
      IrishTense.conditional: six(
        'chloisfinn',
        'chloisfeá',
        'chloisfeadh sé/sí',
        'chloisfimis',
        'chloisfeadh sibh',
        'chloisfidís',
      ),
      IrishTense.imperative: six(
        '-',
        'clois',
        'cloisheadh sé/sí',
        'cloisimis',
        'cloisigí',
        'cloisidís',
      ),
      IrishTense.verbalNoun: ['cloisteáil'],
      IrishTense.verbalAdjective: ['cloiste'],
    },
  ),
  IrregularVerb(
    lemma: 'déan',
    english: 'to do / make',
    altLemmas: ['déanann', 'rinne', 'déanfaimid'],
    forms: {
      IrishTense.present: six(
        'déanaim',
        'déanann tú',
        'déanann sé/sí',
        'déanaimid',
        'déanann sibh',
        'déanann siad',
      ),
      IrishTense.past: six(
        'rinne mé',
        'rinne tú',
        'rinne sé/sí',
        'rinneamar',
        'rinne sibh',
        'rinne siad',
      ),
      IrishTense.future: six(
        'déanfaimid',
        'déanfaidh tú',
        'déanfaidh sé/sí',
        'déanfaimid',
        'déanfaidh sibh',
        'déanfaidh siad',
      ),
      IrishTense.conditional: six(
        'dhéanfainn',
        'dhéanfá',
        'dhéanfadh sé/sí',
        'dhéanfaimis',
        'dhéanfadh sibh',
        'dhéanfadh siad',
      ),
      IrishTense.imperative: six(
        '-',
        'déan',
        'déana sé/sí',
        'déanaimis',
        'déanaigí',
        'déanaidís',
      ),
      IrishTense.verbalNoun: ['déanamh'],
      IrishTense.verbalAdjective: ['déanta'],
    },
  ),
  IrregularVerb(
    lemma: 'faigh',
    english: 'to get / find',
    altLemmas: ['faigheann', 'fuair', 'gheobhaidh'],
    forms: {
      IrishTense.present: six(
        'faighim',
        'faigheann tú',
        'faigheann sé/sí',
        'faighimid',
        'faigheann sibh',
        'faigheann siad',
      ),
      IrishTense.past: six(
        'fuair mé',
        'fuair tú',
        'fuair sé/sí',
        'fuaireamar',
        'fuair sibh',
        'fuair siad',
      ),
      IrishTense.future: six(
        'gheobhaidh mé',
        'gheobhaidh tú',
        'gheobhaidh sé/sí',
        'gheobhaimid',
        'gheobhaidh sibh',
        'gheobhaidh siad',
      ),
      IrishTense.conditional: six(
        'gheobhainn',
        'gheofá',
        'gheobhadh sé/sí',
        'gheobhaimis',
        'gheobhadh sibh',
        'gheobhaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'faigh',
        'fágha sé/sí',
        'fághaimis',
        'faighigí',
        'fágaidís',
      ),
      IrishTense.verbalNoun: ['fáil'],
      IrishTense.verbalAdjective: ['faighte'],
    },
  ),
  IrregularVerb(
    lemma: 'feic',
    english: 'to see',
    altLemmas: ['feiceann', 'chonaic', 'feicfidh'],
    forms: {
      IrishTense.present: six(
        'feicim',
        'feiceann tú',
        'feiceann sé/sí',
        'feicimid',
        'feiceann sibh',
        'feiceann siad',
      ),
      IrishTense.past: six(
        'chonaic mé',
        'chonaic tú',
        'chonaic sé/sí',
        'chonamar',
        'chonaic sibh',
        'chonaic siad',
      ),
      IrishTense.future: six(
        'feicfidh mé',
        'feicfidh tú',
        'feicfidh sé/sí',
        'feicfimid',
        'feicfidh sibh',
        'feicfidh siad',
      ),
      IrishTense.conditional: six(
        "d'fheicfinn",
        "d'fheicfeá",
        "d'fheicfeadh sé/sí",
        "d'fheicfimis",
        "d'fheicfeadh sibh",
        "d'fheicfidís",
      ),
      IrishTense.imperative: six(
        '-',
        'feic',
        'feiceadh sé/sí',
        'feicimis',
        'feicigí',
        'feicidís',
      ),
      IrishTense.verbalNoun: ['feiceáil'],
      IrishTense.verbalAdjective: ['feicthe'],
    },
  ),
  IrregularVerb(
    lemma: 'ith',
    english: 'to eat',
    altLemmas: ['itheann', "d'ith", 'íosfaidh'],
    forms: {
      IrishTense.present: six(
        'ithim',
        'itheann tú',
        'itheann sé/sí',
        'ithimid',
        'itheann sibh',
        'itheann siad',
      ),
      IrishTense.past: six(
        "d'ith mé",
        "d'ith tú",
        "d'ith sé/sí",
        "d'itheamar",
        "d'ith sibh",
        "d'ith siad",
      ),
      IrishTense.future: six(
        'íosfaidh mé',
        'íosfaidh tú',
        'íosfaidh sé/sí',
        'íosfaimid',
        'íosfaidh sibh',
        'íosfaidh siad',
      ),
      IrishTense.conditional: six(
        "d'íosfainn",
        "d'íosfá",
        "d'íosfadh sé/sí",
        "d'íosfaimis",
        "d'íosfadh sibh",
        "d'íosfaidís",
      ),
      IrishTense.imperative: six(
        '-',
        'ith',
        'itheadh sé/sí',
        'ithimis',
        'ithigí',
        'ithidís',
      ),
      IrishTense.verbalNoun: ['ithe'],
      IrishTense.verbalAdjective: ['ite'],
    },
  ),
  IrregularVerb(
    lemma: 'tabhair',
    english: 'to give',
    altLemmas: ['tugann', 'thug', 'tabharfaidh'],
    forms: {
      IrishTense.present: six(
        'tugaim',
        'tugann tú',
        'tugann sé/sí',
        'tugaimid',
        'tugann sibh',
        'tugann siad',
      ),
      IrishTense.past: six(
        'thug mé',
        'thug tú',
        'thug sé/sí',
        'thugamar',
        'thug sibh',
        'thug siad',
      ),
      IrishTense.future: six(
        'tabharfaidh mé',
        'tabharfaidh tú',
        'tabharfaidh sé/sí',
        'tabharfaimid',
        'tabharfaidh sibh',
        'tabharfaidh siad',
      ),
      IrishTense.conditional: six(
        'thabharfainn',
        'thabharfá',
        'thabharfadh sé/sí',
        'thabharfaimis',
        'thabharfadh sibh',
        'thabharfaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'tabhair',
        'tabhra sé/sí',
        'tabhraimis',
        'tabhraigí',
        'tabhraidís',
      ),
      IrishTense.verbalNoun: ['tabhairt'],
      IrishTense.verbalAdjective: ['tugtha'],
    },
  ),
  IrregularVerb(
    lemma: 'tar',
    english: 'to come',
    altLemmas: ['tagann', 'tháinig', 'tiocfaidh'],
    forms: {
      IrishTense.present: six(
        'tagaim',
        'tagann tú',
        'tagann sé/sí',
        'tagaimid',
        'tagann sibh',
        'tagann siad',
      ),
      IrishTense.past: six(
        'tháinig mé',
        'tháinig tú',
        'tháinig sé/sí',
        'thángamar',
        'tháinig sibh',
        'tháinig siad',
      ),
      IrishTense.future: six(
        'tiocfaidh mé',
        'tiocfaidh tú',
        'tiocfaidh sé/sí',
        'tiocfaimid',
        'tiocfaidh sibh',
        'tiocfaidh siad',
      ),
      IrishTense.conditional: six(
        'thiocfainn',
        'thiocfá',
        'thiocfadh sé/sí',
        'thiocfaimis',
        'thiocfadh sibh',
        'thiocfaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'tar',
        'taga sé/sí',
        'tagaímis',
        'tagaigí',
        'tagaidís',
      ),
      IrishTense.verbalNoun: ['teacht'],
      IrishTense.verbalAdjective: ['tagtha'],
    },
  ),
  IrregularVerb(
    lemma: 'téigh',
    english: 'to go',
    altLemmas: ['téann', 'chuaigh', 'rachaidh'],
    forms: {
      IrishTense.present: six(
        'téim',
        'téann tú',
        'téann sé/sí',
        'téimid',
        'téann sibh',
        'téann siad',
      ),
      IrishTense.past: six(
        'chuaigh mé',
        'chuaigh tú',
        'chuaigh sé/sí',
        'chuamar',
        'chuaigh sibh',
        'chuaigh siad',
      ),
      IrishTense.future: six(
        'rachaidh mé',
        'rachaidh tú',
        'rachaidh sé/sí',
        'rachaimid',
        'rachaidh sibh',
        'rachaidh siad',
      ),
      IrishTense.conditional: six(
        'rachainn',
        'rachfá',
        'rachfadh sé/sí',
        'rachfaimis',
        'rachfadh sibh',
        'rachfaidís',
      ),
      IrishTense.imperative: six(
        '-',
        'téigh',
        'téadha sé/sí',
        'téadhaimis',
        'téighigí',
        'téadhaidís',
      ),
      IrishTense.verbalNoun: ['dul / teitheadh'],
      IrishTense.verbalAdjective: ['dulta'],
    },
  ),
];

/// Quick lookup by lemma or alt lemma (case-insensitive).
IrregularVerb? findIrregularVerb(String query) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return null;
  for (final v in irregularVerbs) {
    if (v.lemma.toLowerCase() == q) return v;
    if (v.altLemmas.any((a) => a.toLowerCase() == q)) return v;
  }
  return null;
}

/// List of the canonical headwords (lemmas) for convenient menus.
List<String> get irregularVerbHeadwords =>
    irregularVerbs.map((v) => v.lemma).toList(growable: false);
