---
layout: single
# classes: wide
title:  "CSHL"
date:   2021-08-30 11:05:50 +0800
categories: cshl
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---
# Staging

## Signing

### Keystore

* run command below

```cmd
keytool -genkeypair -alias signing.hc-stg.careshieldlife.gov.sg -keyalg EC -keysize 256 -sigalg SHA256withECDSA -validity 3650 -storetype JKS -keystore signing.hc-stg-careshieldlife.jks -storepass 3cG@yPXp  

What is your first and last name?
  [Unknown]:  signing.hc-stg.careshieldlife.gov.sg
What is the name of your organizational unit?
  [Unknown]:  HCD
What is the name of your organization?
  [Unknown]:  CPFB
What is the name of your City or Locality?
  [Unknown]:  SG
What is the name of your State or Province?
  [Unknown]:  SG
What is the two-letter country code for this unit?
  [Unknown]:  SG
Is CN=oidc.hc-dev.careshieldlife.gov.sg, OU=HCD, O=CPFB, L=Singapore, ST=Singapore, C=SG correct?
  [no]:  yes
Enter key password for <signing.hc-stg.careshieldlife.gov.sg>
        (RETURN if same as keystore password): <RETURN>

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore signing.hc-stg-careshieldlife.jks -destkeystore signing.hc-stg-careshieldlife.jks -deststoretype pkcs12".
```

### Certificate

* run command below

```cmd
keytool -certreq -keyalg EC -alias signing.hc-stg.careshieldlife.gov.sg -file signing.hc-stg.careshieldlife.gov.sg-certreq.txt -keystore signing.hc-stg-careshieldlife.jks 

Enter keystore password: 3cG@yPXp<RETURN> 
```

## Encryption

### Keystore

* run command below

```cmd
keytool -genkeypair -alias encryption.hc-stg.careshieldlife.gov.sg -keyalg EC -keysize 256 -sigalg SHA256withECDSA -validity 3650 -storetype JKS -keystore encryption.hc-stg-careshieldlife.jks -storepass 3cG@yPXp 

What is your first and last name?
  [Unknown]:  encryption.hc-sit.careshieldlife.gov.sg
What is the name of your organizational unit?
  [Unknown]:  HCD
What is the name of your organization?
  [Unknown]:  CPFB
What is the name of your City or Locality?
  [Unknown]:  SG
What is the name of your State or Province?
  [Unknown]:  SG
What is the two-letter country code for this unit?
  [Unknown]:  SG
Is CN=oidc.hc-dev.careshieldlife.gov.sg, OU=HCD, O=CPFB, L=Singapore, ST=Singapore, C=SG correct?
  [no]:  yes
Enter key password for <signing.hc-stg.careshieldlife.gov.sg>
        (RETURN if same as keystore password): <RETURN>

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore signing.hc-stg-careshieldlife.jks -destkeystore signing.hc-stg-careshieldlife.jks -deststoretype pkcs12".
```

### Certificate

* run command below

```cmd
keytool -certreq -keyalg EC -alias encryption.hc-stg.careshieldlife.gov.sg -file encryption.hc-stg.careshieldlife.gov.sg-certreq.txt -keystore encryption.hc-stg-careshieldlife.jks 

Enter keystore password: 3cG@yPXp<RETURN>
```
