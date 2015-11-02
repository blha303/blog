---
layout: post
title: Setting up Boost 1.53 on Ubuntu 15.10 (Wily)
---

Today I decided I would try to get [airdcnano](https://github.com/airdcnano/airdcnano) working on Wily.

The `apt-get install` string on the airdcnano [install guide page](http://www.airdcpp.net/nano-guide) includes `libboost-1.53-dev`, which would work on 14.04 Trusty, but not so much on Wily, because Wily now uses 1.58 which appears to be incompatible. So now I'm building Boost 1.53 on Wily, and here's how you do that:

{% highlight bash %}
# Get boost 1.53 source
wget http://sourceforge.net/projects/boost/files/boost/1.53.0/boost_1_53_0.tar.gz/download -O boost-1.53.tgz
tar zxvf boost-1.53.tgz && cd boost_1_53_0

# As stated at [this page](https://coderwall.com/p/0atfug/installing-boost-1-55-from-source-on-ubuntu-12-04)(kudos to coderwall.com):
# Install tools for building
sudo apt-get install build-essential g++ python-dev \
                     autotools-dev libicu-dev \
                     build-essential libbz2-dev
# Create Boost.Build engine for compiling the rest
./bootstrap.sh --prefix=/usr/local
# Get the number of cpu cores, put this into a variable
n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
# Use all cpu cores to build Boost and install it to
# /usr/local as specified above
sudo ./b2 --with=all -j $n install
# Add /usr/local/lib to library path
sudo sh -c 'echo "/usr/local/lib" >> 
            /etc/ld.so.conf.d/local.conf'
# Reload libraries
sudo ldconfig
# Thanks again to coderwall.com for the above lines, very helpful

# Return to working directory
cd ..
# Get airdcnano source
wget https://github.com/airdcnano/airdcnano/releases/download/1.06/airdcnano-1.06.tar.gz
tar zxvf airdcnano-1.06.tar.gz && cd airdcnano-1.06
# Install dependencies, minus boost, as it's already installed
sudo apt-get install libbz2-dev libncursesw5-dev \
                     scons zlib1g-dev libglib2.0-dev libssl-dev \
                     libstdc++6 libminiupnpc-dev libnatpmp-dev
                     libtbb-dev libgeoip-dev
# Build source using all available cpu cores (Note from airdc:
# each compiler thread requires about 1 GB of free RAM and the
# compiler will crash if it runs out of memory.)
scons -j$n
{% endhighlight %}

Now, normally you'd go on here to `sudo scons install`, but I encountered several errors while building airdcnano and I don't have the skills to fix them at this point. I'll file a bug, or see if someone else has compiled a static binary for airdcnano, or at least one on ubuntu 15.10. In the meantime, I'm glad I got the chance to practice building a major library like Boost.

*Listening to [Dizzee Rascal - Bassline Junkie](https://www.youtube.com/watch?v=D1gl46hh3sQ) (NSFW)*
