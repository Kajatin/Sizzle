<p align="center">
    <img src="https://github.com/Kajatin/Sizzle/assets/33018844/732b5ba5-edb1-4164-8ca7-a828001fb9b6" alt="Sizzle" width="200">
</p>

<p align="center">
    <a href="https://apps.apple.com/dk/app/sizzle-digital-cookbook/id6473077604" target="_blank" rel="noopener noreferrer">
        <img src="https://github.com/Kajatin/Sizzle/assets/33018844/99b66c09-c299-4b00-9068-d3bb82ea9853" height="40">
    </a>
    <a href="https://apps.apple.com/dk/app/sizzle-digital-cookbook/id6473077604" target="_blank" rel="noopener noreferrer">
        <img src="https://github.com/Kajatin/Sizzle/assets/33018844/72769268-fd81-4fc2-9020-0ec51106d560" height="40">
    </a>
</p>

Sizzle is an open-source Swift application that allows you to manage your recipes
digitally. It has a simple and intuitive user interface.

## SwiftData

This app uses SwiftData to manage the recipes in the cloud and to seamlessly sync
them between devices.

There are some hidden requirements to get the iCloud syncing to work. You can read
more about them [here](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-sync-swiftdata-with-icloud).
Main points are:

1. Add iCloud and Background Modes with Remote Notifications capabilities to the
   app's capabilities.
1. Configure a CloudKit container.
1. Make sure the `@Model` struct has default values for all properties or marks them optional.
1. Remember to deploy schema changes to production ([dashboard](https://icloud.developer.apple.com/dashboard)).
1. Create a CloudKit APS certificate for production ([here](https://developer.apple.com/account/resources/certificates/list)).

> [!IMPORTANT]
> In order to get CloudKit syncing between devices in production, I needed to
> configure an APS certificate [here](https://developer.apple.com/account/resources/certificates/list).

# Preview

## iPad

<p align="center">
    <img width="340" src="https://github.com/Kajatin/Sizzle/assets/33018844/c7936cf8-6728-496f-af09-f81c62543f5d">
    <img width="340" src="https://github.com/Kajatin/Sizzle/assets/33018844/c3eeaef1-cfc7-4e01-a7f9-def5dc576e59">
</p>

## Apple TV

<p align="center">
    <img width="640" src="https://github.com/Kajatin/Sizzle/assets/33018844/fca326d2-cbb8-4a1b-a1ab-4663ccf34c9b">
    <img width="640" src="https://github.com/Kajatin/Sizzle/assets/33018844/f944a0e1-2b12-439e-83f0-c0e5a630ae39">
</p>
