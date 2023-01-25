import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/icon_svg_primary_button.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_no_border.dart';
import 'package:pad_lampung/presentation/pages/booking/ticket/scan_online_booking_ticket_page.dart';
import 'package:pad_lampung/presentation/utils/extension/list_ticket_ext.dart';

import '../../../../../core/data/model/response/ticket_list_response.dart';
import '../../../../components/button/icon_primary_button.dart';
import '../../../../components/button/primary_button.dart';
import '../../../../components/modal/bottom_modal.dart';

const String prevPage = "prevPage";
const String firstPage = "firstPage";
const String nextPage = "nextPage";
const String lastPage = "lastPage";

class ListBookingOnlineHolderWidget extends StatefulWidget {
  final List<Ticket> tickets;
  const ListBookingOnlineHolderWidget({Key? key, required this.tickets}) : super(key: key);

  @override
  State<ListBookingOnlineHolderWidget> createState() =>
      _ListHolderWidgetState();
}

class _ListHolderWidgetState extends State<ListBookingOnlineHolderWidget>
    with TickerProviderStateMixin {
  String selectedItem = initialDataShown;

  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Data Ticketing',
                          style: AppTheme.smallTitle.copyWith(
                              fontWeight: FontWeight.w700
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: IconSvgPrimaryButton(
                          context: context,
                          isEnabled: true,
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        ScanOnlineBookingTicketPage( isNeedToShowDetail: false,)));
                          },
                          height: 43,
                          text: 'Pindai Tiket',
                          iconAsset: 'assets/icons/barcode_icon.svg',
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text('Show'),
                    GenericDropdown(
                      selectedItem: selectedItem,
                      items: dataShownItem,
                      height: 40,
                      onChanged: (String? value) {
                        setState(() {
                          selectedItem = value ?? initialDataShown;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GenericTextInputNoBorder(
                          fillColor: AppTheme.inputFieldColor,
                          suffixIcon: const Icon(Icons.search),
                          horizontalMargin: 0,
                          hintText: 'Cari',
                          controller: searchController,
                          inputType: TextInputType.text),
                    )
                  ],
                ),
              ),

              widget.tickets.isEmpty ?
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('Data kosong')),
              )
                  :

              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: widget.tickets.toDataRowOnline(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
