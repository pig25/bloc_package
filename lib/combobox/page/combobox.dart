import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/combobox_cubit.dart';
import '../model/combobox.dart';

class ComBoBox<T> extends StatelessWidget {
  const ComBoBox({
    super.key,
    required this.comBoBoxItemEntry,
    this.selectItem,
    this.onSelectItemChange,
  });

  final List<ComBoBoxItemEntry<T>> comBoBoxItemEntry;
  final T? selectItem;
  final Function(T?)? onSelectItemChange;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ComBoBoxCubit<T>(comBoBoxItemEntry),
      child: ComBoBoxWidget(
          selectText: '',  onSelectItemChange: onSelectItemChange),
    );
  }
}

class ComBoBoxWidget<T> extends StatelessWidget {
  ComBoBoxWidget(
      {super.key, this.onSelectItemChange, required this.selectText});

  final String selectText;
  final Function(T?)? onSelectItemChange;
  final LayerLink _link = LayerLink();
  final OverlayPortalController _overlayPortalController =
  OverlayPortalController();
  final TextEditingController _textEditingController = TextEditingController();

  onSelectItem(T value) {
    if (onSelectItemChange != null) {
      onSelectItemChange!(value);
    }
    _overlayPortalController.hide();
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = selectText;

    return BlocBuilder<ComBoBoxCubit<T>, List<ComBoBoxItemEntry<T>>>(
        builder: (BuildContext context, state) {
          return CompositedTransformTarget(
            link: _link,
            child: OverlayPortal(
              controller: _overlayPortalController,
              overlayChildBuilder: (BuildContext context) {
                return CompositedTransformFollower(
                  link: _link,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  child: Material(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              onSelectItem(state[index].value);
                            },
                            child:
                            state[index].child ?? Text(state[index].label));
                      },
                      itemCount: state.length,
                    ),
                  ),
                );
              },
              child: InkWell(
                onTap: () {
                  _overlayPortalController.toggle();
                },
                child: Row(
                  children: [
                    const Expanded(child: TextField()),
                    Icon(_overlayPortalController.isShowing
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          );
        });
  }
}