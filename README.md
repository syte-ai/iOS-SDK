# Syte.ai Native Android SDK

# Targets

 - Syte - project for SDK. Build to generate Syte.framework file to send to client
 - TestSyte - demo app project

# How To Use

 1. Generate Syte.framework file: choose the target and run build.
 2. Copy the file from 'Build' directory created inside project root directory.
 3. Add Syte.framework to project.
 4. Click on project name (root) and choose the target. Under 'Linkes Frameworks And Libraries' click '+' and choose Syte.framework.

# Use the SDK

    - Add 'import Syte'

    - Initialize the SDK:
    let syte = SyteAI.init(accountID: "____", token: "____")
    
    - Modify config example:
    options: catalog, currency, gender, category
    self.syte.modifyConfig(currency = "EUR")
    
    - Get bounds for selected image:
    self.syte.getBoundsForImage(fromUrl: "____", feeds: ["general"], successCallback, failCallback)
    
    - Get bounds for image URL:
    self.syte.getBoundsForImage(image: <UIImage_object>, feeds: ["general"], successCallback, failCallback)
    
    - Get offers for bound:
    self.syte.getOffers(url: <url_from_bound>, successCallback, failCallback)
