/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopsuite/Common/CheckInternet.dart';
import 'package:nopsuite/Models/ProductBoxModel.dart';
import 'package:nopsuite/Screens/General/LocalResourceProvider.dart';
import 'package:nopsuite/Screens/Products/ProductDetails/ProductDetails.dart';
import 'package:nopsuite/Screens/Shared/ProductBoxProvider.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Colors.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Values.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/RatingBar/rating_bar.dart';
import 'package:nopsuite/Themes/Flexo/Widgets/TextWidget.dart';
import 'package:nopsuite/Utils/Enum/PageTransitionType.dart';
import 'package:nopsuite/Utils/extension.dart';
import 'package:nopsuite/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductBox {
  getProductBox(
      {required BuildContext context,
      required ProductBoxModel productBoxModel,
      required LocalResourceProvider localResourceProvider,
      required Function({required BuildContext context}) updateHeaderData}) {
    var productBoxProvider = context.watch<ProductBoxProvider>();

    final CarouselController _controller = CarouselController();
    int imageIndex = productBoxModel.pictureModels.indexWhere((element) => element.imageUrl == productBoxModel.pictureModels.first);
    if(imageIndex == -1)
    {
      imageIndex = 0;
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: FlexoValues.deviceWidth * 0.49,
          padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (await CheckConnectivity().checkInternet(context)) {
                        Navigator.push( context,PageTransition(type: selectedTransition, child: ProductDetails(productId: productBoxModel.id,updateId: 0,isCart: false))).then((value) {
                          updateHeaderData(context: context);
                        });
                      }
                    },
                    child: Container(
                      width: FlexoValues.deviceWidth * 0.47,
                      height: FlexoValues.deviceWidth * 0.47,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: productBoxModel.pictureModels.map((e){
                              bool isSvgImage = false;
                              if(e.imageUrl.toString().getExtensionFromUrl().toLowerCase() == "svg")
                              {
                                isSvgImage = true;
                              }
                              return isSvgImage ? SvgPicture.network(e.imageUrl) : CachedNetworkImage(
                                imageUrl: e.imageUrl,
                              );
                            }).toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                                initialPage: imageIndex,
                                height: FlexoValues.deviceWidth,
                                disableCenter: true,
                                viewportFraction: 1,
                                enableInfiniteScroll: false,
                                onPageChanged: (index,reason){
                                  setState(() {
                                    imageIndex=index;
                                  });
                                },
                                pageSnapping: true
                            ),
                          ),
                          productBoxModel.pictureModels.length == 1 ? Container() :
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: productBoxModel.pictureModels.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: FlexoValues.iconSize14,
                                        height: FlexoValues.iconSize14,
                                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: FlexoColorConstants.THEME_COLOR),
                                            color: imageIndex == entry.key ? FlexoColorConstants.THEME_COLOR : Colors.white
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: FlexoValues.deviceWidth * 0.47,
                    height: FlexoValues.deviceWidth * 0.47,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                    child: Container(
                      width: FlexoValues.deviceWidth * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          productBoxModel .productPrice.disableAddToCompareListButton ? Container() :
                          Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    productBoxProvider.addToCompareOnClickEvent(context: context,productId: productBoxModel.id);
                                  },
                                  child: Container(
                                      child: CircleAvatar(
                                        child: Icon(
                                          Ionicons.git_compare_outline,
                                          color: FlexoColorConstants.THEME_COLOR,
                                          size: FlexoValues.iconSize19,
                                        ),
                                        maxRadius: FlexoValues.deviceHeight * 0.022,
                                        backgroundColor: Colors.white,
                                      ),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: new Border.all(
                                          color: FlexoColorConstants.BORDER_COLOR,
                                          width: 1,
                                        ),
                                      )
                                  ),
                                ),

                                SizedBox(height: FlexoValues.widthSpace1Px,),
                              ],
                            ),

                            productBoxModel.productPrice.disableWishlistButton ? Container() :
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    bool response = await productBoxProvider.addToWishlistOnclickEvent(context: context,localResourceProvider:localResourceProvider,productId: productBoxModel.id);
                                    if (response) {
                                      updateHeaderData(context: context);
                                    }
                                  },
                                  child: Container(
                                      child: CircleAvatar(
                                        child: Icon(
                                          Ionicons.heart_outline,
                                          color: FlexoColorConstants.THEME_COLOR,
                                          size: FlexoValues.iconSize19,
                                        ),
                                        maxRadius:FlexoValues.deviceHeight * 0.022,
                                        backgroundColor: Colors.white,
                                      ),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: new Border.all(
                                          color: FlexoColorConstants.BORDER_COLOR,
                                          width: 1,
                                        ),
                                      )
                                  ),
                                ),

                                SizedBox(height: FlexoValues.widthSpace1Px,),
                              ],
                            ),

                            productBoxModel.productPrice.disableBuyButton ? Container() :
                            GestureDetector(
                              onTap: () async {
                                bool response = await productBoxProvider.addToCartOnclickEvent(productId: productBoxModel.id,localResourceProvider:localResourceProvider,context: context);
                                if (response) {
                                  updateHeaderData(context: context);
                                }
                              },
                              child: Container(
                                  child: CircleAvatar(
                                    child: Icon(
                                      Ionicons.cart_outline,
                                      color:FlexoColorConstants.THEME_COLOR,
                                      size: FlexoValues.iconSize19,
                                    ),
                                    maxRadius:FlexoValues.deviceHeight * 0.022,
                                    backgroundColor: Colors.white,
                                  ),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: new Border.all(
                                      color: FlexoColorConstants.BORDER_COLOR,
                                      width: 1,
                                    ),
                                 )
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: FlexoValues.widthSpace2Px,),

              GestureDetector(
                onTap: () async {
                  if (await CheckConnectivity().checkInternet(context)) {
                    Navigator.push(context,PageTransition(type: selectedTransition, child:  ProductDetails(productId: productBoxModel.id,updateId: 0,isCart: false))).then((value) {
                      setState(() {
                        updateHeaderData(context: context);
                      });
                    });
                  }
                },
                child: Container(
                  width: FlexoValues.deviceWidth * 0.47,
                  padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                  alignment: Alignment.topCenter,
                  child: FlexoTextWidget().productBoxText(text: productBoxModel.name,maxLines: 1)
                ),
              ),

              SizedBox(height: FlexoValues.heightSpace1Px,),

              productBoxModel.reviewOverviewModel.allowCustomerReviews ?
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                child: RatingBar.builder(
                  initialRating: productBoxProvider.getRating(
                      productBoxModel.reviewOverviewModel.ratingSum,
                      productBoxModel.reviewOverviewModel.totalReviews),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: FlexoValues.fontSize16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ): Container(),

              productBoxModel.productPrice.price == null ? Container(height: FlexoValues.heightSpace3Px,):
              Container(
                width: FlexoValues.deviceWidth * 0.47,
                height: FlexoValues.heightSpace3Px,
                padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace1Px),
                alignment: Alignment.bottomCenter,
                child: FlexoTextWidget().productPriceText(text: productBoxModel.productPrice.price,maxLines: 1),
              ),

              SizedBox(height: FlexoValues.widthSpace1Px,),
            ],
          ),
        );
      },
    );
  }

  getHorizontalProductBox(
      {required BuildContext context,
      required ProductBoxModel productBoxModel,
      required LocalResourceProvider localResourceProvider,
      required Function({required BuildContext context}) updateHeaderData}) {
    var productBoxProvider = context.watch<ProductBoxProvider>();
    final CarouselController _controller = CarouselController();
    int imageIndex = productBoxModel.pictureModels.indexWhere((element) => element.imageUrl == productBoxModel.pictureModels.first);
    if(imageIndex == -1)
    {
      imageIndex = 0;
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: FlexoValues.deviceWidth * 0.40,
          padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (await CheckConnectivity().checkInternet(context)) {
                        Navigator.push(context,PageTransition(type: selectedTransition, child: ProductDetails(productId: productBoxModel.id,updateId: 0,isCart: false))).then((value) {
                          updateHeaderData(context: context);
                        });
                      }
                    },
                    child: Container(
                      width: FlexoValues.deviceWidth * 0.40,
                      height: FlexoValues.deviceWidth * 0.40,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: productBoxModel.pictureModels.map((e){
                              bool isSvgImage = false;
                              if(e.imageUrl.toString().getExtensionFromUrl().toLowerCase() == "svg")
                              {
                                isSvgImage = true;
                              }
                              return isSvgImage ? SvgPicture.network(e.imageUrl) : CachedNetworkImage(
                                imageUrl: e.imageUrl,
                              );
                            }).toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                                initialPage: imageIndex,
                                height: FlexoValues.deviceWidth,
                                disableCenter: true,
                                viewportFraction: 1,
                                enableInfiniteScroll: false,
                                onPageChanged: (index,reason){
                                  setState(() {
                                    imageIndex=index;
                                  });
                                },
                                pageSnapping: true
                            ),
                          ),
                          productBoxModel.pictureModels.length == 1 ? Container() :
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: productBoxModel.pictureModels.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: FlexoValues.iconSize14,
                                        height: FlexoValues.iconSize14,
                                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: FlexoColorConstants.THEME_COLOR),
                                            color: imageIndex == entry.key ? FlexoColorConstants.THEME_COLOR : Colors.white
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: FlexoValues.deviceWidth * 0.39,
                    height: FlexoValues.deviceWidth * 0.39,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(FlexoValues.widthSpace1Px),
                    child: Container(
                      width: FlexoValues.deviceWidth * 0.39,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          productBoxModel.productPrice.disableAddToCompareListButton
                              ? Container()
                              : Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  productBoxProvider.addToCompareOnClickEvent(
                                      context: context,
                                      productId: productBoxModel.id);
                                },
                                child: Container(
                                    child: CircleAvatar(
                                      child: Icon(
                                        Ionicons.git_compare_outline,
                                        color:FlexoColorConstants.THEME_COLOR,
                                        size: FlexoValues.iconSize19,
                                      ),
                                      maxRadius: FlexoValues.deviceHeight * 0.022,
                                      backgroundColor: Colors.white,
                                    ),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: new Border.all(
                                        color: FlexoColorConstants.BORDER_COLOR,
                                        width: 1,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: FlexoValues.widthSpace1Px,
                              ),
                            ],
                          ),
                          productBoxModel.productPrice.disableWishlistButton
                              ? Container()
                              : Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  bool response = await productBoxProvider.addToWishlistOnclickEvent(context: context,
                                      localResourceProvider:
                                      localResourceProvider,
                                      productId: productBoxModel.id);

                                  if (response) {
                                    updateHeaderData(context: context);
                                  }
                                },
                                child: Container(
                                    child: CircleAvatar(
                                      child: Icon(
                                        Ionicons.heart_outline,
                                        color: FlexoColorConstants.THEME_COLOR,
                                        size: FlexoValues.iconSize19,
                                      ),
                                      maxRadius:FlexoValues.deviceHeight * 0.022,
                                      backgroundColor: Colors.white,
                                    ),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: new Border.all(
                                        color:
                                        FlexoColorConstants.BORDER_COLOR,
                                        width: 1,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: FlexoValues.widthSpace1Px,
                              ),
                            ],
                          ),
                          productBoxModel.productPrice.disableBuyButton
                              ? Container()
                              : GestureDetector(
                            onTap: () async {
                              bool response = await productBoxProvider
                                  .addToCartOnclickEvent(
                                  productId: productBoxModel.id,
                                  localResourceProvider:
                                  localResourceProvider,
                                  context: context);

                              if (response) {
                                updateHeaderData(context: context);
                              }
                            },
                            child: Container(
                                child: CircleAvatar(
                                  child: Icon(
                                    Ionicons.cart_outline,
                                    color: FlexoColorConstants.THEME_COLOR,
                                    size: FlexoValues.iconSize19,
                                  ),
                                  maxRadius: FlexoValues.deviceHeight * 0.022,
                                  backgroundColor: Colors.white,
                                ),
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(
                                    color: FlexoColorConstants.BORDER_COLOR,
                                    width: 1,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: FlexoValues.widthSpace2Px,
              ),
              GestureDetector(
                onTap: () async {
                  if (await CheckConnectivity().checkInternet(context)) {
                    Navigator.push(context,PageTransition(type: selectedTransition, child:  ProductDetails(productId: productBoxModel.id,updateId: 0,isCart: false))).then((value) {
                      updateHeaderData(context: context);
                    });
                  }
                },
                child: Container(
                  width: FlexoValues.deviceWidth * 0.40,
                  padding: EdgeInsets.symmetric(
                      horizontal: FlexoValues.widthSpace1Px),
                  alignment: Alignment.topCenter,
                  child: FlexoTextWidget().productBoxText(text: productBoxModel.name,maxLines: 1),
                ),
              ),

              SizedBox(height: FlexoValues.heightSpace1Px,),

              productBoxModel.reviewOverviewModel.allowCustomerReviews
                  ? Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(
                    horizontal: FlexoValues.widthSpace1Px),
                child: RatingBar.builder(
                  initialRating: productBoxProvider.getRating(
                      productBoxModel.reviewOverviewModel.ratingSum,
                      productBoxModel.reviewOverviewModel.totalReviews),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: FlexoColorConstants.PRODUCT_RATING_COLOR,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              )
                  : Container(),
              productBoxModel.productPrice.price == null
                  ? Container(
                height: FlexoValues.heightSpace3Px,
              )
                  : Container(
                width: FlexoValues.deviceWidth * 0.47,
                height: FlexoValues.heightSpace3Px,
                padding: EdgeInsets.symmetric(
                    horizontal: FlexoValues.widthSpace1Px),
                alignment: Alignment.bottomCenter,
                child: FlexoTextWidget().productPriceText(
                    text: productBoxModel.productPrice.price, maxLines: 1),
              ),

              SizedBox(
                height: FlexoValues.widthSpace1Px,
              ),
            ],
          ),
        );
      },
    );
  }
}
