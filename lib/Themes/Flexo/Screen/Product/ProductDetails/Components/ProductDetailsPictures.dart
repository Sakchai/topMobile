/// This is a free for use and open source, most complete mobile application for nopCommerce platform based on Flutter and NopSuite front-end API for nopCommerce by NopAdvance LLP.
/// Copyright (C) 2022 - NopAdvance LLP

/// This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License.

/// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

/// This program is forever free software: you can modify and/or redistribute. One cannot sell or relicense the source code it under the terms of the NopAdvance Public license terms.

/// You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nopsuite/Models/PictureBoxModel.dart';
import 'package:nopsuite/Screens/Products/EmailProduct/EmailProduct.dart';
import 'package:nopsuite/Screens/Products/ProductDetails/Model/VideoModels.dart';
import 'package:nopsuite/Screens/Products/ProductDetails/ProductDetailsProvider.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Colors.dart';
import 'package:nopsuite/Themes/Flexo/Utils/Values.dart';
import 'package:nopsuite/Utils/Enum/AddToCartType.dart';
import 'package:nopsuite/Utils/Enum/PageTransitionType.dart';
import 'package:nopsuite/Utils/Enum/ProductType.dart';
import 'package:nopsuite/Utils/extension.dart';
import 'package:nopsuite/Widgets/PageTransition/page_transition.dart';
import 'package:provider/provider.dart';
import '../ProductImage.dart';
import 'ProductDetailsVideo.dart';

class ProductDetailsPictures{

  getView({required BuildContext context})
  {
    print("WHAT IS ERROR");
    var productDetailsProvider = context.watch<ProductDetailsProvider>();
    CarouselController _controller = CarouselController();

    ValueNotifier<int> imageIndex = ValueNotifier(productDetailsProvider.getProductDetailsModel.pictureModels.indexWhere((element) => element.imageUrl == productDetailsProvider.getProductDetailsModel.defaultPictureModel.imageUrl));
    if(imageIndex.value == -1)
    {
      imageIndex.value = 0;
    }
    List<dynamic> picturesAndVideos = [
      ...productDetailsProvider.getProductDetailsModel.pictureModels,
      ...productDetailsProvider.getProductDetailsModel.videoModels,
    ];

    return StatefulBuilder(builder: (context,setState){

      return Container(
        padding: EdgeInsets.symmetric(horizontal: FlexoValues.widthSpace2Px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              child: Stack(
                children: [

                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: FlexoValues.controlsWidth,
                        height: FlexoValues.controlsWidth,
                        child:  CarouselSlider(
                          key: UniqueKey(),
                          carouselController: _controller,
                          items: picturesAndVideos.map((e){
                            if(e is PictureModel)
                            {
                              bool isSvgImage = false;
                              if(e.imageUrl.toString().getExtensionFromUrl().toLowerCase() == "svg")
                              {
                                isSvgImage = true;
                              }
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductImage(pictureModel: picturesAndVideos, defaultImage: e.imageUrl)));
                                },
                                child: isSvgImage ? SvgPicture.network(e.imageUrl) : CachedNetworkImage(
                                  imageUrl: e.imageUrl,
                                ),
                              );
                            }

                            if(e is VideoModel)
                            {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: selectedTransition, child: ProductImage(pictureModel: picturesAndVideos, defaultImage: e.videoUrl)));
                                },
                                child: ProductDetailsVideo().getView(context: context, videoModel: e),
                              );
                            }

                            return Container();


                          }).toList(),

                          options: CarouselOptions(
                            initialPage: imageIndex.value,
                            height: FlexoValues.deviceWidth,
                            disableCenter: true,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            onPageChanged: (index,reason){

                                imageIndex.value=index;

                            },
                            pageSnapping: true
                          ),
                        ),
                      ),

                      picturesAndVideos.length == 1 ? Container() :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: picturesAndVideos.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: ValueListenableBuilder<int>(
                              valueListenable: imageIndex,
                              builder: (context, value, child) {
                                return Container(
                                  width: FlexoValues.iconSize14,
                                  height: FlexoValues.iconSize14,
                                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: FlexoColorConstants.THEME_COLOR),
                                      color: imageIndex.value == entry.key ? FlexoColorConstants.THEME_COLOR : Colors.white
                                  ),
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  Positioned(
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.all(FlexoValues.widthSpace2Px),
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: Column(
                          children: [

                            productDetailsProvider.getProductDetailsModel.compareProductsEnabled?
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: ()
                                  {
                                    productDetailsProvider.addToCompareOnClickEvent(context: context,productId: productDetailsProvider.getProductDetailsModel.id);
                                  },
                                  child: Container(
                                      child: CircleAvatar(
                                        child: Icon(
                                          Ionicons.git_compare_outline,
                                          color: FlexoColorConstants.THEME_COLOR,
                                          size: FlexoValues.fontSize18,
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
                                SizedBox(height: FlexoValues.heightSpace1Px),
                              ],
                            ):Container(),

                            productDetailsProvider.getProductDetailsModel.productType == ProductType.SimpleProduct ?
                            productDetailsProvider.getProductDetailsModel.addToCart.disableWishlistButton ? Container():
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async
                                  {
                                     productDetailsProvider.attributeOnChanged(context: context,addToCartType: AddToCartType.Wishlist,getProductDetailsModel: productDetailsProvider.getProductDetailsModel);
                                  },
                                  child: Container(
                                      child: CircleAvatar(
                                        child: Icon(
                                          Ionicons.heart_outline,
                                          color: FlexoColorConstants.THEME_COLOR,
                                          size: FlexoValues.fontSize18,
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
                                SizedBox(height: FlexoValues.heightSpace1Px,),
                              ],
                            ) : Container(),

                            productDetailsProvider.getProductDetailsModel.emailAFriendEnabled?
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, PageTransition(type: selectedTransition, child: EmailProduct(productID: productDetailsProvider.getProductDetailsModel.id)));
                              },
                              child: Container(
                                  child: CircleAvatar(
                                    child: Icon(
                                      Ionicons.mail_outline,
                                      color: FlexoColorConstants.THEME_COLOR,
                                      size: FlexoValues.fontSize18,
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
                            ):Container(),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      );
    });
  }
}