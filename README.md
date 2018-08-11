# Send Grid Integration for Preside

## Overview

This extension provides integration for [SendGrid](https://www.mailjet.com/) with Preside's email centre (Preside 10.8 and above).

Using this extension you can your mail's via SendGrid


## Installation

From the root of your application, type the following command (using [CommandBox](https://www.ortussolutions.com/products/commandbox)):

```
box install preside-ext-sendgrid
```

### Additional step for Preside 10.8 and below

If you are not already on Preside 10.9 or above, you'll need to enable the extension by opening up the Preside developer console and entering:

```

```


## Configuring the Service Provider

In the Preside admin interface, browse to Email centre -> Settings -> SendGrid (tab). From here, you will need to enter:

* Server: Get SMTP server address from SendGrid (smtp.sendgrid.net). 
* Port: Choose port number either 587 or 25,
* Secret Key: Your API key from SendGrid.

Once submitted and saved. Return to the Email centre -> Settings screen to configure SendGrid as your default provider.

## Configuring webhooks
As usual, you get up to date statistics in Preside, you should setup webooks in SendGrid to report back. To do so, navigate to [https://app.sendgrid.com/settings/mail_settings] and enable event notification and enter the following URL for all of the events except for the 'open' event (Preside has built in open tracking):

```
https://{your.domain.com}/sendgrid/hooks/
```

You can verify that it's working fine by checking goto Email Centre logs in Preside. You can see that you get delivery notifications before open notification and delete notification etc. Or If you Select which actions you would like reported back to your system. You can also test by sending to non-existent email addresses and seeing failure notifications come through in the logs in Preside.