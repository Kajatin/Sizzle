<h1 align="center">
    <picture>
        <img src="https://user-images.githubusercontent.com/7659/174594540-5e29e523-396a-465b-9a6e-6cab5b15a568.svg" alt="Sizzle" width="336">
    </picture>
</h1>

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
