# Tripify Flutter Version

## Workspace

Github:

- Repository: https://github.com/stefaniasilivestru/MobileAppDevelopmentProject2
- Releases: https://github.com/stefaniasilivestru/MobileAppDevelopmentProject2/releases

Workspace: https://upm365.sharepoint.com/sites/MobileDevelopmentAlexeSilivestru/SitePages/Week-7.aspx .

## Description

Tripify is the perfect app for creating, managing, and exploring unique routes tailored to your interests. Whether you're a movie buff, a nature enthusiast, or simply seeking new adventures, Tripify empowers you to curate personalized journeys with ease.

With Tripify, you can effortlessly save, edit, and delete routes based on specific criteria, ensuring each excursion aligns perfectly with your preferences. Say goodbye to generic itineraries and hello to tailor-made experiences that cater to your passions. From strolling through the streets of classic films to reliving scenes from beloved TV shows, Tripify transforms ordinary outings into cinematic adventures.

Moreover, with Tripify you can check the weather forecast for your chosen route to ensure optimal conditions, and visualize your path on an interactive map for seamless navigation.

Tripify also fosters social connectivity by enabling authentication, route sharing with friends, and multilingual support for users (EN/ES for the moment). Additionally, the app values user feedback, offering a convenient avenue to share suggestions and enhancements via email or to post user opinions to see all the reviews that app has so far.

In comparison to existing apps on the market, Tripify stands out for its specialized focus on movie and series filming locations, offering a unique niche that caters to entertainment enthusiasts.

## Screenshots and navigation

Include screenshots of the app in action. You can upload the images to GitHub and then reference them here using Markdown or HTML syntax:

<table>
  <tr>
    <td>
      <img src="img/home_page.png" width="80%" alt="Home Screen"/>
      <p align="center">Home Screen</p>
    </td>
    <td>
      <img src="img/menu.png" width="80%" alt="Menu"/>
      <p align="center">Menu of the app</p>
    </td>
    <td>
      <img src="img/register_page.png" width="80%" alt="Register page"/>
      <p align="center">Register page</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/profile_page_login.png" width="80%" alt="Profile page login"/>
      <p align="center">Profile Screen - Login</p>
    </td>
    <td>
      <img src="img/profile_page_toast_login_failed.png" width="80%" alt="Profile page login"/>
      <p align="center">Login failed + Toast</p>
    </td>
    <td>
      <img src="img/profile_page_connected.png" width="80%" alt="Profile page login"/>
      <p align="center">User is logged in</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/map_activate_location.png" width="80%" alt="Map Screen"/>
      <p align="center">Activate location on your device</p>
    </td>
    <td>
      <img src="img/map_screen.png" width="80%" alt="Map Screen"/>
      <p align="center">Map Screen</p>
    </td>
    <td>
      <img src="img/map_screen_from_local.png" width="80%" alt="Map Screen"/>
      <p align="center">Map View - local database</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/routes_offline_local_database.png" width="80%" alt="Places - Local Database"/>
      <p align="center">Places - Local Database</p>
    </td>
    <td>
      <img src="img/routes_offline_local_database_update.png" width="80%" alt="Places - Local Database"/>
      <p align="center">Places - Update</p>
    </td>
    <td>
      <img src="img/routes_offline_local_database_delete.png" width="80%" alt="Places - Local Database"/>
      <p align="center">Places - Delete</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/message_login_required.png" width="80%" alt="Routes"/>
      <p align="center">Error - User need to be logged to perfom actions</p>
    </td>
    <td>
      <img src="img/error_register_passwords.png" width="80%" alt="Register"/>
      <p align="center">Error - Passwords don't match</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/routes_page_firebase.png" width="80%" alt="Routes"/>
      <p align="center">Routes - Using Firebase</p>
    </td>
    <td>
      <img src="img/add_place_route.png" width="80%" alt="Routes"/>
      <p align="center">Add place</p>
    </td>
    <td>
      <img src="img/add_route.png" width="80%" alt="Routes"/>
      <p align="center">Add route</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/view_places_route.png" width="80%" alt="Routes"/>
      <p align="center">View Places - Firebase</p>
    </td>
    <td>
      <img src="img/view_route_map.png" width="80%" alt="Routes"/>
      <p align="center">View route on map</p>
    </td>
    <td>
      <img src="img/delete_route.png" width="80%" alt="Routes"/>
      <p align="center">Delete route</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/weather_screen.png" width="80%" alt="Routes"/>
      <p align="center">See weather</p>
    </td>
    <td>
      <img src="img/feedback_page.png" width="80%" alt="Feedback"/>
      <p align="center">Feedback Screen</p>
    </td>
    <td>
      <img src="img/share_screen.png" width="80%" alt="Share"/>
      <p align="center">Share Screen</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/settings_screen.png" width="80%" alt="Settings"/>
      <p align="center">Settings Screen</p>
    </td>
    <td>
      <img src="img/settings_screen_ES.png" width="80%" alt="Settings"/>
      <p align="center">Settings Screen ES</p>
    </td>
  </tr>
  <tr>
    <td>
      <img src="img/profile_page_ES.png" width="80%" alt="Share"/>
      <p align="center">Profile page in Spanish</p>
    </td>
    <td>
      <img src="img/profile_page_login.png" width="80%" alt="Share"/>
      <p align="center">Profile page in English</p>
    </td>
  </tr>
</table>

## Demo Video

Video demonstrating how the app works: https://shorturl.at/XQ1D5

## Features

List the **functional** features of the app.

- Add routes and places using a specific criteria (e.g in our demo: routes in cities where famous movies and series were filmed)
- Display route on map
- Change language app
- List your places offline and online
- Delete and edit route
- See weather for a specific route
- Add/Edit/Deelete feedback based on your experience on app

List the **technical** features of the app.

- Persistence in csv/text file -> Coordinates + Timestamp of places
- Persistence in Shared Preferences (routeName and routeId)
- Persistence in local database - SQFLite
- Display Data in UI using ListView
- Widgets lifecycles
- Use of Logging for debug
- Pop-up messages: Alerts, Toasts, Dialogues, Snackbars
- Firebase Realtime database : on routes and feedbacks
- Firebase Authentication
- Maps: OpenStreetMaps - geolocating coordinates using it
- Restful APIs used: (_Openwheathermaps https://openweathermap.org/api .Retrieve weather information data based on specific location_).
- Menu: Navigation Drawer Menu
- Internationalizing App (EN/ES language available: Flutter_localizations package
- Splash Screen
- Replace icon using flutter_launcher_icons

## How to Use

How to get started with the app as user:
- Create an account using Email & Password or Sign up by Gmail
- Log in into your account
- Add a route by typing the city where the route will be located
- Choose your niche route (eg: route where famous movies were filmed)
- Add places
- Choose what actions to perform: see weather details, see route on map, delete your route
- If needed, change your app language
- If needed, share your feedback on Gmail to the creators of the app or with other users posting reviews
- If needed, tell your friends about your routes

## Additional section

The routes.txt file has some tests to check the functionality of the app.

## Participants

List of MAD developers:

- Name: Silivestru Stefania (stefania.silivestru@alumunos.upm.es)
- Name: Alexe Mihai-Victor(mihai-victor.alexe@alumunos.upm.es)
