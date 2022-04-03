# Awesome Window Manager Configuration

1. [Awesome Window Manager Configuration](#awesome-window-manager-configuration)

   1. [Introduction](#introduction)
   2. ["What's With All the Comment Blocks"](#whats-with-all-the-comment-blocks)
   3. [Testing Changes](#testing-changes)
   4. [Eternally Work in Progress](#eternally-work-in-progress)
   5. [Gallery Coming Soon](#gallery-coming-soon)
   6. [Neumorphic Design](#neumorphic-design)
   7. [Inspirations](#inspirations)

This flying spaghetti code monster is my configuration of AwesomeWM manager,
taken in small and large part from other configurations and libraries then
welded together in a way I find pleasing and effective in accomplishing my daily
needs with my systems. While an opinionated configuration of a truly excessive
size, I have focused on its overall functionality and adaptation to my ever
shifting patterns of use such that it is likely useful to others configuring
their own AwesomeWM environment as an example/template if nothing else.

**_To me_**, sharing this code for others to use as they see fit is what open
sourced technology is all about and I firmly believe that _a rising tide lifts
all ships in harbor_ Just the same, this is not set up as a library, so adapting
pieces of it will require you to put in the elbow grease, especially since I use
a config wide method of including libraries and modules since that is a little
easier than repeating the same`local awful = require("awful")` &
`local beautiful = require("beautiful")` at the start of each file.

---

## Introduction: What This Repository Is

### AKA the Whole Enchilada Grande

This is a configuration for Awesome Window Manager, a dynamic window manager
that blends together the features of a floating and tiling window manager.

Unlike the traditional stacking, or floating, window managers most are
accustomed to, Awesome can handle placing new windows on screen by tiling, or
subdividing the screen according to one of several patterns, which the user can
change at will during runtime.

Awesome has a robust means of handling floating windows as well, which can be on
screen with tiled windows simultaneously. Additionally, unlike almost any
alternative, AwesomeWM provides an expansive, if mostly undocumented and
disorganized, API to allow the user to customize and extend the window manager
according to the user's wants, needs and whims **but at the cost of blood, sweat
and tears... many, many tears**.

AwesomeWM is extended using the Lua language, which is designed for the purpose
and also used in a similar manner to configure NeoVim, the Luakit browser, the
`tym` terminal I recently discovered and a litany of other uses I am ignorant of
entirely. Lua itself is a relatively easy language to pick up, in combination
with the API things are a bit more complex, but overall it rather a slick
language I have come to love in the process of writing this configuration.

This repository is one such attempt at welding together something useful and as
fully featured _as I want to use locally, or at least can tolerate maintaining_.
**Feel free to use what you would like from it,** I have ridden on the backs of
giants finishing this project, see below for some of the configurations I owe
the eternal gratitude to their developers for giving me the ability to see,
evaluate, scrap useful pieces out of and ultimately rewrite their source code,
it is only right to give back to the open source community when I have
benefitted this much (having assembled a desktop environment I actually enjoy
using and find useful).

Ultimately this configuration, as the centerpiece of my world as a Linux user,
is the center also of my personal distro **The Electric Tantra Linux** (at least
until I get around to forking and modifying InstantWM and InstantDE to my
liking).

---

## Design Considerations

I am also a web developer with a fixation on interfaces that are attractive and
easy to use, so I throw in a bit about the standards I am trying to make this
configuration conform to.

- **Keyboard & Mouse Driven** - adaptive to different workflows, not 100% but should be sooner or later 
- **Prefer Internal Components to External Programs** - exceptions apply
- **Custom base16 Color Scheme, GTK Theme, Icon Theme** - a fully curated UI

## Testing Changes

If you do plan to adapt this to your own purposes, I would advise you use the
tool `awmtt` which is easy enough to find on Github but I use a copy I keep in
my [local scripts](https://github.com/Thomashighbaugh/bin)

A handy little trick for those using the program "awmtt" to debug their changes
to their configurations is creating a symlink from your `rc.lua` file to the
test file expected by awmtt, which is `rc.lua.test`. To do this just enter the
command below in the `$HOME/.config/awesome` directory:

```bash
$ ln -svf rc.lua rc.lua.test
```

## Eternally Work in Progress

Upon the first release, which is upcoming still at the time of writing, there
will still be some work left that if you want to help by contributing pull
requests,please do it is much appreciated. A list of work to do is at the top of
the `CHANGELOG.md` file found in the `.github` directory. There you will also
find the contribution guide, which I would appreciate if you read as such will
save us both time and energy if you followed as I would not need to then
reformat anything, but either way I would still be happy for the help.

Regardless if you donate your arms or not to the collosal effort this
configuration is for me at least, know that this is my personal environment and
as such, due not to want of decisiveness but instead ever more exacting taste in
various aspects of my desktop, it is constantly subject to my tinkering and
radical rewriting tangents if I feel so compelled. While the hope is mitigating
this latter potential to the greatest potential possible, it is not a precluded
possiblity and I advise you plan your use of this code accordingly.

## Gallery Coming Soon

## Skeduomorphic Design

![Skeudomorphic buttons from the wibar](/.github/assets/skeudomorphic_buttons.png)

> from the wibar, these panel items illistrate the 3D effect

After getting enraged in the way all Linux users know only too well and
attempting to deduce if Neumorphism was possible in a `AwesomeWM` configuration
(its not actually possible in an Xorg environment as you can't differenate the
shadow colors on half of the sides of an object, Wayland I don't know and
honestly with the state of Wayland today, I don't really care either. I'll keep
my Nvidia cards, thanks). The result discovering that I could relatively easily
produce the much more tasteful precursor thereof relatively simply using a
gradient applied as a background using the builtin Cairo support Awesome's API
exposes with a relatively cryptic entry in its documentation about. The key to
the appearance of skeduomorphism is to pick a color (for the background of an
object) and use a linear gradient that places at the zero the color you choose
and then a darker shade of that exact same color at 1 position (or vice versa).
Then to make the object appear to be a button with its own dimensions (what
Skeduomorphism is doing), one must simply should add a dark border around the
object that is thin.

To give you a sense of what this appears as in code check out the below examples
from this configuration's source code.

```lua
-- from theme/default-theme.lua
-- this applies the background at the root of the effect
theme.bg_normal = 'linear:0,0:0,21:0,#484d5e:1,#272A34'
theme.bg_focus = 'linear:0,0:0,21:0,#555e70:1,#323643'
-- ################################################################
-- ################################################################
-- ################################################################
-- from module/clickable-container.lua
   local container =
        wibox.widget {
        widget,
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4)
        end,
        bg = beautiful.bg_focus,
        border_width = dpi(2),
        border_color = '#1b1d2488'
    }
```

---

## Inspirations

#### In No Particular Order

Here are some of the repositories I owe my eternal gratitude and appreciative
awe to as these are the repositories that served as the models, code stock and
examples that made Awesome's awful documentation more comprehensible and enabled
me to achieve this level of functionality.

- [Awedots by Javacafe](https://github.com/JavaCafe01/awedots)

  - an excellent code base that re-imagines many of the features of elenapan and
    the glorious dotfiles with some unique, more maintainable approaches and one
    of the authors of bling, so it is integrated into the configuration if you
    are into that sort of thing

- [dotfiles by elenapan](https://github.com/elenapan/dotfiles)

  - The OG which showed me for the first time the potential of AwesomeWM and
    began this quest. While her directory naming scheme is... unique,,, the
    quality and general functionality of her code is magnificently enhanced by
    high quality documentation that is available **no where else**.

- [Tom Meyers' TDE, part of TOS](https://github.com/ODEX-TOS/tos-desktop-environment)

  - The most expansive configuration imaginable that served to inspire my
    approach immensely even if more fully featured than I would ever try to
    maintain. Meyers does great work, highly underrated

- [William McKinnon's AwesomeWM Configuration](https://github.com/WillPower3309/awesome-dotfiles)

  - A really humble and awesome dev with a really well manicured configuration
    which also features ASCII art at the head of each file. Very good color
    schemes and icons to match, great functionality. Good starter template for
    newbies - -

- [manilarome's glorious dotfiles](https://github.com/manilarome/the-glorious-dotfiles)

  - While his sense of humor differs from my own in a significant manner, this
    configuration serves as most others skeleton in organizing their code, with
    my configuration not being different in this respect. An extremely important
    configuration with some really good code and great start to your own
    configuration

- [dotfiles of Szorfein](https://github.com/szorfein/dotfiles)

  - While it suffers in the organization department, there are probably no
    better than aesthetics in AwesomeWM than Szorfein's work which may be of
    particular interest to the security minded

- [The Bling Library](https://github.com/BlingCorp/bling)

  - While some (most) of the features I was interested come bundled with bloat
    that I find is wholly unnecessary for my purposes, there is something to be
    said about the high quality code that can easily be modified for local use
    with a little elbow grease and the contributors have great configurations to
    check out too. - -

- [awesome-shell](https://github.com/Mofiqul/awesome-shell)

  - Another high quality configuration that seeks to craft an interface familiar
    to users of mobile platforms and other operating systems that skips on
    little in terms of features while having low overhead and a rational
    approach to code organization

- [Kotbaton's Configuration](https://github.com/kotbaton/awesomewm-config)

  - Really high quality code in this one that's easy (for me ) to comprehend
    what the author's intentions were and easily ported to your configuration.
    Source of some of my custom layouts - -
    [hh-awesome](https://github.com/jaypei/hh-awesome) - Intended to be used as
    a skeleton, describes itself as a framework for an Awesome config. - -

- [Jeremie1001's awesome-dotfiles](https://github.com/Jeremie1001/awesome-dotfiles)

  - Personally I dislike the dracula theme, the nord theme, the catpu-whatever
    theme, they all suck in my view. However this config is top knotch (even if
    winning no awards for its name) and many of the features are implemented in
    a sane way, with scaffolding already in place for a more extensive future
    that certainly is looking bright. Great quality work, many snippets stolen
    from here.

- [My Github List of AwesomeWM configurations](https://github.com/stars/Thomashighbaugh/lists/awesomewm)
  - Github implemented a list functionality recently I find very handy in
    keeping track of these things, which you can find above. I only add
    configurations that are more than one file (or a clone of awesome-copycats)
    and generally the theme has to interest me in some way (though I also use
    stars and lists as a reminder of having seen something before). I also add
    modules/widgets and other awesomewm related stuff to the list constantly so
    its worth checking out periodically as I will keep track of these things
    obsessively regardless.

I definitely missed some, if you can think of one just open an issue to tell me
and I will add it to the list.
