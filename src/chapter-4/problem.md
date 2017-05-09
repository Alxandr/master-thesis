# Problem with todays solution
Before we can look at possible solutions to the digital exam problem, we have to
take a closer look at the core of the problem, namely the fact that we have a
server (Inspera Assessment) trying to validate what client software (Safe Exam
Browser) is being used. The only way for two parties to have any form of
validation (one or two way) is by way of either a shared secret, or public key
cryptography. In either case the party that is to be validated need to hold some
form of a secret that is either transmitted as is, or some product of it is
transmitted to the other party. In our case that means that for Inspera
Assessment to validate that we are indeed using Safe Exam Browser some secret
needs to be transmitted to Inspera Assessment. This is effectively what happens
with the Browser Exam Key.

The issue however is that we've (by installing Safe Exam Browser) effectively
taken the secret that we use to validate the users, and given it to all the
students. There is no way around this. No matter how well you hide the secret,
at some point in time the secret needs to be available for Safe Exam Browser to
send to Inspera Assessment, and as such at that point it will be available to
the computer it is installed. Now, there are definitely ways it could be made to
be harder to get hold of, but at the end of the day it is accessible if people
have the knowhow to do so. And it only needs to be figured out once. If the
person who figured it out spreads it, that's it. Game over. You have to start
all over with a new way of hiding it. Effectively, any such measure is just
security theater, or security by obscurity. Eventually someone will come along
with the skills to find it, and it might as well not have been hidden in the
first case.

What's usually used to validate clients is public key cryptography (typically
certificates like you'd find on a server). However, this is used to validate
a client, not a client application. It's to validate that I'm me, in other words
there is no problem if I know the secret. The same techniques cannot be used to
validate that the right client application is used.
