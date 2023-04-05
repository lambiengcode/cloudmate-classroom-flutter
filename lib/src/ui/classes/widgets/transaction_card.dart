import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/transaction_model.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/string.dart';

class TransactionCard extends StatefulWidget {
  final TransactionModel transactionModel;
  const TransactionCard({
    required this.transactionModel,
  });
  @override
  State<StatefulWidget> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.sp,
      margin: EdgeInsets.only(left: 10.5.sp, right: 10.5.sp, bottom: 10.sp),
      decoration: AppDecoration.buttonActionBorder(context, 16.sp).decoration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.sp, right: 6.sp),
              child: Row(
                children: [
                  Container(
                    height: 46.sp,
                    width: 46.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000.sp),
                      child: BlurHash(
                        hash: widget.transactionModel.classModel.blurHash,
                        image: widget.transactionModel.classModel.image,
                        imageFit: BoxFit.cover,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.transactionModel.classModel.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontFamily.lato,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        _buildTileInfo(
                          widget.transactionModel.amount.isEmpty
                              ? '0đ'
                              : (widget.transactionModel.amount.formatMoney() + 'đ'),
                          PhosphorIcons.money,
                          Colors.amberAccent.shade700,
                        ),
                        SizedBox(height: 4.sp),
                        _buildTileInfo(
                          'Gửi: ${widget.transactionModel.sender.displayName}',
                          PhosphorIcons.userCircleMinusBold,
                          Colors.redAccent.shade100,
                        ),
                        SizedBox(height: 4.sp),
                        _buildTileInfo(
                          'Nhận: ${widget.transactionModel.receiver.displayName}',
                          PhosphorIcons.userCirclePlusBold,
                          Colors.blueAccent.shade200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 38.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(16.sp),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF22BFC3),
                  colorPrimary,
                  Colors.blueAccent.shade200,
                  Colors.blueAccent.shade400,
                ],
                stops: [
                  .05,
                  .5,
                  .9,
                  1.0,
                ],
                tileMode: TileMode.repeated,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppBloc.authBloc.userModel?.id == widget.transactionModel.sender.id
                        ? 'Thanh toán'
                        : 'Nhận tiền',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontFamily.lato,
                      fontWeight: FontWeight.w600,
                      color: mC,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTileInfo(title, icon, color) {
    return Container(
      width: 120.sp,
      padding: EdgeInsets.only(right: 4.sp),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12.5.sp,
            color: color,
          ),
          SizedBox(width: 6.sp),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: FontFamily.lato,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
