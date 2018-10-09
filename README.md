# WallaMarvel
This project is a sample test app for Wallapop to led discuss their devs about what character of the Marvel universe is the best one!

Now we will show a quick guide about the main classes in the project, the structure of the targets, as well as the pattern used and why.

## Targets
We have 5 targets in the App
#### - WallaMarvel
The App's main target. Gots the app logic, coordinators...
#### - WallaMarvelKit
An utilities target extensions and managers shared between **WallaMarvelAPI** and **WallaMarvelUI**
#### - WallaMarvelAPI
Gots the API managers, models, serializers and so on. It must be perfectly suitable to take it off and make a library of it for using elsewhere (Adding the needed dependencies, of course)
#### - WallaMarvelUI
Gots the UI modules, UIKit extensions, colors and so on... As WallaMarvelAPI, it must be perfectly suitable to take it off and make a library of it for using elsewhere.
#### - WallaMarvelAPITests
A simple tests target for WallaMarvelAPI as a sample.

## App Structure
The app uses a VIPER-like pattern, but not being 100% faithful.
The components are the followings:
#### - ViewController
  It'll act as the "View" component of the VIPER module. It'll only draw what the presenter tells him. It doesn't know anything about requests, models, data or some kind of business/model tasks.
  What concerns a view in this pattern is to draw, animate, take care of the view lifecycle and show the user the data in a pretty manner.

