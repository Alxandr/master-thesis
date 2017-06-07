# Modifying Safe Exam Browser
Having looked at how the Browser Exam Key is used to identify Safe Exam Browser,
I wanted to look at how it was generated, to see if I could sidestep Safe Exam
Browser and not need to use its configuration tool. Since Safe Exam Browser is
open source, the code is openly available for anyone to read and make changes
to. However, the idea is that if you make changes to Safe Exam Browser, it will
generate a different Browser Exam Key which would result in the LMS not
validating the request. As we've seen in [@sec:seb-id], the request hash is
generated per request composed of the URL of the request (which is known), the
`sha256` function (also known), and the Browser Exam Key which is the presumably
secure part of the equation.

## Generating the Browser Exam Key
Figuring out how the Browser Exam Key is generated is actually quite simple. The
windows version of Safe Exam Browser is written in C#, which is one of my main
programming languages, and is decently written, so tracking down where the
Browser Exam Key was generated was not hard at all. The relevant parts is the
methods named `ComputeBrowserExamKey` and `ComputeSEBComponentsHash` in the
`SEBProtectionController` class. The `ComputeBrowserExamKey` method takes the
config file content and concatenates it with a hash of all the "SEB Components"
(acquired by calling `ComputeSEBComponentsHash`). It then runs the resulting
string through a `HMAC` algorithm using `SHA256` as the hashing function.

Cryptographically this is as I understand very safe. Considering the
cryptographic functions in use are all considered safe. The only thing that
could potentially be a problem with the cryptography itself is how they are used
together, however you'd need an expert in cryptography to figure that out.
Regardless of whether or not there exist any exploits usable against the
encryption however, does not really matter, because there are no secrets
involved in computing the Browser Exam Key. All of the information above is
information that we either know or can figure out. The config file is inherently
available because we're working on modifying Safe Exam Browser itself, and it
obviously already deals with the decrypting of the config file so we don't have
to do that on our own. The only thing that's supposed to prevent us from
modifying Safe Exam Browser and still be able to use it as if it wasn't modified
is the `ComputeSEBComponentsHash` method.

## Safe Exam Browser Components
So, what does the `ComputeSEBComponentsHash`method do? Quite simply, it uses the
current running application to figure out where it is executing from (where Safe
Exam Browser is installed), then it finds a bunch of files that are part of Safe
Exam Browser itself and computes a hash of all these files. In general, the idea
is fairly straight forward. If you modify any of the files required to run Safe
Exam Browser, you will get a different hash value. However, getting around this
security constraint is incredibly simple. Considering the fact that the
`ComputeSEBComponentsHash` is constant (it will always return the same thing as
long as you're running the same version of Safe Exam Browser), if you could
figure this value out once you could simply replace the
`ComputeSEBComponentsHash` method with a method that returns the expected
string. This still leaves you with the issue of figuring out what the result of
this method is, and I'll get back to that later.

Another way you can easily make `ComputeSEBComponentsHash` return the correct
hash even when you're using a modified version of Safe Exam Browser is simply by
replacing the line that gets the current running application directory with a
path to an installed correct version of Safe Exam Browser. This is the route I
used to make my own version of Safe Exam Browser generate the correct Browser
Exam Key.

## Disabling Security in Safe Exam Browser
Looking further into Safe Exam Browser, most of the configuration keys are
available at the `SEBSettings` class. Examples such as `KeyEnableAltTab` and
`KeyEnablePrintScreen` corresponds to settings that can be toggled on and off.
Doing a quick search through the codebase for where the different keys are used,
it's easy to disable almost all security provided by Safe Exam Browser. With
only a few lines of code changed I was able to run a custom Safe Exam Browser
that connected to the exam as if it was the original Safe Exam Browser while
allowing me to alt-tab to other windows while I was doing the exam, and copy
text in and out of Safe Exam Browser.

## Linking Against Safe Exam Browser
Given that Safe Exam Browser for Windows is written as a .NET application in C#,
I wanted to see if I could write another application that linked directly
against the installed Safe Exam Browser, and it turns out it's perfectly doable.
This is what allowed me to write my brute force program in [@sec:brute-force].
Simply open up Visual Studio, create a new C# project, and add the installed
Safe Exam Browser as a dependency of your project. You can then call public
methods in Safe Exam Browser (like `ComputeBrowserExamKey`), or using reflection
you could also call private methods (like `ComputeSEBComponentsHash`).

## Applying Outside BYOD {#sec:seb-outside-byod}
Depending on the client used by the university to perform exams, the exploits
relating to modifying SEB or creating programs that extract information out of
the SEB config file is likely to still be usable. The application I wrote to
brute force the config file (see [@sec:brute-force]) does not require
installing, nor administrator privileges to run. However, it does require that
you have access to a Windows desktop environment and are able to run arbitrary
applications (prior to exam start).
