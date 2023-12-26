---
title: "Burp Suite"
date: 2023-12-26T11:17:52+01:00
# weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---
Documentation from PortSwigger.net:
<https://portswigger.net/burp/documentation/desktop>

## Installation
Download `sh` file, make it executable then run as normal user.

## Intercept HTTP traffic with Burp Proxy
Go to `Proxy` -> Intercept tab, turn on and open browser

Go to a website, in burp will see raw data. Click Forward serveral times to send to request

Click `Intercept is on` to turn off intercept and browser  normally.

On `HTTP history`, we can see all history of request and response even if intercept is turn off.

## Modifying HTTP request with Burp Proxy
Modify and forward

## Setting the target scope
Go to `Target` > `Site map`. Right click on the link and choose `Add to scope` then `Yes`.

Back to `HTTP hitory`, click on `Filter`, tick `Show only in-scope items`

## Reissue requests with Burp Repeater
In History, right click on a request and choose `Send to Repeater`.

Go to `Repeater`, we can send, modify request as many times as we want and see the responses.

We can send some unexpected inputs, they may response with some errors which leaks information, for example the framework `Apache Struts`, the version,...