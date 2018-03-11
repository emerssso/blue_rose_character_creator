import 'dart:async';
import 'package:angular_components/model/selection/selection_model.dart';
import 'package:angular_components/model/selection/string_selection_options.dart';
import 'package:angular_components/model/ui/has_renderer.dart';

class DropDownDelegate<T> {
  final StringSelectionOptions<T> options;
  final ItemRenderer<T> renderer;
  final SelectionModel<T> selection;

  DropDownDelegate(List<T> optionList, String toString(T), T initialSelection)
      : options = new StringSelectionOptions<T>(optionList),
        renderer = new CachingItemRenderer<T>(toString),
        selection =
        new SelectionModel<T>.withList(selectedValues: [initialSelection]) {
  }

  StreamSubscription<List<SelectionChangeRecord<T>>> listen(void onData(T)) =>
      selection.selectionChanges
          .listen((selected) => onData(selected[0].added.first));
}