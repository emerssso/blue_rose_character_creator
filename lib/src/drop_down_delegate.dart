import 'dart:async';

import 'package:angular_components/model/selection/selection_model.dart';
import 'package:angular_components/model/selection/string_selection_options.dart';
import 'package:angular_components/model/ui/has_renderer.dart';

class DropDownDelegate<T> {
  final StringSelectionOptions<T> options;
  final ItemRenderer<T> renderer;
  final SelectionModel<T> selection;

  DropDownDelegate(List<T> optionList, String Function(T) toString,
      T initialSelection)
      : options = StringSelectionOptions<T>(optionList),
        renderer = newCachingItemRenderer<T>(toString),
        selection = SelectionModel.single(selected: initialSelection);

  StreamSubscription<List<SelectionChangeRecord<T>>> listen(void onData(T)) =>
      selection.selectionChanges
          .listen((selected) => onData(selected[0].added.first));
}
