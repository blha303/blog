---
layout: post
title: Life Is Strange Server Investigation
---

![Stats screen for first episode](http://i1065.photobucket.com/albums/u395/noothere/Life%20Is%20Strangetrade_20150131152817_zps4d21vm40.jpg)

Six months ago I decided I would try to see how the game Life Is Strange displayed choice statistics ingame. I hadn't used man-in-the-middle software before, but looking under the hood of websites to [see](https://github.com/blha303/getlyrics) [how](https://github.com/blha303/watchshow) [they](https://github.com/blha303/factorio-serverlist) [work](https://gist.github.com/blha303/a3aa964af48378768aab787daaaab8c7) and using that to build integrations with other services (usually my IRC bot) has kinda been what I've been doing for years now. I'm [unemployed](https://stackoverflow.com/story/blha303) if you're wondering.

I [wrote up all relevant information](https://gist.github.com/blha303/101e0db0bf63ea07b1f55862947c9065) back when I did this research six months ago, but I thought I'd take you through the process when I was setting this up. Initially I had no clue what I was doing, I started off trying to use packet capture software like Wireshark to see the traffic, but Wireshark is really not meant for inspecting TLS traffic and seems to be [just generally kinda shit anyway](https://gist.github.com/blha303/724bcc828da9a29947c39e168a540b7a) so I moved on to [mitmproxy](https://mitmproxy.org/), a program I had heard a lot about before. After a lot of fiddling, I got it set up on my laptop and set the gateway on my desktop to send traffic through the proxy.

I used the Linux version of Life Is Strange because 1. my desktop was Linux at the time, and 2. it had a shell script that launched the game and initialized SSL certification checking, which is far easier to override than whatever Windows uses. After changing the certificate line to point to mitmproxy's generated cert, I started the game. I [documented the game's requests](https://gist.github.com/blha303/101e0db0bf63ea07b1f55862947c9065#on-game-start) from startup to going through the choices screen to closing, with my theories on what each request does. The thing I was looking for was `/game/CommunityFactsGetEpisode`, which returns a [list of choices](https://gist.github.com/blha303/cec90d1d2e351c33d39ddddd880cd252) you can make in the given episode and the number of people that chose it.

After I'd achieved my goal I continued investigating their server and discovered a couple very interesting methods.

* [`/game/os_GetServiceInfo`](https://gist.github.com/blha303/8c5b925f95c23c08197ac3a82e1bee15), information about the server and a [list of every endpoint the server accepts and the authorization required to use it](https://gist.github.com/blha303/101e0db0bf63ea07b1f55862947c9065#file-zgenerateddocs-md). I used this to generate API documentation automatically and went exploring. The folk in the IRC channel for /r/reverseengineering recommended that I don't publicly describe any API endpoints that aren't accessed by the game in normal operation, but I wanted to mention one in particular... There's an API endpoint that returns the server changelog.

![changelog]({{ site.baseurl }}/images/lis-changelog.png)

Now, this may border on stalking, but I was curious who these Eidos employees are.

* First, "edule" who pushed dozens of commits over the course of a year. Searching for "e dule eidos" returns the Life Is Strange credits, where it shows that "e dule" is Erida Dule, the Online Service Programmer. Her LinkedIn says she worked for Eidos Montréal from Aug 2014 to Aug 2015, which fits with the timespan on the commits visible in the changelog. Judging by the names on every commit for the course of that year, she seems to have singlehandedly created the LIS stats server.
* Occasionally there are commits by "mgregoire", who must be Maxime Grégoire, a Senior Online Service Programmer.
* After Aug 2015, there's one commit in November by 'gpetit', Gaspard Petit. I can't find much about him related to LIS, except that he's in the credits of Deus Ex: Mankind Divided as a Lead Programmer.
* "ehayut" is Elliot Hayut, an Online Programmer who pushed two changes to hide information from the API response.
* "aterrienne" is Antoine Terrienne. He pushed one change adding Feral authentication, two months before Life Is Strange was announced for OSX and Linux. Like Gaspard Petit, there's not much on him related to LIS, but he's also in the credits for Deus Ex: Mankind Divided.

It was a lot of fun researching the stats server used by Eidos to track what people do in Life Is Strange, it's a lot more complex than I thought. Seems to have a lot of really interesting methods hidden behind authentication, like "UpdateInfocast Messages", "DeleteUserProfile" and "os\_CreateABTest". Please leave any questions in the comments below or on [reddit](https://reddit.com/domain/blog.b303.me), and thanks for reading.
