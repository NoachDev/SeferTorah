enum Origin { native, aramaic, modern }

enum Stage { biblical, mishnaic, medieval, modern }

enum GrammaticalState { absolute, construct, suffixState }

/// --------------------------------------------------------------------------------------------

enum Binyan { qal, nifal, piel, pual, hifil, hufal, hitpael }

enum Number { plural, singular, dual }

enum Gender {
  masculine(br: "Macullino"),
  feminine(br: "Feminino"),
  neutral(br: "Neutro");

  const Gender({this.br = ""});

  final String br;

}

enum VerbTense { past, present, future }

enum VerbForm { perfect, imperfect, participle, infinitive, imperative }

enum Person { first, second, third }

enum MishkalType { verbal, nominal }


/// --------------------------------------------------------------------------------------------

enum NumeralType {
  ordinal(br : "Ordinal"),
  cardinal(br : "Cardinal");


  const NumeralType({this.br});
  final String? br;
}

enum MorphologicalCategories {
  noun(br: "Substantivo"),
  verb(br: "Verbo"),
  modifier(br: "Modificador"),
  pronoun(br: "Pronome"),
  particle(br: "Particula Gramatical"),
  adjective(br: "Adjetivo"),
  adverb(br: "Advérbio"),
  conjunction(br: "Conjução"),
  preposition(br: "Preposição"),
  interjection(br: "Interjeição"),
  numeral(br: "Numeral"),
  article(br: "Artigo"),
  undefined(br: "Um erro");

  const MorphologicalCategories({this.br});

  final String? br;
  
}

class MorphologicalCategory {
  final MorphologicalCategories category;
  final Set<dynamic>? decorations;

  MorphologicalCategory({required this.category, this.decorations});

  factory MorphologicalCategory.empty(){
    throw MorphologicalCategory(category: MorphologicalCategories.undefined);
  }

  @Deprecated("Use namedCategory instead")
  @override
  String toString(){
    return "${category.name} - ${decorations?.map((elm) => elm.toString())}";
  }

  String namedCategory({String? language}) {
    switch (language) {
      default:
        var add = "";

        if (decorations != null){

          for (final elm in decorations!.map((elm) => elm.br)){
            add += " $elm";
          }
        }
        
        return category.br! + add;
    }
  }
}

/// --------------------------------------------------------------------------------------------

enum SyntacticRole { predicate, subject, object, modifier, complement }

enum SemanticType { event, entity, property }

/// --------------------------------------------------------------------------------------------
