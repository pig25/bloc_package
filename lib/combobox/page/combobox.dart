import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../scrollbehavior/customscrollbehavior.dart';
import '../cubit/combobox_cubit.dart';
import '../model/combobox.dart';

class ComBoBox<T> extends StatelessWidget {
  const ComBoBox({
    super.key,
    required this.comBoBoxItemEntry,
    this.selectItem,
    this.onSelectItemChange,
    this.style,
  });

  final List<ComBoBoxItemEntry<T>> comBoBoxItemEntry;
  final T? selectItem;
  final Function(T?)? onSelectItemChange;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ComBoBoxCubit<T>(comBoBoxItemEntry),
      child: ComBoBoxWidget(
        selectItem: selectItem,
        onSelectItemChange: onSelectItemChange,
      ),
    );
  }
}

class ComBoBoxWidget<T> extends StatelessWidget {
  ComBoBoxWidget({
    super.key,
    this.onSelectItemChange,
    this.style,
    this.selectItem,
  });

  final T? selectItem;
  final GlobalKey rowKey = GlobalKey();

  final Function(T?)? onSelectItemChange;
  final LayerLink _link = LayerLink();
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();
  final TextEditingController _textEditingController = TextEditingController();
  final TextStyle? style;

  onSelectItem(T value) {
    if (onSelectItemChange != null) {
      onSelectItemChange!(value);
    }
    _overlayPortalController.hide();
  }

  final String groupId = 'GroupID_${DateTime.now().millisecondsSinceEpoch}';

  @override
  Widget build(BuildContext context) {
    final cstyle = style ?? Theme.of(context).textTheme.titleLarge;

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (BuildContext context) {
          return BlocBuilder<ComBoBoxCubit<T>, List<ComBoBoxItemEntry<T>>>(
            builder: (BuildContext context, state) {
              double? width;
              double? height = 300;
              final keyContext = rowKey.currentContext;
              if (keyContext != null && keyContext.mounted) {
                final box = keyContext.findRenderObject() as RenderBox;
                width = box.size.width;
                final pos = box.localToGlobal(Offset.zero);
                height = MediaQuery.of(context).size.height -
                    (box.size.height + pos.dy);
                var totalHeight = state.length *
                        (MediaQuery.textScalerOf(context)
                                .scale(cstyle!.fontSize! + 10 + 12) +
                            16) -
                    (state.length > 1 ? 12 : 0);

                if (totalHeight < height) {
                  height = totalHeight;
                }
              }

              return FittedBox(
                child: CompositedTransformFollower(
                  link: _link,
                  targetAnchor: Alignment.bottomLeft,
                  followerAnchor: Alignment.topLeft,
                  child: Material(
                    child: TapRegion(
                      groupId: groupId,
                      onTapOutside: (PointerDownEvent event) {
                        _overlayPortalController.hide();
                      },
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          padding: const EdgeInsets.all(1),
                          child: ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {
                                      onSelectItem(state[index].value);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: state[index].child ??
                                            Text(
                                              state[index].label,
                                              style: cstyle,
                                            ),
                                      ),
                                    ));
                              },
                              itemCount: state.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Builder(builder: (context) {
          var find = context
              .read<ComBoBoxCubit<T>>()
              .state
              .where((x) => x.value == selectItem)
              .firstOrNull;

          _textEditingController.text = find?.label ?? '';
          return InkWell(
            onTap: () {
              if (!_overlayPortalController.isShowing) {
                context.read<ComBoBoxCubit<T>>().filter('');
              }
              _overlayPortalController.toggle();
            },
            child: TapRegion(
              groupId: groupId,
              child: IntrinsicHeight(
                child: Row(
                  key: rowKey,
                  children: [
                    Expanded(
                      child: find?.child == null ?
                          TextField(
                            style: cstyle,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8),
                            ),
                            controller: _textEditingController,
                            onChanged: (String value) {
                              context.read<ComBoBoxCubit<T>>().filter(value);
                            },
                            onSubmitted: (String value) {
                              var find = context
                                  .read<ComBoBoxCubit<T>>()
                                  .state
                                  .where((x) => x.label == value)
                                  .firstOrNull;
                              if (find != null) {
                                onSelectItem(find.value);
                              } else {
                                _overlayPortalController.hide();
                                context.read<ComBoBoxCubit<T>>().filter('');
                              }
                            },
                            onTap: () {
                              if (!_overlayPortalController.isShowing) {
                                context.read<ComBoBoxCubit<T>>().filter('');
                                _overlayPortalController.show();
                              }
                            },
                          ):SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(padding: EdgeInsets.all(8),
                        child: find?.child),
                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      child: Icon(_overlayPortalController.isShowing
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
