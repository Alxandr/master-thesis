# Purely technical solution {#sec:technical}
The digital exam problem is not a purely technical problem, yet it's easy to
look at it as one. If we could discover a purely technical solution that
prevented any sort of digital cheating, that would mean that digital exams are
*at least* as safe as pen-and-paper exams. However, a purely technical solution
that prevents any sort of digital cheating is unlikely to exist, as such we
cannot look at the digital exam problem in a bubble. For the most part, until
now, what I've discussed has been purely technical solutions and problems. I've
stated some statements about how some thing might help keep the fact that you're
cheating hidden, but all in all I've focused entirely on defeating the computer,
not the invigilators.

As stated in [@sec:modifying-lms] some uses of the exploits discussed in
\cref{cha:3} is like asking to be discovered. If you for some reason for
instance use chrome to access the exam, and then at the same time go to YouTube
to look at lectures on the subject while playing audio through the speakers you
would easily be discovered as cheating. This is obviously an incredibly unlikely
scenario though, as someone who manages to figure out how to get the Browser
Exam Key out of Safe Exam Browser and into either a chrome plugin or a reverse
proxy server is unlikely to make the foolish mistake of playing videos on full
blast during the exam. Rather you would want to take any step possible to
prevent others from finding out that you have cheated. For instance, a clever
student could design a chat application that looks like Inspera Assessment.

## Identifying cheating using invigilators
One of the goal of having invigilators at exams is to help prevent cheating.
They make sure that people didn't bring equipment they weren't allowed to, and
that they do not communicate with one another. It stands to reason that
invigilators could also be used to prevent digital cheating. The problem with
relying on invigilators spotting digital cheating though is the fact that there
may not be any audible or visual cues that the computer is doing anything. At
the same time, it's also possible to make the computer put on a show by
displaying on screen actions it's performing, while actually not doing anything.

For instance, if you know what you're doing it should not be all too hard to
pretend to reboot a computer - while in fact not doing so. This can be done
using a virtual machine that you actually reboot, or simply playing a video in
fullscreen. Even, should it be decided that the exam software is to be put on
a memory stick and students have to boot from it, once someone figures out
what's contained on the memory stick it would be possible to write software that
extract any needed secrets from it and then again puts on a show of booting from
the memory stick. And this is all still just in software.

If you were to look at specialized hardware, there is almost no limit to what
people would be able to do. For instance, imagine someone builds a laptop with
two computers inside it, and the ability to toggle between which one is
connected to screen, keyboard and mice. This is not entirely far-fetched, as
there already exists cheap tablet-like units that work like that. However,
custom hardware is also a problem in pen-and-paper exams in that students can
bring specialized hidden cameras and earpieces for instance, to communicate with
people outside the exam. It also requires a rather substantial monetary
investment.

## Cheating software
The problem with software that can be used to cheat is the fact that it can be
replicated indefinitely with next to no cost. Distributing software is fast,
and there is no limit to the amount of copies that can be made. It's also
effortless for the person receiving the copy. If, for instance, I made a custom
version of Safe Exam Browser that had no security implemented but still produced
the correct Browser Exam Key and uploaded it, students would just have to
download my version of Safe Exam Browser instead of the official one.

Because of these reasons what we need is a near-perfect technical solution,
where invigilators can for the most part just fulfill the role they have always
fulfilled. At the same time, we want to reduce the amount of resources one can
get access to using cheating to be as low as possible. With the mindset that
a perfect solution is not feasible, there are steps that can be taken to make
cheating much harder, and at the same time also try to completely limit the
access students has to online resources they should not be able to have access
to unless they have custom specialized hardware.
