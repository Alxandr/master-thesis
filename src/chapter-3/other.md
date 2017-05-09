# Other potential exploits
There are other potential problems with how Safe Exam Browser is built on
Windows. I have not looked at how any of this works on OSX. These has not been
categorized as their own exploits considering the fact that I've already managed
to both run Inspera Assessment without using Safe Exam Browser, and using a
custom version of Safe Exam Browser. However, there is one more inner working
of Safe Exam Browser that is worth taking a short look at, and that's how it
integrates with XULRunner.

## Late updates to XULRunner {#sec:late-changes}
When you launch Safe Exam Browser in it's normal "browser" mode, what happens is
that it reads the config file, then based on the settings set therein it
registers some keyhandlers and modifies some register values, and does other
things to effectively take control over your computer and limit you in what you
can do. Then it takes a bunch of the settings and a generated Browser Exam Key
and writes them to a file. It then launches XULRunner which reads this file and
runs as the "browser component" of Safe Exam Browser (this is what the user
sees). The browser integration is done through a addon written in javascript.

It stands to reason that a simple application could watch this file that Safe
Exam Browser writes and copy it's content before Safe Exam Browser deletes it
again. This would be another way to get the Browser Exam Key automatically. You
could then exit Safe Exam Browser before starting the exam (Inspera Assessment
allows you to do this). Another thing to note is that once the XULRunner config
file has been written, at that point the Browser Exam Key has already been
generated and written to disk, so it would be possible to make changes to
XULRunner at that time. This is unlikely to gain you much more than any of the
other exploits explained in this thesis, but it is still an exploit.
