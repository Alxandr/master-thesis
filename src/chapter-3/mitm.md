# Injecting code into the safe environment
One of the ways to cheat at a digital exam in which a safe environment is
prohibiting you from accessing your files and the internet, is to modify the
code running inside the safe environment itself. Instead of trying to break out
of the safe environment or access the exam without using the safe environment,
we try to trick the safe environment into believing code we wrote is actually
part of what was intended to be executed as part of the examination. If we are
successful in doing so, it would effectively render the safe environment useless
as we would be able to access any resource available on the internet. Depending
on how this code injection is done it would also be possible to get access to
local resources.

## Man in the Middle attack
One of the unique things about a browser (and working with the internet in
general) is the fact that the browser executes code written by strangers sent to
us over a wire we have little to no control over. Traditionally, software came
with the computer, delivered by a company that you trusted and handed over as a
physical object (in the form of a cd or floppy disk, or as part of the computer
itself). In order to breach that software and get your computer to execute code
that you did not intend for it to execute, you would either have to get physical
access to your computer, the shop where you bought your software, or the
physical device used to transmit the software itself.

After we started using the internet for distribution of software, a lot more
points of failure was introduced. What happens when you download a program from
a website like `example.com` is (simplified) the following steps:

1. Your computer makes a DNS request for the domain name `example.com`.
2. Your computer gets a response with the IP address for `example.com`.
3. Your computer attempts to open a connection to the IP returned by the DNS
   request.
4. The server which your computer believes to be `example.com` answers the
   request.
5. Your computer receives the file requested.

All of the steps above can be intercepted. For traditional software you download
this has bad implications, because it can cause you to download virus software
thinking it was something else. However, binary applications you download can
generally mitigate this problem by also giving out a checksum of the software
itself (it does require some manual work on the part of the user to verify it
though). On the other hand, websites is another form of software, transfered as
text, and executed by the browser without any regard for whether or not it may
be what the user intended. This means that if we can get the browser to believe
that the answer to the request sent to `example.com` is something we made up (
instead of what actually is the answer from the `example.com` server) we can get
the browser to do more or less whatever we want it to. This means that even if
we are using Safe Exam Browser (which is still a browser), and it prevents us
from accessing files and folders we have on our computer, and also prevents us
from accessing the internet at large, by intercepting the request Safe Exam
Browser makes to Inspera Assessment we can get it to do our bidding, instead
of what it was intended to do.

Normally this attack is something that would be called as a Man in the Middle
attack and is a well known attack vector against users who try to access
websites. The reason it is called Man in the Middle attack is that it would
typically be performed by someone who has access to hardware that is between you
and the server you are trying to access. See [@fig:mitm] for example. For
instance, in the request above to `example.com`, if the attacker had access to
our router, he could instruct the router to reply to the DNS request for
`example.com` with a IP address that he controls. Our browser would then happily
connect to that IP address thinking it's connecting to `example.com` and take
whatever it got sent it's way as what the user wanted to execute. Alternatively
instead of modifying the DNS reply, he could listen for requests to the IP
address that is `example.com`, and hijack the requests by not transmitting them
to their final destination, instead replying with his own reply. Especially
tricky is the fact that the attacker in this case knows the request you made to
`example.com`, including any session data or username and passwords you sent
with the request, meaning he could send the same request to `example.com`, get
back the correct response, modify the response and then send it back to you. In
this case you would likely have little to no clue of the fact that you did not
get what you asked for, because for all intents and purposes you did. You just
got a little something extra as a bonus, normally not visible to you at all.

