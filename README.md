# Syte iOS SDK

[![CI Status](https://img.shields.io/travis/arturtarasenko/Syte.svg?style=flat)](https://travis-ci.org/arturtarasenko/Syte)
[![Version](https://img.shields.io/cocoapods/v/Syte.svg?style=flat)](https://cocoapods.org/pods/Syte)
[![License](https://img.shields.io/cocoapods/l/Syte.svg?style=flat)](https://cocoapods.org/pods/Syte)
[![Platform](https://img.shields.io/cocoapods/p/Syte.svg?style=flat)](https://cocoapods.org/pods/Syte)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Syte is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Syte'
```

## Account Credentials

In order to use this SDK, please contact Syte for your account ID and signature.     

## Use the SDK

# Initialization

To start using the Syte SDK, instantiate the SyteConfiguration object and pass your API credentials to its constructor. 
Your credentials can be found in Syte’s Platform - Settings - API Keys.
Then use the created instance to set the locale.
```swift  
let configuration = SyteConfiguration(accountId: <account_id>, signature: <api_signature>)
configuration.locale = <locale>
```

Then you'll need to initialize Syte class passing the configuration instance :

```swift  
var syte: Syte? = Syte(configuration: configuration)
```

Event fires automatically: https://syteapi.com/et?name=syte_init&account_id=[account_id]&session_id=[session_id]&sig=[api_signature]&syte_uuid=[user_id]&build_num=&lang=&tags=syte_ios_sdk&syte_url_referer=[app_name]

API used: https://cdn.syteapi.com/accounts/[account_id]

To retrieve the instance of SytePlatformSettings use the syte.getSytePlatformSettings() method.

For get recent searches:
```swift
syte.getRecentTextSearches()
```

For set viewed product:
```swift
syte.addViewedProduct(sku: <String>)
```

Get all viewed items:
```swift
syte.getViewedProducts()
```

## Image Search

Object detection ("bounds") and a similarity search ("Items") per object detected in the image. 
Search can be performed with an image or image URL.

To use the image Search functionality do the following:

1. Create dedicated class instance and pass the required data.

For Url image search:
```swift  
let imageSearchRequestData = UrlImageSearch(imageUrl: <image url>, productType: <SyteProductType>)
```
For image search:
```swift  
let imageSearchRequestData = ImageSearch(image: <UIImage>)
```
2. Retrieve bounds:

For Url image search:
```swift  
syte.getBoundsForImageUrl(requestData: <UrlImageSearch>) { [weak self] result in
// Handle response, result type is SyteResult<BoundsResult> 
}
```
For image search:
```swift  
syte.getBoundsForImage(requestData: <ImageSearch>) { [weak self] result in
// Handle response, result type is SyteResult<BoundsResult> 
}
```
3. Retrieve Items for a bound:
```swift  
syte.getItemsForBound(bound: Bound, cropCoordinates: CropCoordinates) { result in
// Handle response
}
```

You can pass CropCoordinates instance instead of *nil* here to enable the crop functionality. Example:
```swift  
let coordinates = CropCoordinates(x1: 0.2, y1: 0.2, x2: 0.8, y2: 0.8) // The coordinates should be relative ranging from 0.0 to 1.0
syte.getItemsForBound(bound: <Bound>, cropCoordinates: coordinates) { result in
// Handle response, result type is SyteResult<ItemsResult> 
}
```

**NOTE**
Items for the first bound will be retrieved by default.
Use 
```swift
urlImageSearch.retrieveOffersForTheFirstBound = false
```
or
```swift
imageSearch.retrieveOffersForTheFirstBound = false
```
to disable this behaviour.
To get the items for the first bound use the 
```swift 
BoundsResult.firstBoundItemsResult
``` 
variable.

# Product Recommendations
To use the "Recommendations" functionality, do the following:

1. Use Syte class instance to get results for different features:

*   `getSimilarProducts(similarProducts: SimilarProducts, completion: @escaping (SyteResult<SimilarProductsResult>) -> Void)`
*   `getShopTheLook(shopTheLook: ShopTheLook, completion: @escaping (SyteResult<ShopTheLookResult>) -> Void)`
*   `getPersonalization(personalization: Personalization, completion: @escaping (SyteResult<PersonalizationResult>) -> Void)`

**NOTE:** You must add at least one product ID to use the "Personalization" functionality. To do this use the 
```swift
Syte.addViewedProduct(String)
``` 
method.

# Personalized ranking

Enabling the personalized ranking will attach the list of viewed products to the requests. 
To add a product to the list of viewed ones use the
```swift
Syte.addViewedProduct(String)
```
method.
To enable this functionality use the 
```swift
personalizedRanking = true
```
variable. 
It is supported in the following classes: 
```swift
UrlImageSearch, ImageSearch, ShopTheLook, SimilarProducts
```
Personalized ranking is disabled by default.

# Data Collection

The SDK can be used to fire various events to Syte. Example:
```swift  
syte.fireEvent(EventCheckoutStart())
```
# Text Search

The SDK can be used for the Text Search functionality.

There are 3 main features:

1. Popular Searches. Will retrieve the list of the most popular searches.
```swift  
syte.getPopularSearches(lang: String, completion: @escaping (SyteResult<[String]>) -> Void)
```
2. Text search. Will retrieve the results for the specified query.
```swift  
syte.getTextSearch(textSearch: TextSearch, completion: @escaping (SyteResult<TextSearchResult>) -> Void)
```
To retrieve a list of recent text searches use syte.getRecentTextSearches() method.

3. Auto-complete. Text auto-completion functionality.
```swift  
syte.getAutoCompleteForTextSearch("query", "en_US") { [weak self] result in
// Handle response, result type is SyteResult<AutoCompleteResult>
}
```

# Platform settings
To retrieve the Syte Platform Settings use:
```swift  
syte.getPlatformSettings(completion: @escaping (SyteResult<SytePlatformSettings>) -> Void)
```     

## Author

Artur Tarasenko, artur.tarasenko@cloverdynamics.com

## License

Syte is available under the MIT license. See the LICENSE file for more info.
