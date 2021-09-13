import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';

class ImageBodyPost extends StatefulWidget {
  final List<String>? images;
  final List<String>? blurHashs;
  ImageBodyPost({this.images, this.blurHashs});
  @override
  State<StatefulWidget> createState() => _ImageBodyPostCard();
}

class _ImageBodyPostCard extends State<ImageBodyPost> {
  @override
  Widget build(BuildContext context) {
    return widget.images!.length == 1
        ? _buildSingleImage(context)
        : widget.images!.length == 2
            ? _buildDoubleImage(context)
            : widget.images!.length == 3
                ? _buildTripleImage(context)
                : _buildMultipleImage(context);
  }

  Widget _buildSingleImage(context) {
    final _size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: _size.height * .42,
          child: BlurHash(
            hash: widget.blurHashs![0],
            image: widget.images![0],
            imageFit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
            child: Container(
              height: _size.height * .42,
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: _size.height * .42,
            maxWidth: _size.width,
          ),
          alignment: Alignment.topCenter,
          child: BlurHash(
            hash: widget.blurHashs![0],
            image: widget.images![0],
            imageFit: BoxFit.fitHeight,
            color: colorPrimary,
            needStream: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDoubleImage(context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: _size.height * .38,
            child: BlurHash(
              hash: widget.blurHashs![0],
              image: widget.images![0],
              imageFit: BoxFit.cover,
              color: colorPrimary,
            ),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Container(
            height: _size.height * .38,
            child: BlurHash(
              hash: widget.blurHashs![1],
              image: widget.images![1],
              imageFit: BoxFit.cover,
              color: colorPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTripleImage(context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: _size.height * .38,
            child: BlurHash(
              hash: widget.blurHashs![0],
              image: widget.images![0],
              imageFit: BoxFit.cover,
              color: colorPrimary,
            ),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Container(
            height: _size.height * .38,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: BlurHash(
                      hash: widget.blurHashs![1],
                      image: widget.images![1],
                      imageFit: BoxFit.cover,
                      color: colorPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Expanded(
                  child: Container(
                    child: BlurHash(
                      hash: widget.blurHashs![2],
                      image: widget.images![2],
                      imageFit: BoxFit.cover,
                      color: colorPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleImage(context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => print('image 01'),
            child: Container(
              height: _size.height * .38,
              child: BlurHash(
                hash: widget.blurHashs![0],
                image: widget.images![0],
                imageFit: BoxFit.cover,
                color: colorPrimary,
              ),
            ),
          ),
        ),
        SizedBox(width: 2.0),
        Expanded(
          child: Container(
            height: _size.height * .38,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: BlurHash(
                      hash: widget.blurHashs![1],
                      image: widget.images![1],
                      imageFit: BoxFit.cover,
                      color: colorPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 2.0),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        child: BlurHash(
                          hash: widget.blurHashs![2],
                          image: widget.images![2],
                          imageFit: BoxFit.cover,
                          color: colorPrimary,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.images!.length - 3}+',
                          style: TextStyle(
                            color: mCL,
                            fontWeight: FontWeight.w400,
                            fontSize: _size.width / 16.0,
                            fontFamily: FontFamily.lato,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
