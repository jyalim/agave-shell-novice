---
title: "Introducing the Shell"
teaching: 5
exercises: 0
questions:
- "What is a command shell and why would I use one?"
objectives:
- "Explain how the shell relates to the keyboard, the screen, the operating system, and users' programs."
- "Explain when and why command-line interfaces should be used instead of graphical interfaces."
keypoints:
- "Explain the steps in the shell's read-run-print cycle."
- "Most commands take options (flags) which begin with a `-`."
- "Identify the actual command, options, and filenames in a command-line call."
- "Explain the steps in the shell's read-run-print cycle."
- "Demonstrate the use of tab completion and explain its advantages."
keypoints:
- "A shell is a program whose primary purpose is to read commands and run other programs."
- "The shell's main advantages are its high action-to-keystroke ratio, its support for
automating repetitive tasks, and its capacity to access networked machines."
- "The shell's main disadvantages are its primarily textual nature and how
cryptic its commands and operation can be."
---
### Background

Humans and computers commonly interact in many different ways, such as
through a keyboard and mouse, touch screen interfaces, or using speech
recognition systems. The most widely used way to interact with personal
computers is called a **graphical user interface** (GUI).  With a GUI,
we give instructions by clicking a mouse and using menu-driven
interactions.

While the visual aid of a GUI makes it intuitive to learn, this way of
delivering instructions to a computer scales very poorly.  Imagine the
following task: for a literature search, you have to copy the third line
of one thousand text files in one thousand different directories and
paste it into a single file.  Using a GUI, you would not only be
clicking at your desk for several hours, but you could potentially also
commit an error in the process of completing this repetitive task. This
is where we take advantage of the Unix shell.

The Unix shell provides both a **command-line interface** (CLI) and a
scripting language, allowing such repetitive tasks to be done
automatically and fast.  With the proper commands, the shell can repeat
tasks with or without some modification as many times as we want.  Using
the shell, the task in the literature example can be accomplished in
seconds.


### The Shell


The shell is a program where users can type commands.  With the shell,
it's possible to invoke complicated programs like climate modeling
software or simple commands that create an empty directory with only one
line of code.  The most popular Unix shell is Bash (the Bourne Again
SHell --- so-called because it's derived from a shell written by Stephen
Bourne).  Bash is the default shell on most modern implementations of
Unix and in most packages that provide Unix-like tools for Windows.

Using the shell will take some effort and some time to learn.  While a
GUI presents you with choices to select, CLI choices are not
automatically presented to you, so you must learn a few commands like
new vocabulary in a language you're studying.  However, unlike a spoken
language, a small number of "words" (i.e. commands) gets you a long way,
and we'll cover those essential few today.

The grammar of a shell allows you to combine existing tools into
powerful pipelines and handle large volumes of data automatically.
Sequences of commands can be written into a *script*, improving the
reproducibility of workflows.

In addition, the command line is often the easiest way to interact with
remote machines and supercomputers.  Familiarity with the shell is near
essential to run a variety of specialized tools and resources including
high-performance computing systems.  As clusters and cloud computing
systems become more popular for scientific data crunching, being able to
interact with the shell is becoming a necessary skill.  We can build on
the command-line skills covered here to tackle a wide range of
scientific questions and computational challenges.

Let's get started.

If you haven't already, please connect to Agave using your asurite
username and password. It is recommended that you use the Agave webapp
[https://login.rc.asu.edu](https://login.rc.asu.edu) to connect to the
cluster. Once signed in, navigate to the `Clusters` option in the
navigation bar at the top of the webpage, and select 
`>_ Agave Shell Access`. This will open a shell session for you on one
of Agave's 'head' nodes.

When the shell is first opened, you are presented with a **prompt**,
indicating that the shell is waiting for input.

~~~
[rcjdoeuser@agave1:~]$
~~~
{: .language-bash}

This **prompt** is conveying a bit of information as it waits for user
input. In the square brackets are the username `rcjdoeuser`, the
head node's **hostname** `agave1`, and the current directory the shell
is residing in `~` (`/home/rcjdoeuser`). The `@` is used to delimit (or
separate) the username from the hostname, and the `:` is used to delimit
the hostname from the current filesystem path.  Typically a `$` is used
as a prompt suffix to indicate a Bash shell as a non-admin user.

For simplicity, in the examples for this lesson, we'll truncate the prompt
to `$ ` to indicate shell commands.  Most importantly: when typing
commands, either from these lessons or from other sources, *do not type
the prompt*, only the commands that follow it.

So let's try our first command, `ls` which is short for list.  This
command will list the contents of the current directory:

~~~
$ ls
~~~
{: .language-bash}

~~~
perl5/ Desktop/
~~~
{: .output}

New users on Agave will likely see only the `perl5/` directory as output
when running `ls` for the first time. This is a default directory
generated for the user which should not be used directly by the user.
More experienced users may have already created directories, such as
`Research/`, which would be listed with the above command as well.

> ## Command not found
> If the shell can't find a program whose name is the command you typed,
> it will print an error message such as:
>
> ~~~
> $ ks
> ~~~
> {: .language-bash}
> ~~~
> ks: command not found
> ~~~
> {: .output}
>
> This might happen if the command was mistyped or if the program
> corresponding to that command is not installed.
{: .callout}


## Nelle's Pipeline: A Typical Problem

Nelle Nemo, a marine biologist, has just returned from a six-month
survey of the [North Pacific
Gyre](http://en.wikipedia.org/wiki/North_Pacific_Gyre), where she has
been sampling gelatinous marine life in the
[Great Pacific Garbage Patch](http://en.wikipedia.org/wiki/Great_Pacific_Garbage_Patch).
She has 1520 samples that she's run through an assay machine to measure
the relative abundance of 300 proteins.  She needs to run these 1520
files through an imaginary program called `goostats` she inherited.  On
top of this huge task, she has to write up results by the end of the
month so her paper can appear in a special issue of *Aquatic Goo
Letters*.

The bad news is that if she has to run `goostats` by hand using a GUI,
she'll have to select and open a file 1520 times.  If `goostats` takes
30 seconds to run each file, the whole process will take more than 12
hours of Nelle's attention.  With the shell, Nelle can instead assign
her computer this mundane task while she focuses her attention on
writing her paper.

The next few lessons will explore the ways Nelle can achieve this.  More
specifically, they explain how she can use a command shell to run the
`goostats` program, using loops to automate the repetitive steps of
entering file names, so that her computer can work while she writes her
paper.

As a bonus, once she has put a processing pipeline together,
she will be able to use it again whenever she collects more data.
