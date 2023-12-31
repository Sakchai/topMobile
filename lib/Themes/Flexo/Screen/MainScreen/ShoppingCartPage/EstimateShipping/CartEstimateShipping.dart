/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:nopsuite/Screens/General/AppSettings/AppSettingsProvider.dart';
import 'package:nopsuite/Screens/General/LocalResourceProvider.dart';
import 'package:nopsuite/Screens/Home/CartEstimateShipping/CartEstimateShippingProvider.dart';
import 'package:nopsuite/Themes/Flexo/Screen/Shared/AppBar/AppBar.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Colors.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Values.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/ButtonWidget.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/Dropdown/FlexoDropdown.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/Loader.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/RequiredIconWidget.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/TextFormWidgets/TextFieldWidget.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopsuite/Utils/hide_keyboard.dart';
import 'package:provider/provider.dart';

class FlexoCartEstimateShippingPopup extends StatelessWidget {
  const FlexoCartEstimateShippingPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    context.watch<AppSettingsProvider>();
    var localResourceProvider = context.watch<LocalResourceProvider>();
    var cartEstimateShippingProvider = context.watch<CartEstimateShippingProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: FlexoAppBarWidget().appbarPopup(context: context,title: localResourceProvider.isLocalDataLoad ? "" : localResourceProvider.getResourseByKey("Estimate Shipping")),
        backgroundColor: FlexoColorConstants.BACKGROUND_COLOR,
        body: cartEstimateShippingProvider.isPageLoader ? Loaders.pageLoader() :  Column(
          children: [
            cartEstimateShippingProvider.isAPILoader ? Loaders.apiLoader() : Container(),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: FlexoValues.widthSpace2Px),

                      Container(
                        width: FlexoValues.controlsWidth,
                        child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.shipToTitle"),),
                      ),

                      SizedBox(height: FlexoValues.heightSpace1Px,),

                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlexoDropDown(
                                width: FlexoValues.controlsWidth,
                                selectedValue: cartEstimateShippingProvider.estimateShippingResponseModel.countryId.toString(),
                                items: cartEstimateShippingProvider.countryDropDownList,
                                heading: localResourceProvider.getResourseByKey("address.selectCountry"),
                                hintText: localResourceProvider.getResourseByKey("address.selectCountry"),
                                required: true,
                                onChange: (value)
                                {
                                  cartEstimateShippingProvider.countryDropdownChange(context: context, value: value);
                                }
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px,),

                            FlexoDropDown(
                                width: FlexoValues.controlsWidth,
                                selectedValue: cartEstimateShippingProvider.estimateShippingResponseModel.stateProvinceId.toString(),
                                items: cartEstimateShippingProvider.stateDropDownList,
                                heading: localResourceProvider.getResourseByKey("address.selectState"),
                                hintText: localResourceProvider.getResourseByKey("address.selectState"),
                                required: false,
                                onChange: (value)
                                {
                                  cartEstimateShippingProvider.stateDropdownChange(context: context, value: value);
                                }
                            ),

                            SizedBox(height: FlexoValues.heightSpace1Px,),

                            cartEstimateShippingProvider.estimateShippingResponseModel.useCity?
                            Container(
                              width: FlexoValues.controlsWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  TextFieldWidget(
                                    width: FlexoValues.deviceWidth * 0.78,
                                    showRequiredIcon: false,
                                    controller: cartEstimateShippingProvider.cityController,
                                    hintText: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.city"),
                                  ),

                                  Expanded(
                                    child: GestureDetector(
                                      onTap: ()async {
                                        KeyboardUtil.hideKeyboard(context);
                                        cartEstimateShippingProvider.onChangeEvent(context: context);
                                      },
                                      child: Container(
                                        width: FlexoValues.deviceWidth * 0.15,
                                        height: FlexoValues.controlsHeight,
                                        decoration: BoxDecoration(
                                          color: FlexoColorConstants.BUTTON_COLOR,
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: FlexoValues.fontSize22,
                                        ),
                                      ),
                                    ),
                                  ),

                                  RequiredIconWidget()
                                ],
                              ),
                            ) :
                            Container(
                              width: FlexoValues.controlsWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    width: FlexoValues.deviceWidth * 0.78,
                                    showRequiredIcon: false,
                                    controller: cartEstimateShippingProvider.zipPostalCodeController,
                                    hintText: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.zipPostalCode"),
                                  ),

                                  Expanded(
                                    child: GestureDetector(
                                      onTap: ()async {
                                        KeyboardUtil.hideKeyboard(context);
                                        cartEstimateShippingProvider.onChangeEvent(context: context);
                                      },
                                      child: Container(
                                        width: FlexoValues.deviceWidth * 0.15,
                                        height: FlexoValues.controlsHeight,
                                        decoration: BoxDecoration(
                                          color: FlexoColorConstants.BUTTON_COLOR,
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: FlexoValues.iconSize22,
                                        ),
                                      ),
                                    ),
                                  ),

                                  RequiredIconWidget()
                                ],
                              ),
                            ),

                            SizedBox(height: FlexoValues.heightSpace2Px,),

                            Container(
                                width: FlexoValues.deviceWidth,
                                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.chooseShippingTitle"),),
                            ),

                            SizedBox(height: FlexoValues.widthSpace3Px),

                            cartEstimateShippingProvider.isEstimateShippingOption ?
                            cartEstimateShippingProvider.estimateShippingResponseModel != null ?
                            Container(
                              child: Column(
                                children: [

                                  Scrollbar(
                                    isAlwaysShown: true,
                                    showTrackOnHover: true,
                                    controller: _scrollController,
                                    thickness: 4,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller: _scrollController,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                                    ),
                                                    left: BorderSide(
                                                        color: FlexoColorConstants.LIST_BORDER_COLOR
                                                    )
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    color: FlexoColorConstants.HEADING_BACKGROUND_COLOR,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                            decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  ),
                                                                  right: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  )
                                                              ),
                                                            ),
                                                            alignment: Alignment.centerLeft,
                                                            width: FlexoValues.deviceWidth * 0.5,
                                                            height: FlexoValues.deviceHeight * 0.06,
                                                            child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.shippingOption.name"),maxLines: 1),
                                                        ),

                                                        Container(
                                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                            decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  ),
                                                                  right: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  )
                                                              ),
                                                            ),
                                                            alignment: Alignment.centerLeft,
                                                            width: FlexoValues.deviceWidth * 0.5,
                                                            height: FlexoValues.deviceHeight * 0.06,
                                                            child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.shippingOption.estimatedDelivery"),maxLines: 1),
                                                        ),

                                                        Container(
                                                            padding: EdgeInsets.all(FlexoValues.widthSpace2Px),
                                                            decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  ),
                                                                  right: BorderSide(
                                                                      color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                  )
                                                              ),
                                                            ),
                                                            alignment: Alignment.centerLeft,
                                                            width: FlexoValues.deviceWidth * 0.35,
                                                            height: FlexoValues.deviceHeight * 0.06,
                                                            child: FlexoTextWidget().headingBoldText16(text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.shippingOption.price"),maxLines: 1),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: cartEstimateShippingProvider.productEstimateShippingModel.shippingOptions.map((e){
                                                        return Container(
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              cartEstimateShippingProvider.estimateItemUpdate(context: context, shippingOption: e);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  alignment: Alignment.centerLeft,
                                                                  decoration: BoxDecoration(
                                                                    border: Border(
                                                                        bottom: BorderSide(
                                                                            color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                        ),
                                                                        right: BorderSide(
                                                                            color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                        )
                                                                    ),
                                                                  ),
                                                                  width: FlexoValues.deviceWidth * 0.5,
                                                                  height: FlexoValues.deviceHeight * 0.06,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets.only(left: FlexoValues.widthSpace1Px),
                                                                        child: Container(
                                                                            child: Icon(
                                                                              e.selected ? Icons.radio_button_checked : Icons.radio_button_off_outlined,
                                                                              color: e.selected ? FlexoColorConstants.ACCENT_COLOR : Colors.grey.shade600,
                                                                              size: FlexoValues.fontSize20,
                                                                            )
                                                                        ),
                                                                      ),

                                                                      SizedBox(width: FlexoValues.widthSpace1Px),

                                                                      Container(
                                                                          width: FlexoValues.deviceWidth * 0.35,
                                                                          child: Text(
                                                                            e.name,
                                                                            maxLines: 2,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: FlexoValues.fontSize16,
                                                                                color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                                fontWeight: e.selected ? FontWeight.bold : FontWeight.normal
                                                                            ),
                                                                          )
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),

                                                                Container(
                                                                    alignment: Alignment.centerLeft,
                                                                    decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                          ),
                                                                          right: BorderSide(
                                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                          )
                                                                      ),
                                                                    ),
                                                                    width: FlexoValues.deviceWidth * 0.5,
                                                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                                    height: FlexoValues.deviceHeight * 0.06,
                                                                    child: Text(
                                                                      e.deliveryDateFormat == null ? "-" :'${e.deliveryDateFormat}',
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize: FlexoValues.fontSize16,
                                                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                          fontWeight: e.selected ? FontWeight.bold : FontWeight.normal
                                                                      ),
                                                                    )
                                                                ),

                                                                Container(
                                                                    alignment: Alignment.centerLeft,
                                                                    padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                                                    decoration: BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                          ),
                                                                          right: BorderSide(
                                                                              color: FlexoColorConstants.LIST_BORDER_COLOR
                                                                          )
                                                                      ),
                                                                    ),
                                                                    width: FlexoValues.deviceWidth * 0.35,
                                                                    height: FlexoValues.deviceHeight * 0.06,
                                                                    child: Text(
                                                                      '${e.price}',
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize: FlexoValues.fontSize16,
                                                                          color: FlexoColorConstants.LIGHT_TEXT_COLOR,
                                                                          fontWeight: e.selected ? FontWeight.bold : FontWeight.normal
                                                                      ),
                                                                    )
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );

                                                      }).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: FlexoValues.heightSpace1Px,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: FlexoValues.deviceWidth * 0.06),

                                  ButtonWidget().getButton(
                                      text: localResourceProvider.getResourseByKey("shipping.estimateShippingPopup.selectShippingOption.button").toString().toUpperCase(),
                                      width: FlexoValues.deviceWidth * 0.4,
                                      onClick: ()
                                      {
                                        cartEstimateShippingProvider.applyEstimateShipping(context: context);
                                      },
                                      isApiLoad: false
                                  ),

                                ],
                              ),
                            ):
                            Container(
                              width: FlexoValues.deviceWidth,
                              padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                              child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey('shipping.estimateShippingPopup.noShippingOptions'),),
                            ):
                            Column(
                              children: [

                                SizedBox(height: FlexoValues.widthSpace3Px),

                                Container(
                                  width: FlexoValues.deviceWidth,
                                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
                                  child: FlexoTextWidget().contentText16(text: localResourceProvider.getResourseByKey('shipping.estimateShippingPopup.noShippingOptions'),),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
