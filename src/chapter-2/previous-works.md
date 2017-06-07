# Previous Works
This paper is built on previous research into SEB and digital exams already
performed by other students at NTNU. Several attempts on working around Safe
Exam Browser by way of tools such as remote desktops, virtual machines, etc.
have been attempted [@Søgaard2015][@Søgaard2016]. Attempts have also been made
at modifying Safe Exam Browser such that security measures could be toggled off,
therefore I was initially not going to look at this. However, during my attempts
at accessing Inspera Assessment without using Safe Exam Browser, I looked at the
source code for Safe Exam Browser to understand how it generated the Browser
Request Hash to figure out why my code wasn't working. Looking at the code I
hypothesized that it would actually be doable to use a modified version of Safe
Exam Browser and have it generate the same Browser Request Hash, and some quick
testing later proved that to be the case.

## Cheating in Digital Exams
Another thing to look at is how prevalent cheating is in digital exams as
opposed to pen-and-paper exams. There have been multiple studies done on the
topic, and the results are somewhat conflicting. A study on academic honesty and
online learning found no significant differences in cheating behavior of
students between digital and pen-and-paper exams [@Grijalva2006]. Another study
on distance learning the same year found that "most students cheat", and that
they are more likely to cheat online [@Lanier2006]. However, this study covers
student behavior in general, with questions about cheating during a course in
general, not specifically at exams.

A newer study from 2009 found the opposite result, that students were more
likely to cheat on traditional courses than online courses [@Stuber-McEwen2009].
The study also provided the probability of students cheating on tests, which was
$0.0013$, as opposed to any form of academic cheating which was much higher.

A fourth study found only a small difference between cheating on live vs. online
classes, with $32.1\%$ cheating in live classes, and $32.7\%$ cheating on online
classes [@Watson2010]. This study also conflates cheating on tests and
assignments. Students were also asked whether they themselves thought that they
and others would be more likely to cheat in online or live classes, in which an
overwhelming majority of the students thought that they or others would be more
likely to cheat in online classes. Since however, the data doesn't necessarily
support this, it might be a conception issue, or it may just be that digital
exams are too new so people haven't had the opportunity to cheat on them.

