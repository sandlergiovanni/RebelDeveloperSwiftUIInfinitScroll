# Rebel Developer - SwiftUI Infinite Scroll Tutorial

Micro tutorial of "Rebeloper" (Rebel Developer) YouTube channel.

On this tutorial we will get starts with SwiftUI + Firebase request to fill a List with remote data using infinite scroll (+ pagination).

To see more, visit: https://www.youtube.com/watch?v=x8aB8hZ0S5k&t=1120s&ab_channel=Rebeloper-RebelDeveloper

## Our Steps

### Step 1 - Create a new Xcode SwiftUI project of type iOS.

- Xcode > File > New > Project;
- Choose: iOS > App;
- In "Product Name" field type "FirebaseInfiniteScroll";
- In "Interface" choose "SwiftUI";
- Click "Next" and choose directory location;
- Finish by clicking on "Create" button.

### Step 2 - Go to Firebase

- Open up your favourite browser and go to https://firebase.google.com/ ;
- Click on rigth top option "Go to console" link;
- Choose "Add project" on main page;
- On step 1 of 3 (create project option screen), type your project name: FirebaseInfiniteScroll;

![Create firebase project](images/img01.png)

- Set confirm checkbox as on (yes, I do to continue) and click on Continue button;
- On step 2 of 3, disable Google Analytics option and click on Create Project button;
- Waiting for project setup finish, so, click on Continue button;

### Step 3 - Set up our project with Firebase configurations and options

- Click on rounded iOS+ button (followed by Android and HTML project options - right side on bottom) to add new iOS project configurations;

![Create iOS settings](images/img02.png)

- Fill the "Apple bundle ID" option with your project name (e.g.: br.com.yoursite.FirebaseInfiniteScroll);

![Add your iOS bundle identify](images/img03.png)

- Click on Register app and let's waiting a little bit;
- On the next screen, click on "Download GoogleService-info.plist" to download file, and so, click on Next button;
- Drag and drop downloaded file inside your xcode FireBaseInfiniteScroll folder (root project files folder);

![Download info.plist pre-settings file](images/img04.png)

- Check "Copy items if needed" and "Create groups" options enabled on modal screen;

![Set copy options](images/img05.png)

- Go back to your browser and copy github link of firebase-ios-sdk (on step "Add Firebase SDK") and click next;
- Go to Xcode again and select your main "FirebaseInfiniteScroll" top project file;
- On the main screen ("FirebaseInfiniteScroll.xcodeproj" panel) choose "PROJECT" > FirebaseInfiniteScrool blue icon;

![Download info.plist pre-settings file](images/img06.png)

- Click on "Package Dependencies" tab, click on "+" (plus button) and type the copied link on "Search" screen option;

![Fill "Search" field to continue](images/img07.png)

- Wait for wizard locate package and click on "Add Package" button after package loaded (and let's wait again.. aff);

![Library details](images/img08.png)

- When loading proccess finished and show package library list, let's select "FirebaseFirestore" and "FirebaseFirestoreSwift" options and setting up "FirebaseInfiniteScroll" project on "Add to Target" column;

![Select only two options](images/img09.png)

- All Firebase package libraries will appear on your Xcode left side project tab.

![All needed libraries](images/img10.png)

- Let's go back to our browser and click o "Next" button on Firebase step 3 (where we copy github library link);
- We'll split the code available on Firebase site into our own files, so, let's create a new "AppDelegate.swift" file on Xcode using "File > New > File..." menu option;

![New AppDelegate.swift file](images/img11.png)

- In this new file, let's copy and paste the first block of Firebase website;
- Finnaly, let's copy our adapter (@UIApplicationDelegateAdaptor) to correct location on our FirebaseInfinitScrollApp file.

![Setup our adapter](images/img12.png)

### Step 4 - Let's setup Firebase

- On Firebase web site, click on "Continue to console" option to go to Firebase console;
- There, choose "Build" > "Firestore Database" (and wait again... aff);

![New database](images/img13.png)

- Our next option is "Create database" that will appear on main site after screen auto update;
- Warning here: is not possible change database location after create one, so, think a little bit before choose;
- For our tests purpose, chose "Start in test mode" and wait for task finished;
- We can generate our Collection on Firebase web site, but, we get starts creating that on our mobile App.
