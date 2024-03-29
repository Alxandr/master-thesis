# Accessing the LMS Outside the Safe Environment
While being able to modify the code being run inside the safe environment does
enable us to do quite a bit already, the fact that we're running in a safe
environment puts a lot of restrictions on what we can do on the local machine.
Safe Exam Browser (with the settings provided by Inspera Assessment) prevents
you from starting programs, opening local files, using your computer for solving
math (and other things the computer are quite good at), etc. If we could instead
run the exam without having to bother with Safe Exam Browser at all, that would
make things much easier. We could simply minimize the window when we wanted to
do other things, and have open separate tabs for other websites, such as Google,
Wikipedia and Wolfram Alpha.

In order to achieve this however, we need to trick Inspera Assessment into
believing that we are using Safe Exam Browser when we in fact are using another
browser altogether. There are a few ways we could go about doing this, one of
which is to write a browser extension that would modify our requests before they
are sent to Inspera Assessment so as to mimic Safe Exam Browser. Another option
would be to do some simple modifications to the reverse proxy server I used in
[@sec:rev-proxy]. Since most of the work were already complete for option two I
opted for that.

## Identifying Safe Exam Browser {#sec:seb-id}
In order to trick Inspera Assessment into believing we're using Safe Exam
Browser when we're not, first we need to figure out what it uses to identify
Safe Exam Browser in the first place. My contact at Inspera Assessment told me
that in addition to the `x-safeexambrowser-requesthash` header which is used by
any LMS with support for Safe Exam Browser they also validate the user agent
string. Figuring out the user agent is straightforward, I just need to run my
reverse proxy server and log it, then start an exam. The request hash is a lot
more tricky, because it is generated for each request, and is different for each
request. Therefore, I couldn't just look at the log output from my reverse proxy
server and replicate it, I needed to figure out how it was validated.

While Inspera Assessment is a closed source program, another LMS with support
for Moodle [@Moodle] is an open source alternative with support for Safe Exam
Browser. The module they use to validate requests from Safe Exam Browser is also
open source. From looking at the source code for Moodle I found that a request
from Safe Exam Browser is validated by taking a secret key (generated by Safe
Exam Browser and configured in the LMS) and append it to the current request
URL, and then run the resulting concatenated string through `sha256`.

Given that my requests are going to pass though a reverse proxy server, I
already know the URL, and `sha256` is a standard cryptographic function that
is available in most programming languages and environments, the problem is
figuring out the secret key that Safe Exam Browser generates.

## Browser Exam Key
Figuring out the browser exam key (as it is called by Safe Exam Browser) is the
harder part of forging requests to make it look like they were made using Safe
Exam Browser. It is also the entirety of Safe Exam Browsers security model with
regards to preventing people from using other browsers at exams. If the Browser
Exam Key could easily be forged, then effectively Safe Exam Browser is just an
optional browser when taking digital exams. Therefore, the generation of the
Browser Exam Key is rather complicated. It changes if you modify SEB, and it
changes if you modify the config file, and it's different on Windows and macOS,
so it's not trivial to compute. However, given the fact that the secret needs to
be inserted into the LMS for the LMS to be able to validate a request from Safe
Exam Browser that indicates that at some point the secure secret has to have
been made available for humans to use. Otherwise, how would you get the secret
into your LMS?

![Browser Exam Key computed and ready for copy from Safe Exam Browser config editor.](src/chapter-3/seb-key){#fig:seb-key}

As it turns out, if you open the Safe Exam Browser config editor tool it will
happily just give you the only secret all of its security hinges on. See
[@fig:seb-key] for example of how the config tool presents the Browser Exam Key
to any user who knows how to use it. Not only do you get the secret here, you
also get the user agent string (if you didn't grab that using a network logging
tool), plus all of the settings used for this exam, like which website to go to
start the exam etc. To Safe Exam Browsers' credit, the config file is rather
heavily encrypted, and you need to enter the encryption password to be able to
open the config file in the config editor, but at the same time the encryption
password is handed out when the exam starts because you need the password in
order to start the exam. That means you have a short while (depending on where
you sit) to open the config editor, grab the Browser Exam Key, start the reverse
proxy server, and then start the exam in another browser in fullscreen.

## Brute Force the Password {#sec:brute-force}
Being able to get the Browser Exam Key from Safe Exam Browser itself is nice and
all, but the fact that we have to wait for the password to be published makes it
less than optimal. If we could get the Browser Exam Key a bit earlier, that
would mean we could set up our computers before the invigilators start doing
their rounds, and everything would be ready to go. Yet, as said, Safe Exam
Browser uses an encryption that is effectively unbreakable. On my somewhat old
laptop I managed to get about 800 key checks per second. If we use alphanumeric
passwords of 6 character lengths that would mean it would take me on average a
bit over 2 weeks. Considering most exams last about 4 hours that would not be
any help at all.

Luckily, the passwords used by Inspera Assessment isn't alphanumeric, nor are
they 6 characters long. Instead they are just numeric pins with 4 digits. This
reduces the keyspace enormously, allowing me to search through all possible
answers on my old laptop in roughly 12-15 minutes. This could easily be
accomplished before the exam starts. I also tested the program on a faster
laptop with more cores, where the entire process completed in less than 3
minutes. This means that you could very easily show up 15 minutes before the
exam starts (just as you normally would anyway), decrypt the config file, and
setup either a proxy server (like I've done) or a browser extension (if one was
ever made) with the correct Browser Exam Key. Then you could start the exam in
Chrome in fullscreen, and nobody looking at your screen would be the wiser.

## Applying Outside BYOD
For the most part, using the exploits described here requires the same access
as described in [@sec:seb-outside-byod]. It also requires a different browser
than Safe Exam Browser to be available on the client. In the case where clients
are regular remote desktop thin clients this is not much of a problem, but if
the clients have been specifically designed with exams in mind, and they only
run the examination software then doing the above would likely prove difficult.
However, creating such clients would require a large amount of infrastructure to
be in place.
