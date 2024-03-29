# Looking to Others
NTNU is not the only, nor the first university to attempt to use digital exams,
and other universities across the world have done so using different solutions.
The Lebanese French University in Kurdistan developed their own solution using
normal web technologies and a custom browser implementation written in C#
without the normal close/minimize/maximize buttons normally shown on windows
[@Salim2017]. They claim that by having randomized questions for each student
(delivered from a question database) they can effectively reduce cheating to
almost zero, but do not provide much data to back this claim up. While it's true
that having random questions would prevent the typical "look at another screen"
kind of cheating, it does nothing to mitigate users accessing resources they
should not have access to, online or not. A paper on digital exams at the
University of Southern Denmark (SDU) in Denmark [@Nielsen2014] notes another
potential advantage of having a digital question database in that such a system
can provide statistics over the different questions, such that questions that
everyone answers correctly or nobody answers correctly can be removed. One of
the techniques SDU uses against cheating is anti-plagiarism software. They also
let the students know beforehand that they are using such software, such that
students are less likely to cheat because they know it's more likely that they
will get caught.

In the paper "Challenges of Online Exam, Performances and problems for Online
University Exam" they propose using biometric sensors to authenticate users as a
means to prevent cheating. It also proposes having cameras that can view the
entire lecture hall [@Sarrayrih2013]. The biometric sensor might certainly help
prevent students getting other people to take the exam for them, if that is
indeed a problem, yet we already require student ID to be displayed before
starting an exam. While having a camera in the exam room might prove helpful,
it's unlikely to be much more helpful than having invigilators, and it does
provide some privacy issues considering the fact that the footage may be
recorded.

Swiss Federal Institute of Technology (ETH) Zurich has a rather interesting
approach to preventing cheating at digital exams. While normally they would just
go with a similar setup that NTNU is currently using, on some exams they would
like the students to have access to other applications than a browser, such as
CAD software or similar. Instead of running the LMS directly inside Safe Exam
Browser, they run a remote desktop client which connect to a server they control
and also runs Safe Exam Browser which then connects to the LMS and allows access
to selected client applications on said server [@Halbherr2014].

ETH Zurich also takes snapshots of the screen at regular intervals. However,
these snapshots are never looked at unless requested by the student themselves.
The students are assured that the snapshots will not be used to find cheaters,
and are only there in case something goes wrong during the exam, so that most
of the work can be recovered (in the form of images). This is a rather good
failsafe solution as long as there are strict guarantees that it will not be
used for surveillance.
