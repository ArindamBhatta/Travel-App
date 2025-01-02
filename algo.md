#### Initial State

1. Fetch Data from Two Remote Sources in one Method and return two data from this method by using a Map
	•	1st Fetch Data is  FireStore Collection PublisherData.
	•	2nd Fetch Data is FireStore Document currentUser.
        •    Create a Map to return Both List of PublisherData, currentUser. List of publisher_key;

2. Define Data Models & Get Current user WishListedData from Document SnapShort.
	•	Define a PublisherModel with fields using combibinedData['publisherData'];
	•	Store user WishListedData  from combinedData['user']['wishlistedData'] 
	•	Store publisherKey using combinedData['publisher_key']

3. Process Data to Find wishListed or not
	•	iterate  through List<PublisherModel> create a class  
		•	pass the individual publisherKey[i]
		•	pass the WishListedData 

4. Filter Data
	• if(WishListedData.contains(publisherKey[i])) return true;
    • Send  Data to UI

### 2nd Step
> if user Tap a button for wishlist 

5. onTap FireStore userWishList is trigger 
 • check 1st data already exist in fireStore if present then remove from fireStore. if doesn't present add this data.
	