![An illustration of a typical man in the middle attack. Made by Wikimedia Commons user Miraceti [@Miraceti].](fig/chapter-3/Man_in_the_middle_attack){#fig:mitm}

However, this technique is well documented. It's existed for years, and the
solution to prevent Man in the Middle attacks is fairly simple. We use HTTPS.
The solution here is two-fold. The first part is simple encryption. By using
public key cryptography we are able to encrypt our requests in such a way that
an attacker is not able to see what we are requesting, they can also not see the
response. And although they would be able to modify both the request and the
response, since both are encrypted, any modification would result in the request
being invalid. If a weak encryption is used, it might still be able to modify
the requests and responses, but most certificate providers nowdays recommend a
key length of at least 2048 bits RSA encryption. This means that in practice,
tampering with requests is not doable.

However, just encryption is not good enough. It would still be easily doable
for an attacker to respond with an IP address he controls to the DNS query for
`example.com`. In such a case, if we only had encryption, our browser would
connect to the server controlled by the attacker instead of the one we intended
to connect to, and the result would be just as bad. However, HTTPS also provides
a mechanism to ensure that the server you are connected to is actually the one
you intended to connect to, which is achieved through certificate chains. When
you connect to `example.com` over HTTPS, your browser request from the server
proof that it is actually `example.com` (and not somebody else). The way this
works is that the owner of `example.com` is issued a certificate, proving that
he indeed does own `example.com`. This certificate is then installed on the
server(s) that host `example.com`, so that they can prove that they are indeed
responsible for hosting `example.com`. And the way that your browser knows to
trust the certificate is because it has been signed by another certificate,
which has been signed by another certificate all the way down to what is known
as a root certificate, and that root certificate is installed on your computer.
That is to say, in order for the attacker to hijack requests for `example.com`,
he must both manage to give custom replies to DNS queries, and at the same time
he must get someone who is trusted by the owner of a root certificate on your
computer (or the owner of the root certificate itself) to validate the fact that
he owns `example.com` (even though he doesn't). These things put together makes
Man in the Middle attacks generally unfeasible as long as websites are using the
secure HTTPS protocol.

## Creating your own certificate authority
As explained above, HTTPS is generally considered safe against man in the middle
attack because strong encryption and a trusted certificate chain ensures that
when Safe Exam Browser connects to Inspera Assessment, it is indeed Inspera
Assessment that replies. If this is not the case, Safe Exam Browser will throw
an error message (which incidentally will freeze up your computer without the
ability to exit safe exam browser or shut down normally). However, while that is
normally the case, the security measures made to prevent Man in the Middle
attacks were intended to stop people who have access to networking hardware
between you and the server you're trying to access from being able to read and
modify your requests and responses. They were however, not intended to prevent
people who have physical access to your computer from so doing, and most
certainly they were not indented to prevent you from attacking yourself.

The thing to remember is that while normally you would have an attacker trying
to get access to data or trick you into running code you don't want to, in this
case we do want to run our custom code, therefore there should normally be no
good reason for our computer to prevent us from so doing. Except that in this
case we are running an exam using Safe Exam Browser, and running our custom code
would be cheating. But still, these security measures have not been designed to
prevent us from modifying or monitoring requests on our own machine, in fact
there is software written to enable just this. It turns out that being able to
inspect network requests while developing things that sends network requests is
quite useful. However, if those network requests are encrypted it would lose
it's usability. The way to get around this is to create our own server with it's
own certificate signed by our own certificate authority, and then use that as a
proxy server for whatever secure resource we are attempting to access. All we
then have to do is to install the certificate authority certificate (often
called a root certificate) on our computer and we are all set.

The reason this works is that when we create and install a root certificate
authority (henceforth known as `Cheat CA`), and use it to sign our own
certificate for `example.com` (or any other website), when the browser connects
to our proxy web-server and asks for proof that it is indeed `example.com`, the
server responds with the certificate signed by `Cheat CA`. The browser then
checks who signed it, and looks for the signer in the installed certificates,
however since we installed `Cheat CA` on the computer previously the browser
concludes that the certificate can be trusted (because we explicitly told it
we trust `Cheat CA` by installing it, and by extension we trust anything that
`Cheat CA` trust, ie. signs).

## Reverse code-injecting proxy {#sec:rev-proxy}
Once we have our own certificate authority up and running, setting up a reverse
proxy server is pretty straight forward. And as explained earlier, one of the
security implications of the fact that we are running our exam in a browser is
the fact that we can just add code to the response as text, and the browser will
happily execute it. In theory, I should be able to modify my hostfile (modifying
my own DNS responses), and make `inspera.no` point to the loopback address
`127.0.0.1`, while running a simple reverse proxy server I wrote in `node.js`.
Starting the exam with this configured should result in me being able to access
the exam like normal, while injecting code into the exam website allowing me
access to resources I should normally not have access to. See figure
[@fig:rev-proxy] for sample output from this reverse proxy server being set up
against `demo.inspera.no` simply browsing the web-page in Chrome.

![Sample output from a reverse proxy server with logging enabled. Shows requests and response headers and status codes.](src/chapter-3/server){#fig:rev-proxy}

Modifying the requests going back and forth between Safe Exam Browser and
Inspera Assessment should allow me to do more or less anything you would be able
to do using either a browser or a console application running on your computer,
which is basically anything. I could write the server in such a way that when
I click a link on the exam website my computer shuts down for instance. Although
doing so serves no practical purpose, it illustrates the fact that I'm able to
do things to the computer that Safe Exam Browser is attempting to prevent me
from doing. Another thing I could do is have it so that when I click a button,
the content of a file on my harddrive is written into whatever input field is
currently in focus, thus giving me access to local notes on my computer. More
worryingly is the fact that I could write scripts that allow me to navigate to
any website inside safe exam browser. This basically means that all bets are off
with regards to keeping the exam environment "safe", and that I can do anything
from searching for answers on Google, communicate with outsiders that could help
me on the exam, collaborate with other exam takers, etc. Effectively I have the
world at my fingertips, and while Safe Exam Browser is still preventing me from
closing down my browser window to use other programs, I have complete control of
what happens inside said browser window.

## Testing
My initial test of using a reverse code-injecting proxy to take an exam using
Safe Exam Browser did not work out as expected. I made several tests using
different implementations of the reverse proxy server and using different
certificates and certificate management software. But, no matter what I did I
could not get Safe Exam Browser to work with my certificate, self-signed or not.
Instead what would happen was that when I attempted to start the exam, I would
get an error message telling me that a certificate error had been encountered,
and at that point I was stuck. Safe Exam Browser does not help you at all in
cases where something goes wrong, instead it just leaves a blank window that
you're not able to close. Without having the reset code available (which you
typically wouldn't) the only way to get out of this state is to forcefully
reboot the machine by holding down the power button. This made testing annoying
and time consuming because any tiny change I did required a full reboot of the
computer.

After having attempted several ways of getting Safe Exam Browser to accept my
custom certificate I eventually tried to use the network monitoring tool fiddler
[@Telerik]. I already knew fiddler to be working, because I've used it many
times when debugging websites, and I wanted to look at the data produced by
Safe Exam Browser and the data produced by my reverse proxy and try to figure
out what was different, however to my great surprise, I got the exact same error
using fiddler. This lead me to the conclusion that Safe Exam Browser was not
using the global store of certificates, but instead had it's own. This is also
the reason why Firefox (which is traditionally based on XULRunner) needs to be
specially configured for using Fiddler [@Telerika]. However, since I can't
really configure XULRunner without modifying Safe Exam Browser, and modifying
Safe Exam Browser would defeat the purpose of the reverse proxy server
alltogether, therefore the conclusion is that using a reverse proxy server for
injecting code into Safe Exam Browser **if** the exam system runs over HTTPS on
Windows is not possible. At least not easily possible. Fore more info on how it
can possibly be done without changes to Safe Exam Browser see
[@sec:late-changes].

Safe Exam Browser on OSX however, does not use XULRunner (even though XULRunner
runs on all platforms). Instead, it uses a browser component based on the WebKit
browser engine. In difference to the XULRunner browser engine used by Safe Exam
Browser on Windows however, it does not have it own root certificate store. It
instead (like most browsers) uses the operating system for dealing with what
certificates to trust. This means that while it is not possible to use the
reverse proxy server I wrote to modify requests and responses made by Safe Exam
Browser on Windows, the same server does work on OSX.

## Modifying the LMS {#sec:modifying-lms}
While being able to set up a reverse proxy server that you can use to inspect
traffic going from Safe Exam Browser to Inspera Assessment servers and back is
certainly helpful when doing other exploits, it is not really an exploit in and
of itself. Only by modifying the responses coming from the LMS or by crafting
custom requests going there are we able to gain access to restricted resources.
If the LMS system has any security exploits like the client deciding whether or
not an answer to a question is correct this would enable us to forge requests
going to the LMS just telling the LMS that we answered all the questions
correctly. This however is not the case with Inspera Assessment. Instead, from
the data I've seen going between Safe Exam Browser and Inspera Assessment for
demo exams that were set up so I could do this testing it seems that they simply
store the answers to the questions, and figuring out whether or not they are
correct is either done on the server, or at a later time by a human.

![Accessing Wikipedia inside Inspera Assessment running in Safe Exam Browser.](src/chapter-3/wiki){#fig:wikipedia}

Instead, what I can do is modify the responses coming back from Inspera
Assessment before it reaches Safe Exam Browser. This enables me to do all kinds
of things that I would not normally be able to do during the exam, like
accessing Wikipedia (see [@fig:wikipedia]). More interestingly though is the
fact that since you're running your code inside Inspera Assessment it becomes
possible to make it look like whatever you're accessing is actually part of
Inspera Assessment and not an external resource.

![Creating a Bing button inside the Inspera Assessment to make it look like it's part of the exam.](src/chapter-3/search){#fig:search}

[@fig:search] shows a quick mockup of putting Bing search capability inside the
exam software. Obviously this does not do a good job of masking the fact that
you're using resources you should not be, because Bing with it's glaring colors
stands out like a sore thumb, but the fact that I can make a button on the
bottom bare (where you go from question to question) that gives you access to
the internet is still quite telling. If I instead of making a search button made
a chat button, and designed a chat that used the same fonts, and same style as
Inspera Assessment itself, it would look like just another question page. You
can hide what you're doing in plain sight to the point where people would have
to read the actual text to figure out that something is wrong.

Another option would be to make things invisible by default, such that if you
click a specific set of key combinations the search window pops up, and when you
let go it vanishes. This too would make it almost impossible for invigilators to
figure out that you are cheating.

## What you can't do with this exploit
There are some things that does not work with the code injecting exploit for
various reason, some of which are easy to solve and some of which are not.
Amongst the things that does not not work with the current implementation of the
reverse proxy server is using Google instead of Bing as the search engine for
instance. The reason Google does not work is because they provide a
`content-policy` header that forbids the hosting of their websites inside
`iframes` (which is how I've done it with Bing and Wikipedia). This is however
rather easy to get around, and the solution is the same as what we're already
using to inject code into Inspera Assessment, modifying the response from a
server we don't own. So enabling Google would be as simple as generating a new
certificate, modifying my reverse proxy server to remove a specific server, and
making sure request to Google also go through my reverse proxy. The problem with
this though is that while doing so for one or domains is not too much work,
eventually you would have to make a system that auto-generates certificates for
you (the way fiddle does). Since you don't know which websites uses this
`content-policy` header, you would have to run everything through your reverse
proxy server. For the simple demonstration required in this thesis it was much
easier to just go with Bing that just works as is.

Another thing that this solution does not really help you with is getting access
to local resources. There are a few ways around that which generally involves
writing (or installing) a local web-server that you can browse to access the
files on your harddrive, yet this is cumbersome and would generally only allow
you to access plain text files and not documents such as Word or PDF files. This
too can be done in a browser, but it would require a lot of work. Instead, it
would likely be much easier to just upload your local files to something like
Google Docs, and just navigate to Google Docs during the exam. You would have to
solve the content policy problem, but that would be much easier than figuring
out how to render a PDF or a Word document in the browser.