#### - Mediator
In VIPER, they call this kind of classes a "Presenter", but to me, it has so many responsibilities (Remember, we have to keep the [SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle)) as they interact with the interactor and prepare the data to be presented in the view.
Here, in this pattern a mediator will only comunicate with the other  components of the module, that is, it'll behave as a "Mediator" (That's where the name came from) between the presenter, the delegate caller and interactors if any.
The mediator knows about models, about requests and about all business-related tasks but it will ***never*** will handle view lifecycles or some kind of UIKit components (So we can't for example do an `import UIKit` in this kind of classes). It has to be reusable as much as possible so if I take a coordinator to a Mac app, it has to be reusable there.
This classes must be read as a pseudo-code for what the module do, I mean, you must see what happens for example when a reload is made or when a certain button is tapped just by reading the code in the method.
#### - Presenter
  This class acts like a decorator for the view. It handles the models that the mediator tells him in order to process it and prepare it for the view.
  It just knows the view, and receive orders from the mediator in order to prepare the data to be shown in the view.
  #### - Delegate caller
  This is a simple class that only know the view that handles the delegate (The view controller), it has a few methods in order to call one or other delegate method when the mediator tells him. 
  This way, the mediator doesn't know the view parameters that are passed into the delegate methods, for example, delegate caller can call this method of a delegate `func controllerDidSomething(_ controller:UIViewController)` and then the mediator didn't even notice that a controller is passed in that delegate method, it only knows that something have happened, and that the delegate should be called.
#### - Wirer
The wirer is a super-simple class that all views call in the init method. It takes the view to bind (and view config if any) and wires it up with all the components in this VIPER-like module. In a VIPER pattern this is called a 

## Absence of interactor
I've talked that a VIPER-like pattern was used, but... where are the interactors? 
Well, unless you're using some CoreData or some other difficult-to-access method for retrieving your data I see in the interactors just boilerplate code.
I prefer to retrieve the data directly from the manager that makes the request instead of calling an interactor that will then call the manager that makes the same request, so in order to avoid boilerplate code and in order to respect the [KISS](https://en.wikipedia.org/wiki/KISS_principle) principle, I've removed entirely the interactor from this pattern.

## Coordinators
So we've talked about all components (more or less) of a VIPER module but... where's the router?
Well, as you may seen, no module have a router in it. That's because I've structured all controllers to be independent and just show a clean interface to the outside (In the exposed interface of a view controller no one will know that a certain controller is structured in a VIPER way, but in fact, any caller from outside doesn't mind about how the controller is designed).
You'll never see a ViewController pushing/presenting/showing directly another controller, instead, when an important action happened (Such as a cell taped in a list), the view controller (Well, the module as a whole) calls the appropriate delegate method in order for someone to hear it, here is where coordinators take action.

Coordinators are much like a router in a VIPER module, but they're not attached to a single controller, instead, they can handle a common cycle between 2 or 3 controllers, just handle 1 controller, or not handle a controller at all.

They're also not part of the module, but they are in the main target as they define the concrete app lifecycle by chaining one coordinator to another and so on.

You can read more about coordinators [here](http://khanlou.com/2015/10/coordinators-redux/)

## Requests & Serializing
The requests are made in a traditional manner, using static methods in namespaced structs such as `
API.Characters.Get`. They serve as interactors to the mediators in the UI target.
Also, highlight that no JSON mapping is made on the models (A model doesn't have to matter what it is initialized with (Remember, [SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle) ;D )). 
Instead little classes called with suffix `MappingEntity` will take care to read from the JSON and make a new entity (A model) and viceversa.
The `MappingEntity`classes, therefore, is a mapper class that *reads from* and *writes to* JSON objects.
That way, we could make different mappers for a single entity, for example making a `DefaultCharacterMappingEntity` and a `DeprecatedCharacterMappingEntity` if it is needed, leading to a flexibility at the time of reading/writing data.
## FAQ
#### - Why the project makes request to Marvel API manually instead of using a pre-made library such as Marvellous or MarvelAPIClient?
  That's because I wanted to do a couple calls to the API by myself using Alamofire. Using a library would be so easy! :D

#### - Up in the "App structure" section you said that views never interact with models but in some contollers some models are passed in function parameters. Why is that?
  The only time that I let a ViewController get a model is because some other controller needs it in order to be created. For example, if I in the `CharactersListViewController` a `CharactersFilter` is passed into the view in order for it to show a `CharactersFiltersViewController`. You can think about as if it was a `String` that is needed to fill a `UITextField`, you pass it from the presenter to the view, but the view should ***NEVER*** interact with that model, the view just pass it to the desired controller or view in order to draw something.

#### - But you said that no ViewController will ever present/push/show another controller, why sometimes you're doing it?
In some cases, showing a controller from another controller ignoring a coordinator will be useful if we can treat that presenting controller  as if it was a UIView. 
If we can think about the controller to present as if it was a view (Such as a UIPickerView or something like that) then it may be suitable to present a controller and avoiding calling a delegate for a coordinator to know.

For example, `CharacterListViewController`  calls `CharactersFilterViewController` on a tap without letting the delegate know (And therefore, settings aside the coordinator), that's because we can think of `CharactersFilterViewController` as if it was a children controller or a view that appears in order to help `CharacterListViewController` to do some tasks. Also, it would be so repetitive to implement the presentation of `CharactersFilterViewController` every time that we need to implement a `CharacterListViewController` and therefore, ``CharacterListViewController` implements and shows the filter by itself.

#### - Why in the models contained in WallaMarvelAPI target (Such as Character or Comic) not all fields that comes from Marvel API are included?
This is a test, so I tried to retrieve only what I'll be using for the views

#### - I saw the git repository and I see branches like feature/IOS-{number}? What is that?
  I followed the gitflow workflow for this project as it is the main workflow that I use for every project.  
  You can check it out [here](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow).
  
  If you want to see what does an ID represents, there is a little sheet [here](https://docs.google.com/spreadsheets/d/1VmZEqAKNQcfZRwvrClw_kIZ6nQDGMdojVAitKFfKW_M/edit?usp=sharing)
  
#### - In Marvel API, some models come with fields that are optionals, but you treat them as non-optionals in your models in WallaMarvelAPI target. Why is that?
  Sometimes the model doesn't make any sense without some fields, at least for the app, so I was forcing all the models to have a required fields sometimes in order to make sense. 
  For example, would it make sense to show a comic without the title?
  
#### - Why there is some controllers in the main target (WallaMarvel) and some controllers in the UI target (WallaMarvelUI)?
  It's because the reusability of the controllers, to keep some order. 
  The controllers that live in the main target (WallaMarvel) are there because they wouldn't make sense in an API or in other app if someday it is needed. 
  On the other hand, if you see the controllers in the UI target (WallaMarvelUI) they are more generic and they tend more to be in a library for example for cocoapods. In other words, the target of WallaMarvelUI is intended to be decoupled as maximum as possible from the App and that makes that target an independent module ready to inject into other app if it's necessary.
  
#### - Why there are just a few tests?
As this is a test project I inverted my time in making some cool features instead of doing testing, but in the future and if it's needed, I'll add some new tests to all targets!
Therefore, I've just made a couple of tests as a template.
Also, and I'm aware of it, I have to improve my testing skills and It will be a cool idea to improve them in this project.

## More
Suggestions? Questions? Threats? If it's the case, just let me know 😁
