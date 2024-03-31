import 'package:flutter/material.dart';

typedef BlocBuilder<T> = T Function();
typedef BlocDisposer<T> = Function(T);

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    super.key,
    required this.child,
    required this.blocBuilder,
    this.blocDispose,
  });

  final Widget child;
  final BlocBuilder<T> blocBuilder;
  final BlocDisposer<T>? blocDispose;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static B of<B extends BlocBase>(BuildContext context) {
    final _BlocProviderInherited<B>? result = context.dependOnInheritedWidgetOfExactType<_BlocProviderInherited<B>>();
    assert(result != null, 'No FrogColor found in context');
    return result!.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{

  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder();
  }

  @override
  void dispose(){
    if (widget.blocDispose != null){
      widget.blocDispose!(bloc);
    } else {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  const _BlocProviderInherited({
    super.key,
    required super.child,
    required this.bloc,
  });

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}