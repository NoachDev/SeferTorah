import 'package:flutter/material.dart';

class ListBooks extends StatefulWidget {
  final Map books;
  const ListBooks({super.key, required this.books});

  @override
  State<ListBooks> createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: 7,
            
            child: ListView.builder(
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.onSurface.withAlpha(200),
                  ),
                  margin: const EdgeInsets.only(bottom: 22.0),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.books.length,
            controller: _controller,
            padding: EdgeInsets.zero,

            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                widget.books.keys.elementAt(index),
                
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontFamily: Theme.of(context).textTheme.bodySmall!.fontFamily,
                  fontSize: 16,
                  inherit: false,
                ),
              )
              );
            },
          ),
        ),

      ],
    );
  }
}
