# Contributing to Szmelc-ZRC
> Best practices for contributors and creators wanting to share their creations with wider audience at: 
- [ZRC GitHub](https://github.com/Szmelc-INC/ZRC)

> For contributing to our project and community:, 
> Stuff to include in your module to be well written:

### ==== Info Headers ==== 
> Comments on the top of the script to make working with it easier for everyone
~ (Most headers are optional, tho it's nice to make nice for others)

# ======== ESSENTIAL HEADERS ========
- Description: `# DESC:` [<`Shortest possible, yet clear and simple description`>]
- CaTAGory: `# TAGS:` [`WEB`]/[`GIT`]/[`SECURITY`]/[`EYECANDY`]/[`NETWORK`]
- Author:  `# DEV:` [<`Nick` or `Link` to `author`>]
# ======== OPTIONAL HEADERS ========
- Usage: `# EXAMPLE:` [`Examples`, `flags`] / (Can occupy more lines if neceseary)
- Version:  `# VER:` [<`any naming scheme you preffer`>]
- Depencencies: `# DEP:` [`package1`, `package2`, `package3`, etc]
- Conflicting: `# EXCLUDED:` [`<If your code has something that breaks it, please tell people before they find out eventually>`]
- Showcase: `# DEMO:` [<`URL` to `image`, `video`, or `GitHub`>]

---

### Additionally:
- Please, try to use most common wording like categories: 
`https://terminaltrove.com/categories/`
- Comment above each export, alias and function to briefly describe what it doe
- Upload files with `.mod.zsh` extension, and `#!/usr/bin/env zsh` shebang
- Clearly mark user-tweakable variables at the top with comments, e.g.:
- Avoid running heavy or network commands on `source` – put logic in functions
- Modules SHOULD be safe to source multiple times (idempotent):
- If you define keybindings or optional flags, document them in a comment block:
- Please, try to write your code as much 'backwards compatible' with Bash / Sh as possible.
- Describe everything as what it is. Wanna share some of your weird system breaking stuff? Go for it, as long as it is exactly what you claiming it to be.
- Absolutely NO gaslighting, not even as a harmless, joke. It has to be truthfull.
- Yes, you can share code that's not yours, as long as you say whose it is, or credit the Author Unknown.
- If your code does some automated stuff in background like updating, communicating with server etc, you HAVE to state it clearly.

---

## Other ways you can contribute!
> If you really feel like contributing, even tho you don't have any cool stuff to share, 
> we still would appreciate any human help with tasks such as: 
- Veryfying, testing and validating submisions, 
- Filling out missing headers, and comments in submissions,
- Maintaining up to date base of modules, (frequent updates),
Or by simply using modules you liked, and submitting reports if you ever come actoss a bug!
- You can also visit us on GitHub discussions to share your ideas or requests for upcoming features!
