import 'package:flutter/material.dart' hide Focus;

import 'character/ability.dart';
import 'character/arcana.dart';
import 'character/background.dart';
import 'character/character.dart';
import 'character/character_class.dart';
import 'character/focus.dart';
import 'character/race.dart';
import 'character/rhydan.dart';
import 'character/weapons_group.dart';

class CharacterOptionSelector extends StatefulWidget {
  @override
  _CharacterOptionSelectorState createState() =>
      _CharacterOptionSelectorState();
}

class _CharacterOptionSelectorState extends State<CharacterOptionSelector> {
  Race race = Race.human;
  Rhy rhydanType = Rhy.ape;
  CharacterClass characterClass = CharacterClass.warrior;
  Background background = Background.aldin;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          alignment: AlignmentDirectional.topStart,
          margin: const EdgeInsetsDirectional.only(top: 8, start: 40),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              if (race != Race.rhydan)
                DropdownButton<Background>(
                  value: background,
                  onChanged: (b) => setState(() => background = b),
                  items: Background.values
                      .map((b) => DropdownMenuItem(
                            value: b,
                            child: Text(backgroundToString(b)),
                          ))
                      .toList(),
                ),
              DropdownButton<Race>(
                value: race,
                onChanged: (r) => setState(() => race = r),
                items: Race.values
                    .where((r) => r != Race.unknown)
                    .map((race) => DropdownMenuItem(
                          value: race,
                          child: Text(raceToString(race)),
                        ))
                    .toList(),
              ),
              if (race == Race.rhydan)
                DropdownButton<Rhy>(
                  value: rhydanType,
                  onChanged: (r) => setState(() => rhydanType = r),
                  items: Rhy.values
                      .map((rhy) => DropdownMenuItem(
                            value: rhy,
                            child: Text(rhyToString(rhy)),
                          ))
                      .toList(),
                ),
              DropdownButton<CharacterClass>(
                value: characterClass,
                onChanged: (c) => setState(() => characterClass = c),
                items: CharacterClass.values
                    .where((cc) => cc != CharacterClass.unknown)
                    .map((cc) => DropdownMenuItem(
                          value: cc,
                          child: Text(characterClassToString(cc)),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        if (race != null &&
            race != Race.unknown &&
            characterClass != null &&
            characterClass != CharacterClass.unknown)
          CharacterRenderer(Character(
            race,
            characterClass,
            background: race != Race.rhydan ? background : null,
            rhydanType: race == Race.rhydan ? rhydanType : null,
          )),
      ],
    );
  }
}

class CharacterRenderer extends StatelessWidget {
  final Character character;

  CharacterRenderer(this.character);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 680),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Wrap(
          children: [
            StatCard(character: character),
            AbilitiesCard(character: character),
            if (character.languages.isNotEmpty)
              ListCard(
                title: 'Languages',
                items: character.languages.map(languageToString).toList(),
              ),
            if (character.weapons.isNotEmpty)
              ListCard(
                title: 'Weapons',
                items: character.weapons.map((w) => w.toString()).toList(),
              ),
            if (character.weaponsGroups.isNotEmpty)
              ListCard(
                title: 'Weapon Groups',
                items: character.weaponsGroups.map(weaponsGroupToString).toList(),
              ),
            if (character.talents.isNotEmpty)
              ListCard(
                title: 'Talents',
                items: character.talents.map((t) => t.toString()).toList(),
              ),
            if (character.arcana.isNotEmpty)
              ListCard(
                title: 'Arcana',
                items: character.arcana.map(arcanaToString).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final Character character;

  const StatCard({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        children: [
          rowFor('Health', '${character.health}', context),
          rowFor('Speed', '${character.speed}', context),
          rowFor('Defense', '${character.defense}', context),
          rowFor('Speed', '${character.speed}', context),
          rowFor('Calling', '${character.calling}', context),
          rowFor('Destiny', '${character.destiny}', context),
          rowFor('Fate', '${character.fate}', context),
          const TableRow(children: [SizedBox(), SizedBox(height: 8)]),
        ],
      ),
    );
  }

  TableRow rowFor(String title, String value, BuildContext context) =>
      TableRow(children: [
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 4, start: 8),
            child: Text(title, style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 4, start: 8, end: 8),
          child: Text(value),
        )
      ]);
}

class AbilitiesCard extends StatelessWidget {
  final Map<Ability, int> abilities;
  final Map<Ability, List<Focus>> focuses;

  AbilitiesCard({Character character})
      : abilities = character?.abilities,
        focuses = character?.focuses;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8, bottom: 4),
                child: Text(
                  'Abilities',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(),
            ]),
            ...Ability.values.expand(
              (ability) => [
                TableRow(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 4, start: 8),
                      child: Text(
                        abilityToString(ability),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 8, start: 8, end: 8),
                      child: Text('${abilities[ability]}'),
                    ),
                  ],
                ),
                if (focuses[ability]?.isNotEmpty ?? false) ...[
                  for (var focus in focuses[ability])
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 12),
                          child: Text(
                            '${focus.domain}(+${focus.bonus})',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                  const TableRow(children: [SizedBox(), SizedBox(height: 4)]),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final List<String> items;
  final String title;

  ListCard({this.items, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 8, bottom: 4, end: 8, top: 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ...items
              .map((i) => Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 8, bottom: 4, end: 8),
                    child: Text(i),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
