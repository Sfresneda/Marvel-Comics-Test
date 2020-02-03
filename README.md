# Marvel Comics Test
=============================

Basic Description
--------------------

- This app follows a VIPER architecture.
- No third party libraries have been used for the App.

Functionallity description
-----------------------------

- The App starts at the SceneDelegate. It instatiates FalseLaunchScreen calling to use case .falseLaunchScreen. When the animation is finished, this view navigate to MasterView, calling to this builder,  which setups the MasterView, MasterPresenter, etc. and present controller embebed on a NavigationController.
- The controller (MasterView) tells the presenter when it ends viewDidLoad or when the user interact with the UI elements. Therefore the MasterPresenter makes the call to the Interactor and creates a new MasterViewModel to reconfigure the view.
- The ViewModel is the datasource for the UICollectionView. It dequeues the cells and configures them with a MasterCollectionViewCellModel. 
- The network calls are wrapped into an Interactor, which uses two services: CachingService and Networking Service.
- The CachingService is a simple service using UserDefaults to cache all queries.
- The CachingService for images is a simple call to NSCache, embebed on a extention in UIImageView.
- The NetworkingService uses URLSessionDataTasks to download the pages.
- Three schemas have been created, so execution, unit testing and UI Testing can be performed on each.


Testing
------
To execute the unit and behaviour tests you will have to change the current schema to the *MarvelTest* schema. 

### Tests

- Presenter: The presenter behaviour has been tested using the native test framework and some mocked layers.

### UI Testing

To execute the UI  tests you will have to change the current schema to the *MarvelUITest* schema.

- Although the challenge does not ask for it, a simple UI Test has been included to show basic UI Testing capabilities.
