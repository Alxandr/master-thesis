# Conclusion
In a society where more and more people are getting higher education, and at the
same time more and more of our daily tasks are performed digitally, exams will
likely have to adapt in order to stay relevant. While teaching methods have
already started to technology in order to teach students the craft they need to
know, given the fact that students are primarily graded based on their exam
results this is also where many of them will put forth most of their efforts.

When people want to take a drivers license, they are tasked with driving trough
traffic with an examiner, not write an essay on how engines work. Yet when a
student wants to certify that he knows how to make webpages, he is asked to draw
by hand how some code would look on screen. In especially bad cases this might
lead to students focusing all of their effort towards the exam, and ending up
with a certification that they possess a certain skill, while in reality they
only know the theory behind it. School is supposed to prepare students for the
work-life, yet if there is a large disconnect between the two that is obviously
a problem.

Some of the reasons high-stakes exams are lagging behind when it comes to
digitalization is the very fact that they are high-stakes. As such we cannot
afford to make errors. In some cases, the outcome of a few exams can literally
change the entire life of a student. Therefore changing the formula that has
been tried and tested for generations is obviously somewhat scary, and has to be
done with great care. And considering the breakneck evolution speed technology
has these days it is not at all weird that high-stakes exams are lagging behind.
Yet evolve it still must, or be faced with the possibility of becoming entirely
irrelevant. If an exam grades you on nothing except that particular exam itself,
then the exam has lost all purpose.

For the reasons mentioned above, it is both important that exams can be done
digitally and that such digital exams are safe and resilient to students
cheating. A goal with the digital exams has been to make sure that they are at
least as hard to cheat in as their pen and paper counterparts. While this is
definitely a tall order, striving towards that goal is definitely not a wasted
effort.

RQ1
: What are technical cheating vulnerabilities of the digital exam solution
  employed by NTNU?

The current digital exam solution employed by NTNU has several security issues
outlined in both this thesis here, and previous papers looking into Safe Exam
Browser. One of the bigger issues is the fact that another person outside the
exam facilities might be taking the exam for you while you're only present at
the actual exam to make it seem like you're doing it yourself. This has even
recently been in Norwegian news [@Bolstad2017]. Most of these issues can be and
are being fixed however. While it's true that there will always be some way for
students to cheat, updates to Safe Exam Browser is making it harder every
update. In my conversations with Inspera Assessment, I was told that planned
updates for SEB may very well prevent several of the exploits I discovered in
this thesis.

It's quite obvious that there are issues in the current digital exam solution
used by NTNU. There have been multiple issues discovered beforehand in other
papers [@Søgaard2015][@Søgaard2016], and there are several discovered in this
thesis. As it stands, currently what's stopping students from cheating at
digital exams are mostly themselves. This is definitely not ideal and there are
several large security concerns that need to be addressed as quickly as
possible.

RQ2
: How can the ability for students to cheat during digital exam solutions be
  reduced sufficiently so that digital exams are no more vulnerable to cheating
  than their pen-and-paper counterpart?

Several of the solutions proposed in \cref{cha:4} would go a long way in solving
the worst issues. Particularly restricting the access to the internet from the
students' computer would prevent any form of outside helping. If done right, it
could also eliminate the possibility of anyone outside the exam facility doing
the exam on behalf of a student.

Another option is to use thin clients owned by the university. As discussed in
[@sec:digital-ways] this has both benefits and disadvantages. However, neither
has been thoroughly analyzed in this paper, and thin clients might have other
really bad security vulnerabilities that have not been considered. In all
likelihood, there is no silver bullet. With exception of some low hanging fruits
such as limiting internet access during the exams, improving security at digital
exams will likely be an iterative process which gets better and better over
time. This is not a process that NTNU is doing alone, there are large amounts of
universities and other educational institutions in the world trying to make safe
digital exams, several of which have been referenced in this thesis.  All of
them have resources allocated to improving the situation.
