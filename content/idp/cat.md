---
title: "Pseudo-credential and CAT"
weight: 410
---

# Pseudo-credential and CAT

{{% hint warning %}}
⚠️ **This is ONLY needed if you use the pseudo credential.  
If you are unsure, you are not using it.**
{{% /hint %}}

When you have set up a geteduroam server (instructions pending), you must create a CAT profile for your users.


## Creating a geteduroam profile in CAT

{{% hint info %}}
🛂 You need an admin account on eduroam CAT for this
{{% /hint %}}

1. Go to https://cat.eduroam.org/admin/ and log in with your credentials
2. Select your institution
3. Create a new profile using the button on the bottom
4. In the redirect field, write the URL to your geteduroam instance, followed by #letswifi
   For example: `https://eduroam.no/#letswifi`

After this, it will take a while for the discovery database to update.
The change will typically be picked up **after 15 minutes**, but the apps might cache the database for up to an hour, so **it will take about 1,5 hours** before the change will be visible to everyone.
