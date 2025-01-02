### Initial State

BEGIN

> Fetch Data from Remote Sources
FUNCTION fetchData() RETURNS Map
    publisherData = Firestore.getCollection("PublisherData")
    userData = Firestore.getDocument("currentUser")
    
    combinedData = {
        "publisherData": publisherData,
        "userData": userData,
        "publisherKey": publisherData.id
    }
    
    RETURN combinedData
END FUNCTION

> Process Data into Models and Extract Wishlist
wishlistedData, publisherData, publisherKeys, publishersList = []

FUNCTION processData(combinedData) RETURNS Map
    wishlistedData = combinedData["userData"]["wishlistedData"]
    publisherData = combinedData["publisherData"]
    publisherKeys = combinedData["publisherKey"]

    FOR EACH publisher IN publisherData 
        publisherModel = CREATE PublisherModel(publisher)
        ADD publisherModel TO publishersList
    END FOR
   
END FUNCTION

> Process Data to Identify Wishlisted Items
FUNCTION findWishlistedData(data) RETURNS List
  

        FOR EACH destination publisherList
            userWishlistData:  wishlistData,
            publisherKeys: publisherKeys[i]

        IF wishlistedData.CONTAINS(publisherKey) THEN
            SET publisher.isWishlisted = TRUE
        ELSE
            SET publisher.isWishlisted = FALSE
        END IF

        ADD publisher TO processedData
    END FOR

END FUNCTION