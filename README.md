# Omarchy Rick and Morty Theme

A lab-dark [Omarchy](https://omarchy.org) theme with portal-green chrome, Morty yellow, and cyan energy. For Omarchy Quattro.

![Rick and Morty preview](preview.png)

## Install

```bash
omarchy theme install https://github.com/MattsMacsGit/omarchy-rick-and-morty-theme
```

Or *Install > Style > Theme* in the Omarchy menu (`Super + Space`) and paste that URL.

## Palette

| Role | Hex |
| --- | --- |
| Background | `#090215` |
| Dark background | `#06010f` |
| Darker background | `#030008` |
| Lighter background | `#1a1230` |
| Foreground | `#F4E7C3` |
| Accent | `#97ce4c` |
| Cyan | `#7fede1` |
| Yellow | `#ffe14a` |
| Selection | `#1c1430` |
| Muted | `#6e6480` |

Full ANSI palette in [`colors.toml`](colors.toml). Icons are `Yaru-olive`. Keyboard RGB is portal green.

## Backgrounds

Still wallpapers in `backgrounds/`. Matching portal videos live in `live/` (same stem as the still, `.mp4`). Cycle stills with `Super + Ctrl + Space`.

## Full compositor look

`omarchy theme install` keeps colours, wallpapers, shell, icons, and unlock art. It drops `hyprland.lua` from any cloned extra theme, so the portal pop-in, glow, and frost do not apply by default.

To turn those on after install:

```bash
rm -rf ~/.config/omarchy/themes/rick-and-morty/.git
omarchy theme set rick-and-morty
```

That treats the theme as your own copy. You lose `omarchy theme update` for this theme; pull new files from the repo by hand if you want them.

Live portal videos play only if you also have a shell plugin that reads `live/<still-stem>.mp4` when the desktop is clear.

## Fan work

Rick and Morty is owned by Cartoon Network / Adult Swim. This is unofficial fan work, not affiliated with or endorsed by the rights holders.
