---
layout: single
#classes: wide
title:  "Cryptography"
date:   2021-09-28 18:31:50 +0800
categories: cryptography
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## Summary

| Type     | acronym          | name                                                                                | desc                                                                                                                                                                |
| :------- | :--------------- | :---------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| language | asn              | Abstract Syntax Notation One (ASN.1)                                                | standard interface description language for defining data structures that can be serialized and deserialized in a cross-platform way                                |
| file     | csr              | certificate signing request                                                         | pkcs10; contains of subject, org, state, public key;to be signed                                                                                                    |
| standard | X509             | -                                                                                   | series of standards; "-----BEGIN-----" and "-----END-----"; format of public key certificates; structed; extensions include pem, cer, crt, der, p7b, p7c, p12, pfx  |
| standard | p7,pkcs7         | standard for signing or encrypting (officially called "enveloping") data; keystore; |
| syntax   | pem              | privacy enhanced mail                                                               | ***container*** format; base64; text; may include public cert; may include pub, pri, root ca, cert chain; can encode CSR(since openssl can translate pkcs10 to PEM) |
| standard | pkcs12, pfx, p12 |                                                                                     | password protected ***container*** format; contains both pub, pri;pem<->pkcs12                                                                                       |
| syntax   | der              | Distinguished Encoding Rules                                                        | binary container format of PEM; parent of PEM                                                                                                                       |
| file     | cert,cer,crt     |                                                                                     | certificate; pem format; extension only recognized by windows                                                                                                       |
| file     | p7b,keystore,jks |                                                                                     | pkcs7; for certificate exchange; p7b understand by Windows; keystore/jks understand by java; no private key                                                         |

### X.509

<https://stackoverflow.com/questions/38976885/difference-between-x-509-and-pem/38977354>

#### Certificate

-----BEGIN CERTIFICATE-----
MIIEITCCA+CgAwIBAgIUKMmxmDbjbHqt+Yzwj5lflBxuQwEwCQYHKoZIzjgEAzAjMSEwHwYDVQQD
ExhUb2tlbiBTaWduaW5nIFB1YmxpYyBLZXkwHhcNMTIxMTE2MTgzODMwWhcNMTIxMTIzMTgzODMw
WjAtMSswKQYDVQQDHiIAYgBiADEANAAxADkAYQAyAGMAZgBjADEAZQAwADAAOAAAMIGfMA0GCSqG
<...>
-----END CERTIFICATE-----

#### Certificate Revocation List

-----BEGIN X509 CRL-----
MIIDBjCCAm8CAQAwcTERMA8GA1UEAxMIcXV1eC5jb20xDzANBgNVBAsTBkJyYWlu
czEWMBQGA1UEChMNRGV2ZWxvcE1lbnRvcjERMA8GA1UEBxMIVG9ycmFuY2UxEzAR
BgNVBAgTCkNhbGlmb3JuaWExCzAJBgNVBAYTAlVTMIGfMA0GCSqGSIb3DQEBAQUA
<...>
-----END X509 CRL-----

#### Certificate Request

-----BEGIN NEW CERTIFICATE REQUEST-----
MIIDBjCCAm8CAQAwcTERMA8GA1UEAxMIcXV1eC5jb20xDzANBgNVBAsTBkJyYWlu
czEWMBQGA1UEChMNRGV2ZWxvcE1lbnRvcjERMA8GA1UEBxMIVG9ycmFuY2UxEzAR
BgNVBAgTCkNhbGlmb3JuaWExCzAJBgNVBAYTAlVTMIGfMA0GCSqGSIb3DQEBAQUA
<...>
-----END NEW CERTIFICATE REQUEST-----

#### PKCS#1 private key

-----BEGIN RSA PRIVATE KEY-----
MIIDBjCCAm8CAQAwcTERMA8GA1UEAxMIcXV1eC5jb20xDzANBgNVBAsTBkJyYWlu
czEWMBQGA1UEChMNRGV2ZWxvcE1lbnRvcjERMA8GA1UEBxMIVG9ycmFuY2UxEzAR
BgNVBAgTCkNhbGlmb3JuaWExCzAJBgNVBAYTAlVTMIGfMA0GCSqGSIb3DQEBAQUA
<...>
-----END RSA PRIVATE KEY-----

#### PKCS#8 private key

-----BEGIN PRIVATE KEY-----
MIIDBjCCAm8CAQAwcTERMA8GA1UEAxMIcXV1eC5jb20xDzANBgNVBAsTBkJyYWlu
czEWMBQGA1UEChMNRGV2ZWxvcE1lbnRvcjERMA8GA1UEBxMIVG9ycmFuY2UxEzAR
BgNVBAgTCkNhbGlmb3JuaWExCzAJBgNVBAYTAlVTMIGfMA0GCSqGSIb3DQEBAQUA
<...>
-----END PRIVATE KEY-----
