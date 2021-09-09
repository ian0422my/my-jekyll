---
layout: single
#classes: wide
title:  "Unit Testing"
date:   2021-09-06 10:25:50 +0800
categories: unit testing
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## Purpose

* code quality
  * to make sure expected result for expected input
* is not meant for integration testing
* not meant to catch bug
* good unit testing design will be a good KT to colleague

## Concept

* to test ***all possible variation of external input*** factors and make sure all are handled with ***expected result*** (i.e. to cover all possible scenarios)
  * Summary
    * as long as the output is different when input is different, it should be tested (so that the output is expected)
  * input
    * should cover
      * input parameters to the method
    * should not cover (external factors; these should be cover under SIT)
      * resources/files being used by the method
      * api called by the method
        * this should be cover by SIT
    * test case should cover positive/negative scenario of the input paraemters
  * expected output
* test case
  * name should be as clear as possible. E.g. test(method name)_(input parameters scenario)_(expected output)
    * E.g.
      * testGetWeather_googleweatherdown_shouldbenoresult
  * number of test case ideally should be X * Y
    * where
      * X - method to test
      * Y - number of input parameters scenario

### Best Practices

* ***Test only one code unit at a time***
  * if method got 2 input parameter, you should atleast have 4 test case - 00,01,10,11
* Don’t make unnecessary assertions
* what to mock?
  * ***mock reference class***
  * ***Don't mock test case*** 
    * it defeat the purpose since the results is mocked.
* Mock out all external services and state
* Don’t unit-test configuration settings
* ***Name your unit tests clearly and consistently***
  * although eclipse help you to create default test method for all your test case, doesn't mean you cannot create your own class
* Write tests for methods that have the fewest dependencies first, and work your way up
  * simple first; complex later
* ***All methods, regardless of visibility, should have appropriate unit tests***
  * although is not so straight forward to test private method
* ***Aim for each unit test method to perform exactly one assertion***
* Create unit tests that target exceptions
* Use the most appropriate assertion methods
* Put assertion parameters in the proper order
* ***Ensure that test code is separated from production code***
* ***Do not print anything out in unit tests***
* Do not use static members in a test class. If you have used then re-initialize for each test case
* Do not write your own catch blocks that exist only to fail a test
* Do not skip unit tests

#### Reference

<https://howtodoinjava.com/best-practices/unit-testing-best-practices-junit-reference-guide/#not-find-bugs>

### How?

* automatically create junit from class (select class > CTRL+1)
  * select all methods and create test method for it
* mockito and junit version matters
* how to run junit faster in eclipse, add -noverify i eclipse.ini and restart eclipse

## Mocking

### mock response of a class method (e.g. getSingPassLoginUrl())

```java
class SingPassOIDCServiceImplTest {
  public SlingContextImpl context = null;
  private SingPassOIDCServiceImpl singPassOIDCServiceImplTest = null;
...
void setUp() throws Exception {
  this.context = new SlingContextImpl();
}
@BeforeEach
void setUp() throws Exception {
  this.singPassOIDCServiceImplTest = new SingPassOIDCServiceImpl();
  this.context = new SlingContextImpl();
  this.parameters = new HashMap<>();
  parameters.put("getSingPassLoginUrl", "testSINGPASS_LOGIN_URL");
  context.registerInjectActivateService(singPassOIDCServiceImplTest, parameters);
}
@Test
public void testGetSingPassLoginUrl() {
  //before
  final String expectedResult = "testSINGPASS_LOGIN_URL";
  // when
  final String result = singPassServiceImplUnderTest.getSingPassLoginUrl();
  // then
  assertEquals(expectedResult, result);
}
```

### mock response for non-static class

```java
  private PortalRestControllerService portalRestControllerService = mock(PortalRestControllerService.class);
  context.registerService(PortalRestControllerService.class, portalRestControllerService);
  ...
  PowerMockito.when(portalRestControllerService.doGet(SingPassOIDCServiceImpl.OPENID_DISCOVERY_URL, null)).thenReturn(null);
  String res = portalRestControllerService.doGet(SingPassOIDCServiceImpl.OPENID_DISCOVERY_URL, null);
  
  Assertions.assertNull(res);
```

