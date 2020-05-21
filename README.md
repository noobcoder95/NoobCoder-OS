<h1>README</h1>

A collection of scripts intended for NoobCoder OS development.
List of Scripts:
1. noob boost -> a script that automatically configures and activates zram-swap.
2. noob2hack -> a script that automatically configures and installs the kali-linux repository.

Usage:
- NoobCoder OS: Thoose scripts above are automatically embedded in the '/usr/local/bin/' directory.
                Just run it using the command "sudo <script-name>", e.g "sudo noobbost".
- Ubuntu:       Since NoobCoderOS is built on Ubuntu, the scripts above also run without problems.
                You only need to download the scripts and after that run the command
                "sudo chmod +x <script-name> && sudo ./<script-name>",
                e.g "sudo chmod +x noob2hack && sudo ./noob2hack".
                
NOTE:           After you have successfully run the "noob2hack" script, it's recommended not to
                install packages from the kali-linux repository using the "apt-get install <package-name>"
                or "apt install <package-name>" commands. Instead, use the "aptitude install <package-name>"
                or "noobhack-tools install <package-name>" command.


<h2>NOOBCODER OS</h2>

NoobCoder OS is one of the Ubuntu-based GNU / Linux distributions built specifically
for programmers/developers/software engineers and even reverse engineers.
NoobCoder OS is built-in with several IDEs, SDKs, Frameworks and some tools that are popular
among coders so there is no need to install them manually.
This Operating System uses the "LXQt" desktop environment which is known to have good performance
while still saving resources, and is built based on Ubuntu 20.04 (Long Term Support) with Kernel Version "5.4.0.31".
The initial release of this distribution (NoobCoder OS R1 codename "Alpha") is planned to be released every 2 years
according to the Ubuntu Long Term Support release schedule.
At present, I am still alone as a developer and maintainer of this Operating System,
if anyone is willing to develop the OS and join this project, please contact me.

Download Link: https://drive.google.com/drive/folders/1nmQoc8lMXIMWJLZIahZCOjo1tDAy_zeY?usp=sharing

List of available pre-built programming tools:
1. Editor: Emacs and VIM
2. IDE: Android Studio, QtCreator, IntelliJ IDEA, Codeblocks
3. Compiler, Interpreter, and Frameworks: GNU C/C++ and Fortran Compiler, Clang and Clang++, Java, Golang,
                                          Perl, Python, PHP, Nodejs, MySQL, Ruby, Laravel Kit, Anaconda,
                                          Postman, Redis, BloomRPC, MySQL Workbench, etc.
4. Other tools: OBS Studio, Qemu Virtual Machine, Disk Creator (Balena and WoeUSB), etc.
