# Solvable Problems
It's important to take a step back and look at the overall problem we're trying
to solve here. It's very easy to start asking questions such as "how can we make
sure students are using Safe Exam Browser when connecting to Inspera
Assessment?"(or any other LMS for that matter), but that's not really the issue
at hand here. Another question to ask is "how do we prevent code injection into
Safe Exam Browser?". This is actually a rather easy problem to solve as Safe
Exam Browser supports specifying which certificates it should support. I have
not been able to test this functionality because it would require me to modify
the Safe Exam Browser config file which would result in a different Browser Exam
Key being generated, but according to documentation it should work. But again,
this is not really the right question to ask.

It's very easy to be blinded by what we have now, and only look for solutions to
the immediately discoverable issues, and try to patch things to work as
intended. That is not to say that we need to replace/rewrite everything, far
from it, but the questions needs to be framed with the actual goal in mind, not
what we think is the solution.

The original goal of the digital exam solution we have at NTNU is to facilitate
digital exams on students own laptops, in which it should be hard to cheat.
Preferably as hard as it is to cheat at a pen-and-paper exam. And in this case,
by cheat we mean gain access to resources that has been deemed illegal to access
during the exam.

## Preventing Access to Online Resources
The most damaging resource students can get access to during exams, and the
easiest resource to block is arguably the internet. By simply disconnecting the
students from the internet a whole slew of resources would be unavailable for
the students. They would be unable to search for answers online, they would be
unable to communicate with eachother, or outsiders etc. As noted by Thea, doing
so would prevent several classes of exploits [@Søgaard2016, pp. 67].

The problem is that Inspera Assessment runs over the internet, so simply cutting
internet access is not really a solution. Also, cutting internet access
completely might actually make it easier to get around the restriction, than
having restricted internet access. My suggestion is using a specialized router
for the exams which has been set up in such a way that it can only access a
whitelist of IP addresses (such as the LMS website). This way, it would be easy
to say that students are allowed to access online resources that are needed for
the exam, but students will not be allowed to access anything else.

The reason why this is better than simply cutting internet access and running
everything locally is the fact that most people nowdays has smartphones that can
be used as wireless access points. But not many people have computers capable of
connecting to two different wireless networks at the same time. The other part
of the puzzle is that by forcing all the students to connect through a single
router, all of them can be given the same public IP address. This would mean
that we can validate on the server that the students are in fact connecting
through the restricted network (instead of just using the cell phones as a
router).

Next, the LMS needs to be designed in such a way that it can notice when
connection to the client is lost (this should be fairly easy to do). After the
LMS notices that a client has disconnected for more than a few seconds, it
should notify the invigilators and they can go check if the student is doing
anything he shouldn't, or if he simply lost his internet access. While this
may mean that a student with a bad wireless card may get visited by the
invigilators a few times during an exam, this should be a rather small price to
pay.

In terms of hardware/setup, this is also not a very costly solution. It's much
cheaper than providing computers for each of the students during the exam. At
the same time, it increases the difficulty of accessing online resources without
being caught to the stage of needing custom hardware to do so (for instance a
computer with two wireless network cards).

## Preventing Access to Local Resources
It's likely not doable in any good way to prevent access to local resources. In
all likelihood, Safe Exam Browser already does as good a job as can be done. You
could arguably change Safe Exam Browser to some bootable examination system
given to the students on a memory stick during the exam, but as explained in
[@sec:id-invigilators] at the end of the day it's a security theater. At some
point students will figure out how to get around it, and it'll be impossible to
create a new system for every exam. A student could for instance very easily
copy the content of the flash drive before booting from it, in which case he
would have ample time to analyze the content later and figure out how to work
around it.

Invigilators would probably be able to spot if someone does something stupid,
like open an easily recognizable application like Microsoft Word during the
exam. Considering, however, that the student took the effort to figure out how
to get access to local resources during the exam, it's unlikely they didn't also
take the time to figure out what local resources they could access without
raising any flags.

## Anti-Plagiarism Software
The University of Southern Denmark has been successful in using anti-plagiarism
software in order to catch students who have cheated on digital exams
[@Nielsen2014]. Anti-plagiarism software can be a useful and automated tool to
flag potentially cheating students, after which a manual investigation can be
started. This is most useful however, in exams where students are allowed
access to learning resources, online or not. The software might also be able
to flag if two or more students are collaborating in some way during the exam.
The paper on digital assessments at the University of Southern Denmark also
states that the anti-plagiarism software has a preventative effect on cheating
in that the students know that there is a higher chance of getting caught. No
data is provided to support this claim however.
