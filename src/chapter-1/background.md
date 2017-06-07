# Background
Digital exams in and of themselves is not a new concept. The fact that we do
everything else on a computer today inevitably leads to the desire for the exams
themselves to be done digitally. Digital exams comes with several advantages
over pen and paper exams. Some of these advantages include but are not limited
to [@Sindre2015][@Hillier2015]:

* People might be more used to writing on computers than with pen and paper.
* No need to use large amounts of paper for the exams . Both the questions and
  answers are provided digitally, instead of using what is probably thousands of
  pieces of paper per exam.
* Remove possibility of exam papers getting lost, wrong papers (like the answers
  instead of the questions) being given to the students.
* A lot of user errors might become impossible when a computer system can
  dictate what action can be done at what time.

However, just because digital exams can provide advantages over pen and paper
exams does not mean that they are the be-all and end-all for exams, and that
simply making the exams digital would solve all problems exams today faces.
While it is true that a good amount of problems with pen and paper exams might
be mitigated by making them digital, digital exams provide their own set of
challenges and issues. Some of these are simply new logistical challenges like
the fact that all students are suddenly required to have a laptop available for
taking the exam (something that most people do have today, but nonetheless a few
might be excluded). Another issue is that the software used for the exams (Safe
Exam Browser) does not currently support Linux, meaning that people who do use
Linux on their computers (which for university students is probably a higher
percentage than for the general populous) might have problems taking the exams.
Another issue is the fact that the exams can only be held in a room with enough
power outlets for all the students. Other errors might include:

* Power outage. Exams might not be doable because of a power outage preventing
  people from using their computers. Today however this is highly unlikely, not
  to mention the fact that even though it is technically doable, one might not
  want to do pen and paper exams during a power outage either.
* Internet failure. Same as with power outage, if the internet is down for some
  reason then exams cannot be executed. This is slightly more likely than a
  power outage, but still highly improbably in Norway today. However, this is
  something which could make digital exams impossible to perform while having no
  impact at all on pen and paper exams.
* Software failure. Problems with the LMS (Inspera Assessment in the case of
  NTNU) can result in people being unable to take the exam, or worse
  displacement/mismanagement of the results. It could also result in people
  being given the wrong exams or no exam at all. And if the LMS had a security
  breach, a student might be able to alter his/her responses after the exam has
  ended (when said student has regained access to the course book and/or other
  learning material).

Another very real issue with digital exams is that they introduce new ways by
which students might attempt to cheat at exams, which is mainly what I'll be
looking at in this paper.

## Different Ways to do Digital Exams {#sec:digital-ways}
The solution currently employed by NTNU to facilitate digital exams is based on
students bringing their own devices and then running software specified by the
university to execute the exam. This is known as "bring your own device" or BYOD
exams. An alternative to BYOD exams might be to build a computer lab and fill it
with university owned computers or thin clients. Another different approach is
simply having home exams. Each of these approaches has their own benefits and
drawbacks, some of them being:

### Cost
Building out a computer lab and filling it with screens, keyboards, and
computers (even if they are thin clients) can be very costly. Not to mention the
fact that there is a high upkeep in that computers needs to be kept up to date,
and that thousands of students using them every year might result in a high
degree of wear resulting in things having to be replaced often. Another less
visible cost is the fact that in order to run a lab of computers, staff that
knows how to set them up and manage them is required. As opposed to simply
buying computers which is a one-time cost (if we ignore the need to ever replace
any of them), having to pay several full-time employees to manage the computers
might be just as expensive.

On the other end of the scale, you have home exams, which depending on the exam
in question might be entirely automated. In the case of a multiple choice exam
for instance, students could sign in from home during the right time window,
answer the questions, and the computer could immediately let them know what
grade they achieved. There would be no need to pay for invigilators, examiner or
locale. BYOD exams are somewhere in the middle of the two.

In a BYOD exam, the university needs to provide a place to house the exam, and
invigilators. This is the same cost as with traditional pen and paper exams
though. However, with pen and paper exams, students don't typically need access
to a power outlet. Another factor in the cost of a BYOD exam is that sometimes
things go wrong, and there is a problem with a students' hardware and its
compatibility with the software required to run the exam. In such cases, the
university is likely expected to provide a small number of computers or thin
clients to enable these students to also take the exam. However, this is still
much cheaper than having to provide a separate computer for each student.

Another factor of the cost is who creates and manages the software used to
perform the exams. Creating robust software is not cheap, and requires both time
and money. It also needs to be maintained over time, and likely also evolved to
fit new needs that arise along the way.

### Required Expertise
If the university wants to run its own in-house service solution for digital
exams it needs server administrators that know how to ensure that everything is
running smoothly, and what to do when an error is encountered. In the case that
the university wants to run its own computer lab, skilled technicians are
required to manage the computers and the network required for all of them to be
connected to the internet.

Even in the case where the home exam solution is opted for, a certain degree of
expertise is needed. After all, exams still need to be made, users need to be
given access the exams, and answers to the exams needs to be graded. While a
large part of the responsibility can be outsourced to another company, someone
at the university needs to know who things work. This is the case though,
regardless if the solution is made in-house or purchased from a third party.

### Security
Security can have several meanings depending on the context. When talking about
an online exam solution, hacking is a security concern. If the exam solution is
offline however, and the exams are either handled entirely on the clients, or on
a closed intranet, the risk of external hacking can be entirely eliminated.
Security in the context of digital exams can also mean how hard it is to cheat
at the exams. With home exams for instance, it's notoriously hard to prevent
certain kinds of cheating, such as collaborating with other people. It's next to
impossible to verify that the student taking the exam is doing so alone without
having some kind of surveillance, which to a large extent defeats the whole
point of home exams. Collaboration is much harder to do during an exam where the
students are placed in the same room with oversight from invigilators.

There are many more ways students can cheat during digital exams, several of
which have been looked at by previous papers [@Søgaard2015][@Søgaard2016], and
several others that will be examined in great detail in this thesis.

## Bring Your Own Device (BYOD)
This thesis is primarily focused on the current solution to digital exams
employed by NTNU, namely a BYOD solution using Safe Exam Browser and Inspera
Assessment. Most of the issues and exploits discussed in this thesis are
therefore only present during this form of examination. No assumption should be
taken regarding the validity of any of the exploits discovered during this
thesis using any other form of digital examination.
