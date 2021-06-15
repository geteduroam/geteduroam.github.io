---
title: "Frequently Asked Questions"
date: Tue  8 Sep 2020 21:11:23 CEST
weight: 220
---

#### The app asks me for a username/password, it doesn't use eduGAIN?

geteduroam uses CAT for the institution list, and profiles are downloaded directly from CAT, so eduGAIN is not involved in this case.  A profile in CAT can be marked as a geteduroam profile, then the user will be sent to a webpage where they have to log in.  This case may require eduGAIN, but it will typically go directly to the institutions SAML page.

There are plans to set up a hosted geteduroam solution within GÉANT, which will allow the use of eduGAIN.  This hosted solution cannot be used by institutions without NRO approval.


#### What happens with passwords entered in the app?

Passwords entered directly in the app are **only** used to configure a Wi-Fi profile in the application.  They are stored in the operating system to allow reconnecting to eduroam at a later time.  In most operating systems, the app will not be able to recover the password, so if a change is made to the profile the user must re-enter the password.


#### Where does the institution list in the app come from?

geteduroam uses CAT for the institution list, so users can use the geteduroam app no regardless whether the institution supports PEAP/TTLS or obtaining client certificates via OAuth


#### Which realm does geteduroam use?

There is no specific realm for geteduroam, since geteduroam is just another IdP solution with a RADIUS server.  If an institution self-hosts this RADIUS server, it will be the realm (subrealm?) of the institution.  If an NRO sets up geteduroam, it will be a realm picked by that NRO.

There are plans to set up a hosted geteduroam solution within GÉANT, which will have a common realm.  This hosted solution cannot be used by institutions without NRO approval.


#### Can any institution join without NRO approval?

geteduroam is open source and anyone can set up their own instance with RADIUS, in the same way anyone can set up any RADIUS server.  Inclusion in the eduroam fabric needs NRO approval, just like before.

There are plans to set up a hosted geteduroam solution within GÉANT.  This hosted solution cannot be used by institutions without NRO approval.


#### Will geteduroam replace CAT

**geteduroam is not intended to replace the Configuration Assistance Tool** that runs on cat.eduroam.org.  In fact, geteduroam uses CAT as the central database for EAP configurations to show the list of institutions when you start the app.  IdPs that only offer EAP-TLS must register in CAT in order to show up in the institution list in geteduroam.  geteduroam supplements CAT, it does not replace it.

The **geteduroam Android app** *is* intended to replace the **eduroamCAT Android app**.  The current eduroamCAT Android app is showing its age and it seems that development has stalled.  The geteduroam app will be a drop-in replacement, it can open eap-config files in the same way the eduroamCAT app does (in fact, **geteduroam uses eap-config for all platforms**)


#### How does the geteduroam app know of participating IdPs

geteduroam uses CAT for the institution list.  [A CAT profile can be marked as an geteduroam profile](/idp/cat) with a server URL, which then will cause the app to initiate a flow to obtain a client certificate instead of configuring a TTLS/PEAP profile.
