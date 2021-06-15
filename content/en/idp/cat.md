---
title: "Pseudo-credential and CAT"
date: Wed 17 Mar 2021 10:15:38 CET
weight: 410
---

**NOTE: This is ONLY needed if you use the pseudo credential. If you are unsure, you are not using it.**

When you have set up a geteduroam server (instructions pending), you must create a CAT profile for your users.

#### Creating a geteduroam profile in CAT

You need an admin account on eduroam CAT for this

1. Go to https://cat.eduroam.org/admin/ and log in with your credentials
2. Select your institution
3. Create a new profile using the button on the bottom
4. In the redirect field, write the URL to your geteduroam instance, followed by #letswifi
   For example: `https://eduroam.no/#letswifi`

After this, it will take a while for the discovery database to update.
This can take up to 24 hours.


#### Creating a hybrid profile in CAT

NOTE: This is advanced and you probably don't need this!

If you want your users to be able to download the traditional CAT installers, but also provide geteduroam app users with an EAP-TLS configuration with generated certificate (regardless from what the profile normally provides), do this

1. Make a change to the profile, keep the redirect field empty
2. In the **Submitted attributes for this profile** screen, press **Continue to Installer Fine-Tuning and Download**
3. Under **EAP config**, press **Device-specific options...**
4. Press **Add new option**
5. Set **Redirection Target** to the URL to your geteduroam instance, followed by #letswifi
   For example: `https://eduroam.no/#letswifi`