### mock response for static class

```java
  PowerMockito.mockStatic(CommonGuavaCacheUtil.class);
  PowerMockito.when(CommonGuavaCacheUtil.get(SingPassOIDCConstants.OPENID_DISCOVERY_INFO)).thenReturn((String)singPassOIDCOpenDiscoveryJSON);
```

### mock a void method

```java
// non-static 
Mockito.doNothing().when(httpSession).putValue(Mockito.anyString(), Mockito.anyString());
// Mockito.doNothing().when(CLAZZ).<void method>;

// static
PowerMockito.doNothing().when(SessionUtil.class, "regenerateSessionId", request);//78
// PowerMockito.doNothing().when(STATIC CLAZZ, method name, input parameters....)
```

### mock private method

* generally you can't, but you can verify if a private method is invokes

```java
PowerMockito.verifyPrivate(singPassOIDCOpenIDDiscoverySchedulerTest).invoke("addScheduler", config)
// PowerMockito.verifyPrivate(clazz).invoke("<private method name>", prameters....);
```

## Injection

* you don't need to inject static method (i.e. mockStatic(class))

### inject mock service into class (or set field value)

```java
  userService = mock(UserService.class);
  PowerMockito.when(userService.getInternal_500_Url()).thenReturn("/errors/internal-server-error.html");
  context.registerService(UserService.class, userService);
  
  Whitebox.setInternalState(singPassJWKSServletTest, "userService", userService);
```

### create mock osgi and activate it

* this is used when you can't inject value into private field of a service (e.g. config). then you have to create the service (new(), cannot mock(...)) and register/activate it

```java
SingPassOIDCServiceImpl singPassOIDCServiceImplTest = new SingPassOIDCServiceImpl();
Map parameters = new HashMap();
parameters.put("enableSingPassLogin", true); // private String ENABLE_SP_LOGIN = config.enableSingPassLogin() -- ENABLE_SP_LOGIN cannot be mock
context.registerInjectActivateService(singPassOIDCServiceImplTest, parameters);
```

## Assertion

### Test a void method (Mockito.verify)

* only way is to confirm that method is invoked at least once by using Mockito.verify

```java
  // mock a class
  SingPassOIDCServiceImpl singPassOIDCServiceImplTest = mock(SingPassOIDCServiceImpl.class);
  // tell moc
  // Mockito.doNothing().when(singPassOIDCServiceImplTest).retrieveOpenIdDiscoveryInfo();
  // invoke method
  singPassOIDCServiceImplTest.retrieveOpenIdDiscoveryInfo();//
   // ask mockito to verify that method is called at least 1 time
  Mockito.verify(singPassOIDCServiceImplTest, Mockito.times(1)).retrieveOpenIdDiscoveryInfo();
```

### Assert exception (Junit)

```java
Assertions.assertThrows(Exception.class, ()->singPassOIDCServiceImplTest.retrieveOpenIdDiscoveryInfo());
```

### Verify (Mockito.verify)

```java
  MockSlingHttpServletRequest request = mock(MockSlingHttpServletRequest.class);
  MockSlingHttpServletResponse response = mock(MockSlingHttpServletResponse.class);
  
  singPassJWKSServletTest.doGet(request, response);
  
  // verify the senddirect is correct
  Mockito.verify(response).sendRedirect(INTERNAL_SERVER_ERROR_URL);
```

## TLDR; 

* Mockito
  * verify(class)
    * make sure method is called
  * verify(class, Mockito.times(N))
    * make sure atleast called N times
    * times == VerificationMode
      * Mockito.times(N)
      * Mockito.atMost(N)
      * Mockito.atLeast(N)
      * Mockito.atLeastOnce()
      * Mockito.atMostOnce()
  * verifyNoMoreInteractions(class)
    * make sure method is not called
  * verify(mockedList).add(anyString());
    * verify method called with any argument
  * mock - mock a class
